# twoninetyex

IHS 29x format specs in Dhall form.

Suitable for metaprogramming parsers and such.

Available under the MIT license.

---

The Makefile can be used to regenerate the JSON specs or Dhall package file if desired.

A simple example spec-driven parser, in Python, is provided in the examples directory.
It handles 297 and 298 files in either fixed or comma delimited format.
In accordance with my reading of the spec, it even handles intermixed formats within a single file, based on (sub-)file headers.
Run with e.g. `python examples/test.py data.97f` (or `97c`, or `98f`, or `98c`).

---

### (c) 2023 terminus, LLC
