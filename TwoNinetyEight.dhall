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

let Plus: Record =
  { indicator = "++ "
  , description = "Unique ID"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "++"
        , position = 1
        , length = 3 -- this is wrong in the PDF spec
        }
      , { description = "Prod ID Number"
        , type = FieldType.Alphanumeric
        , position = 4
        , length = 40
        }
      , { description = "File Source"
        , type = FieldType.Alphanumeric
        , position = 44
        , length = 7
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 51
        , length = 29
        }
      ]
  }

let A: Record =
  { indicator = "+A "
  , description = "Entity"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "+A"
        , position = 1
        , length = 3
        }
      , { description = "Region Code"
        , type = FieldType.Alphanumeric
        , position = 4
        , length = 2
        }
      , { description = "State Code"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 2
        }
      , { description = "Field Code"
        , type = FieldType.Alphanumeric
        , position = 8
        , length = 6
        }
      , { description = "County/Parish Code"
        , type = FieldType.Alphanumeric
        , position = 14
        , length = 3
        }
      , { description = "County/Parish Name"
        , type = FieldType.Alphanumeric
        , position = 17
        , length = 8
        }
      , { description = "Operator Code"
        , type = FieldType.Alphanumeric
        , position = 25
        , length = 8
        }
      , { description = "Primary Product Code"
        , type = FieldType.Alphanumeric
        , position = 33
        , length = 1
        }
      , { description = "Mode"
        , type = FieldType.Alphanumeric
        , position = 34
        , length = 1
        }
      , { description = "Formation Code"
        , type = FieldType.Alphanumeric
        , position = 35
        , length = 8
        }
      , { description = "AAPG Basin Code"
        , type = FieldType.Alphanumeric
        , position = 43
        , length = 3
        }
      , { description = "Coal Bed Methane Indicator"
        , type = FieldType.Alphanumeric
        , position = 46
        , length = 1
        }
      , { description = "Enhanced Recovery Flag"
        , type = FieldType.Alphanumeric
        , position = 47
        , length = 1
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 48
        , length = 32
        }
      ]
  }

let AC: Record =
  { indicator = "+AC"
  , description = "Congressional and Carter Location"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "+AC"
        , position = 1
        , length = 3
        }
      , { description = "Township Direction"
        , type = FieldType.Alphanumeric
        , position = 4
        , length = 1
        }
      , { description = "Township Number"
        , type = FieldType.Alphanumeric
        , position = 5
        , length = 5
        }
      , { description = "Range Direction"
        , type = FieldType.Alphanumeric
        , position = 10
        , length = 1
        }
      , { description = "Range Number"
        , type = FieldType.Alphanumeric
        , position = 11
        , length = 5
        }
      , { description = "Section or Equivalent Indictor"
        , type = FieldType.Alphanumeric
        , position = 16
        , length = 3
        }
      , { description = "Section or Equivalent Number"
        , type = FieldType.Alphanumeric
        , position = 19
        , length = 5
        }
      , { description = "Spot"
        , type = FieldType.Alphanumeric
        , position = 24
        , length = 8
        }
      , { description = "Meridian Code"
        , type = FieldType.Alphanumeric
        , position = 32
        , length = 2
        }
      , { description = "Meridian Name"
        , type = FieldType.Alphanumeric
        , position = 34
        , length = 17
        }
      , { description = "State Code"
        , type = FieldType.Alphanumeric
        , position = 51
        , length = 2
        }
      , { description = "County Code"
        , type = FieldType.Alphanumeric
        , position = 53
        , length = 3
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 56
        , length = 24
        }
      ]
  }

let AT: Record =
  { indicator = "+AT"
  , description = "Texas Location"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "+AT"
        , position = 1
        , length = 3
        }
      , { description = "Railroad District"
        , type = FieldType.Alphanumeric
        , position = 4
        , length = 2
        }
      , { description = "Block or League Indicator"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 1
        }
      , { description = "Block or League Number"
        , type = FieldType.Alphanumeric
        , position = 7
        , length = 4
        }
      , { description = "Block Fraction"
        , type = FieldType.Alphanumeric
        , position = 11
        , length = 3
        }
      , { description = "Section or Labor Indicator"
        , type = FieldType.Alphanumeric
        , position = 12
        , length = 1
        }
      , { description = "Section or Labor Number"
        , type = FieldType.Alphanumeric
        , position = 13
        , length = 4
        }
      , { description = "Section Fraction"
        , type = FieldType.Alphanumeric
        , position = 17
        , length = 3
        }
      , { description = "Lot Number"
        , type = FieldType.Alphanumeric
        , position = 20
        , length = 4
        }
      , { description = "Township Direction"
        , type = FieldType.Alphanumeric
        , position = 24
        , length = 1
        }
      , { description = "Township Number"
        , type = FieldType.Alphanumeric
        , position = 25
        , length = 4
        }
      , { description = "Survey Name"
        , type = FieldType.Alphanumeric
        , position = 29
        , length = 16
        }
      , { description = "Abstract Number"
        , type = FieldType.Alphanumeric
        , position = 45
        , length = 7
        }
      , { description = "State Code"
        , type = FieldType.Alphanumeric
        , position = 52
        , length = 2
        }
      , { description = "County Code"
        , type = FieldType.Alphanumeric
        , position = 54
        , length = 3
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 57
        , length = 23
        }
      ]
  }

