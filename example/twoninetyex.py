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

from typing import (
    Any, Callable, Iterator, NamedTuple, TextIO, TypeAlias, TypedDict
)


with open('json/TwoNinetySeven.json') as f:
    SPEC297 = json.load(f)
with open('json/TwoNinetyEight.json') as f:
    SPEC298 = json.load(f)


class FieldSpec(TypedDict):
    description: str
    type: str
    position: int
    length: int


class RecordSpec(TypedDict):
    indicator: str
    description: str
    fields: list[FieldSpec]


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


class IndicatorTrie(NamedTuple):
    character: str
    record: list[RecordSpec] # used as mutable cell for 0 or 1 records
    suffixes: dict[str, 'IndicatorTrie']

    def insert(self, indicator: str, record: RecordSpec) -> None:
        if indicator == '':
            self.record.clear()
            self.record.append(record)
            return
        next_char = indicator[0]
        if next_char not in self.suffixes:
            self.suffixes[next_char] = IndicatorTrie(next_char, [], {})
        self.suffixes[next_char].insert(indicator[1:], record)


    def longest_match(self, indicator: str) -> RecordSpec:
        # NASTY HACK for .9xc formats, where the indicator is sometimes quoted
        while indicator and indicator[0] == '"':
            indicator = indicator[1:]
        if indicator and indicator[0] in self.suffixes:
            return self.suffixes[indicator[0]].longest_match(indicator[1:])
        if self.record:
            return self.record[0]
        raise KeyError(indicator)


FieldParser: TypeAlias = Callable[[list[FieldSpec], str, bool], dict[str, Any]]


def spec_to_indicator_trie(spec: list[RecordSpec]) -> IndicatorTrie:
    t = IndicatorTrie('', [], {})
    for r in spec:
        t.insert(r['indicator'], r)
    return t


SPEC297_TRIE = spec_to_indicator_trie(SPEC297['records'])
SPEC298_TRIE = spec_to_indicator_trie(SPEC298['records'])


def convert_field(ty: str, val: str) -> Any:
    match ty:
        case 'Alphanumeric':
            return val
        case 'Numeric':
            return float(val) if val != '' else None
        case 'YearYYYY':
            return int(val) if val != '' else None
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


def comma_split(line: str) -> list[str]:
    field: list[str] = []
    fields = []
    in_quote = False
    quote_in_quote = False
    for c in line:
        if not in_quote:
            if c == ',':
                fields.append(''.join(field))
                field = []
            elif c == '"':
                in_quote = True
            else:
                field.append(c)
        elif not quote_in_quote:
            if c == '"':
                quote_in_quote = True
            else:
                field.append(c)
        else:
            if c == '"':
                field.append(c) # escaped quote
            else:
                in_quote = False
                if c == ',':
                    fields.append(''.join(field))
                    field = []
                else: # weird case...
                    field.append(c)
            quote_in_quote = False
    if line:
        fields.append(''.join(field))
    return fields


def parse_fields_fixed(fields: list[FieldSpec], line: str, strict: bool = False
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


def parse_fields_comma(fields: list[FieldSpec], line: str, strict: bool = False
  ) -> dict[str, Any]:
    result = {}
    vals = [w.rstrip() for w in comma_split(line)]
    if len(vals) > len(fields):
        raise ValueError('Invalid row length')
    while len(vals) < len(fields):
        # NASTY HACK for .9xc format: right-pad with blanks to match "Blank"
        # fields in spec
        vals.append('')
    for f, val in zip(fields, vals):
        ty = f['type']
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


def parse_header(line: str) -> tuple[IndicatorTrie, FieldParser, dict[str, Any]]:
    if 'US WELL DATA' in line:
        hdr_fields = SPEC297['header']
        trie = SPEC297_TRIE
        fmt = '297'
    elif 'US PRODUCTION DATA' in line:
        hdr_fields = SPEC298['header']
        trie = SPEC298_TRIE
        fmt = '298'
    else:
        raise ValueError(f'invalid header line: "{line}"')

    hdr = parse_fields_fixed(hdr_fields, line)

    if hdr['Download Format'] != fmt:
        raise ValueError('unexpected download format')
    if hdr['Version'] != '1.1':
        raise ValueError('unexpected format version')

    if hdr['Delimiter'] == 'FIXED':
        field_parser = parse_fields_fixed
    elif hdr['Delimiter'] == 'COMMA':
        field_parser = parse_fields_comma
    else:
        raise ValueError('expected FIXED or COMMA format')

    return trie, field_parser, hdr


def parse_record_spec(line: str, trie: IndicatorTrie) -> RecordSpec:
    try:
        return trie.longest_match(line)
    except KeyError:
        raise ValueError(f'Unknown record type for {line}')


def parse_record(line: str, spec: RecordSpec, field_parser: FieldParser,
  strict: bool = False) -> Record:
    return Record(spec['indicator'], spec['description'],
      field_parser(spec['fields'], line, strict))


def stream_records(src: TextIO, strict: bool = False,
  indicators: set[str] | None = None) -> Iterator[Record]:
    if indicators is not None:
        indicators |= {
            'START_US_WELL', 'END_US_WELL', 'START_US_PROD', 'END_US_PROD'
        }

    seen_start = False
    count = 0
    while line := src.readline():
        trie, field_parser, hdr = parse_header(line)
        print(hdr)
        count = int(hdr['Entity Count'])
        while line := src.readline():
            rec_spec = parse_record_spec(line, trie)
            if indicators is not None and rec_spec['indicator'] not in indicators:
                continue
            rec = parse_record(line, rec_spec, field_parser, strict)
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
                        yield rec
                        break # try parsing as header
                else:
                    raise ValueError('end without start')
            yield rec

    if count > 0:
        warnings.warn(f'{count} records still expected at end of file')
