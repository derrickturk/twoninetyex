# (c) 2023 terminus, LLC
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import json
import warnings
from datetime import date, datetime

from typing import Any, Iterator, NamedTuple, TextIO, TypedDict


with open('json/TwoNinetySeven.json') as f:
    SPEC297 = json.load(f)

RECORDS_BY_INDICATOR = { r['indicator']: r for r in SPEC297['records'] }

# longest-to-shortest, then alphabetical
INDICATOR_ORDER = sorted(
  RECORDS_BY_INDICATOR.keys(),
  key=lambda i: (-len(i), i))


class FieldSpec(TypedDict):
    description: str
    type: str
    position: int
    length: int


class Record(NamedTuple):
    indicator: str
    type: str
    contents: dict[str, Any]


class LatitudeDMS(NamedTuple):
    degrees: int
    minutes: int
    seconds: int


class LongitudeDMS(NamedTuple):
    degrees: int
    minutes: int
    seconds: int


def convert_field(ty: str, val: str) -> Any:
    match ty:
        case 'Alphanumeric':
            return val
        case 'Numeric':
            return float(val) if val != '' else None
        case 'MonthYYYYMM':
            return datetime.strptime(val, '%Y%m') if val != '' else None
        case 'DateYYYYSlashMMSlashDD':
            return datetime.strptime(val, '%Y/%m/%d') if val != '' else None
        case 'DateYYYYMMDD':
            return datetime.strptime(val, '%Y%m%d') if val != '' else None
        case 'G2':
            return (
                LatitudeDMS(*[int(part) for part in val.split('.')])
                if val != ''
                else None
            )
        case 'G3':
            return (
                LongitudeDMS(*[int(part) for part in val.split('.')])
                if val != ''
                else None
            )
        case _:
            if val != ty:
                raise ValueError(f'expected literal "{ty}", found "{val}"')
            return val


def parse_fields(fields: list[FieldSpec], line: str, strict: bool = False
  ) -> dict[str, Any]:
    result = {}
    for f in fields:
        ix = f['position'] - 1
        ty = f['type']
        val = line[ix:(ix + f['length'])].rstrip()
        if strict:
            conv = convert_field(ty, val)
        else:
            try:
                conv = convert_field(ty, val)
            except ValueError:
                warnings.warn(f'failed to convert "{val}" to type "{ty}"')
                conv = val
        result[f['description']] = conv
    return result


def parse_header(fields: list[FieldSpec], line: str) -> dict[str, Any]:
    if 'US WELL DATA' not in line:
        raise ValueError(f'invalid header line: "{line}"')
    if 'FIXED' not in line:
        raise ValueError('expected FIXED format')
    hdr = parse_fields(fields, line)
    if hdr['Download Format'] != '297':
        raise ValueError('unexpected download format')
    if hdr['Version'] != '1.1':
        raise ValueError('unexpected format version')
    if hdr['Delimiter'] != 'FIXED':
        raise ValueError('expected FIXED format')
    return hdr


def parse_record(line: str, strict: bool = False) -> Record:
    for i in INDICATOR_ORDER:
        if line.startswith(i):
            r = RECORDS_BY_INDICATOR[i]
            return Record(i, r['description'],
              parse_fields(r['fields'], line, strict))
    raise ValueError(f'Unknown record: {line}')


def stream_records(src: TextIO, strict: bool = False) -> Iterator[Record]:
    seen_start = False
    count = 0
    while line := src.readline():
        hdr = parse_header(SPEC297['header'], line)
        print(hdr)
        count = int(hdr['Entity Count'])
        while line := src.readline():
            rec = parse_record(line, strict)
            if rec.type == 'Start Record Label':
                if seen_start:
                    raise ValueError('start without end')
                else:
                    seen_start = True
            if rec.type == 'End Record Label':
                if seen_start:
                    seen_start = False
                    count -= 1
                    if count == 0:
                        break # try parsing as header
                else:
                    raise ValueError('end without start')
            yield rec

    if count > 0:
        warnings.warn(f'{count} records still expected at end of file')