let AO: Record =
  { indicator = "+AO"
  , description = "Offshore Location"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "+AO"
        , position = 1
        , length = 3
        }
      , { description = "OCS Number"
        , type = FieldType.Alphanumeric
        , position = 4
        , length = 8
        }
      , { description = "Bottom Hole Block Prefix"
        , type = FieldType.Alphanumeric
        , position = 12
        , length = 1
        }
      , { description = "Bottom HoleBlock Number"
        , type = FieldType.Alphanumeric
        , position = 13
        , length = 6
        }
      , { description = "Bottom Hole Block Suffix"
        , type = FieldType.Alphanumeric
        , position = 19
        , length = 1
        }
      , { description = "Area Name"
        , type = FieldType.Alphanumeric
        , position = 20
        , length = 8
        }
      , { description = "UTM Quadrant"
        , type = FieldType.Alphanumeric
        , position = 28
        , length = 7
        }
      , { description = "State/Federal Waters Indicator"
        , type = FieldType.Alphanumeric
        , position = 35
        , length = 1
        }
      , { description = "Water Bottom Zone"
        , type = FieldType.Alphanumeric
        , position = 36
        , length = 2
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 38
        , length = 42
        }
      ]
  }

let AR: Record =
  { indicator = "+AR"
  , description = "Regulatory"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "+AR"
        , position = 1
        , length = 3
        }
      , { description = "Lease/Unit Code"
        , type = FieldType.Alphanumeric
        , position = 4
        , length = 10
        }
      , { description = "Serial Number"
        , type = FieldType.Alphanumeric
        , position = 14
        , length = 11
        }
      , { description = "Co-mingled Facility Code"
        , type = FieldType.Alphanumeric
        , position = 25
        , length = 4
        }
      , { description = "Well Sub-Completion Code"
        , type = FieldType.Alphanumeric
        , position = 29
        , length = 2
        }
      , { description = "Reservoir Code"
        , type = FieldType.Alphanumeric
        , position = 31
        , length = 6
        }
      , { description = "State Offshore Flag"
        , type = FieldType.Alphanumeric
        , position = 37
        , length = 1
        }
      , { description = "API Unique"
        , type = FieldType.Alphanumeric
        , position = 38
        , length = 5
        }
      , { description = "District Code"
        , type = FieldType.Alphanumeric
        , position = 43
        , length = 2
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 45
        , length = 35
        }
      ]
  }

let AHash: Record =
  { indicator = "+A#"
  , description = "Multiple County"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "+A#"
        , position = 1
        , length = 3
        }
      -- I numbered these for uniqueness
      , { description = "County/Parish Code 1"
        , type = FieldType.Alphanumeric
        , position = 4
        , length = 3
        }
      , { description = "County/Parish Name 1"
        , type = FieldType.Alphanumeric
        , position = 7
        , length = 8
        }
      , { description = "County/Parish Code 2"
        , type = FieldType.Alphanumeric
        , position = 15
        , length = 3
        }
      , { description = "County/Parish Name 2"
        , type = FieldType.Alphanumeric
        , position = 18
        , length = 8
        }
      , { description = "County/Parish Code 3"
        , type = FieldType.Alphanumeric
        , position = 26
        , length = 3
        }
      , { description = "County/Parish Name 3"
        , type = FieldType.Alphanumeric
        , position = 29
        , length = 8
        }
      , { description = "Formation Name"
        , type = FieldType.Alphanumeric
        , position = 37
        , length = 40
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 77
        , length = 3
        }
      ]
  }

let TwoNinetyEight: FileFormat =
  { header = FileHeader
  , records =
      [ StartLabel
      , EndLabel
      , Plus
      , A
      , AC
      , AT
      , AO
      , AR
      , AHash
      ]
  }

in TwoNinetyEight
