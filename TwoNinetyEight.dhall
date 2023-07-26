{-
Copyright (c) 2023 terminus data science, LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-}

let FieldType = ./FieldType.dhall
let Field = ./Field.dhall
let Record= ./Record.dhall
let FileFormat = ./FileFormat.dhall

let FileHeader: List Field =
  [ { description = "Record Key"
    , type = FieldType.Alphanumeric
    , position = 1
    , length = 20
    }
  , { description = "Data Type"
    , type = FieldType.Literal "US PRODUCTION DATA"
    , position = 21
    , length = 20
    }
  , { description = "Download Format"
    , type = FieldType.Literal "298"
    , position = 41
    , length = 12
    }
  , { description = "Version"
    , type = FieldType.Alphanumeric
    , position = 53
    , length = 4
    }
  , { description = "Delimiter"
    , type = FieldType.Alphanumeric
    , position = 57
    , length = 7
    }
  , { description = "Write Date"
    , type = FieldType.DateYYYYSlashMMSlashDD
    , position = 64
    , length = 10
    }
  , { description = "Entity Count"
    , type = FieldType.Numeric
    , position = 74
    , length = 6
    }
  ]

let StartLabel: Record =
  { indicator = "START_US_PROD"
  , description = "Start Record Label"
  , fields =
      [ { description = "START_US_PROD"
        , type = FieldType.Literal "START_US_PROD"
        , position = 1
        , length = 30
        }
      , { description = "Entity ID"
        , type = FieldType.Alphanumeric
        , position = 31
        , length = 40
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 71
        , length = 9
        }
      ]
  }

let EndLabel: Record =
  { indicator = "END_US_PROD"
  , description = "End Record Label"
  , fields =
      [ { description = "END_US_PROD"
        , type = FieldType.Literal "END_US_PROD"
        , position = 1
        , length = 30
        }
      , { description = "Entity ID"
        , type = FieldType.Alphanumeric
        , position = 31
        , length = 40
        }
      ]
  }

let TwoNinetyEight: FileFormat =
  { header = FileHeader
  , records =
      [ StartLabel
      , EndLabel
      ]
  }

in TwoNinetyEight
