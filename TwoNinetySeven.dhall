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
    , type = FieldType.Literal "U.S. Well Data"
    , position = 21
    , length = 20
    }
  , { description = "Download Format"
    , type = FieldType.Literal "297"
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
  , { description = "Count of Entities in Export File"
    , type = FieldType.Numeric
    , position = 74
    , length = 6
    }
  ]

let StartLabel: Record =
  { indicator = "START_US_WELL"
  , description = "Start Record Label"
  , fields =
      [ { description = "START_US_WELL"
        , type = FieldType.Literal "START_US_WELL"
        , position = 1
        , length = 30
        }
      , { description = "UWI"
        , type = FieldType.Alphanumeric
        , position = 31
        , length = 20
        }
      ]
  }

let EndLabel: Record =
  { indicator = "END_US_WELL"
  , description = "End Record Label"
  , fields =
      [ { description = "END_US_WELL"
        , type = FieldType.Literal "END_US_WELL"
        , position = 1
        , length = 30
        }
      , { description = "UWI"
        , type = FieldType.Alphanumeric
        , position = 31
        , length = 20
        }
      ]
  }

let General: Record =
  { indicator = "A"
  , description = "General Information"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "A"
        , position = 1
        , length = 1
        }
      , { description = "API Number"
        , type = FieldType.Alphanumeric
        , position = 2
        , length = 14
        }
      , { description = "Latitude (±nn.nnnnn)"
        , type = FieldType.Numeric
        , position = 16
        , length = 9
        }
      , { description = "Longitude (±nnn.nnnnn)"
        , type = FieldType.Numeric
        , position = 25
        , length = 10
        }
      , { description = "Formation at Total Depth"
        , type = FieldType.Alphanumeric
        , position = 35
        , length = 8
        }
      , { description = "Producing Formation"
        , type = FieldType.Alphanumeric
        , position = 43
        , length = 8
        }
      , { description = "Initial Well Class"
        , type = FieldType.Alphanumeric
        , position = 51
        , length = 1
        }
      , { description = "Final Well Class"
        , type = FieldType.Alphanumeric
        , position = 52
        , length = 1
        }
      , { description = "Well Status"
        , type = FieldType.Alphanumeric
        , position = 53
        , length = 6
        }
      , { description = "Elevation"
        , type = FieldType.Numeric
        , position = 59
        , length = 5
        }
      , { description = "Elevation Reference"
        , type = FieldType.Alphanumeric
        , position = 64
        , length = 2
        }
      , { description = "Total Depth"
        , type = FieldType.Numeric
        , position = 66
        , length = 5
        }
      , { description = "Completion Date"
        , type = FieldType.DateYYYYMMDD
        , position = 71
        , length = 8
        }
      , { description = "Lat/Long Source"
        , type = FieldType.Alphanumeric
        , position = 79
        , length = 1
        }
      ]
  }

let BF: Record =
  { indicator = "BF"
  , description = "Footage Location"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "BF"
        , position = 1
        , length = 2
        }
      , { description = "North/South Footage"
        , type = FieldType.Numeric
        , position = 3
        , length = 5
        }
      , { description = "North/South Direction"
        , type = FieldType.Alphanumeric
        , position = 8
        , length = 4
        }
      , { description = "East/West Footage"
        , type = FieldType.Numeric
        , position = 12
        , length = 5
        }
      , { description = "East/West Direction"
        , type = FieldType.Alphanumeric
        , position = 17
        , length = 4
        }
      , { description = "Footage Reference"
        , type = FieldType.Alphanumeric
        , position = 21
        , length = 12
        }
      , { description = "X Coordinate"
        , type = FieldType.Numeric
        , position = 33
        , length = 12
        }
      , { description = "Y Coordinate"
        , type = FieldType.Numeric
        , position = 45
        , length = 12
        }
      , { description = "Zone Code"
        , type = FieldType.Alphanumeric
        , position = 57
        , length = 4
        }
      , { description = "Projection"
        , type = FieldType.Alphanumeric
        , position = 61
        , length = 1
        }
      , { description = "Feet or Meters (F/M)"
        , type = FieldType.Alphanumeric
        , position = 62
        , length = 1
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 63
        , length = 17
        }
      ]
  }

let BC: Record =
  { indicator = "BC"
  , description = "Congress and Carter Location"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "BC"
        , position = 1
        , length = 2
        }
      , { description = "Township Direction"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 1
        }
      , { description = "Township Number"
        , type = FieldType.Alphanumeric
        , position = 4
        , length = 5
        }
      , { description = "Range Direction"
        , type = FieldType.Alphanumeric
        , position = 9
        , length = 1
        }
      , { description = "Range Number"
        , type = FieldType.Alphanumeric
        , position = 10
        , length = 5
        }
      , { description = "Section or Equivalent Indicator"
        , type = FieldType.Alphanumeric
        , position = 15
        , length = 3
        }
      , { description = "Section or Equivalent Number"
        , type = FieldType.Alphanumeric
        , position = 18
        , length = 5
        }
      , { description = "Spot"
        , type = FieldType.Alphanumeric
        , position = 23
        , length = 8
        }
      , { description = "Meridian Code"
        , type = FieldType.Alphanumeric
        , position = 31
        , length = 2
        }
      , { description = "Meridian Name"
        , type = FieldType.Alphanumeric
        , position = 33
        , length = 17
        }
      , { description = "State Code"
        , type = FieldType.Alphanumeric
        , position = 50
        , length = 2
        }
      , { description = "County Code"
        , type = FieldType.Alphanumeric
        , position = 52
        , length = 3
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 55
        , length = 25
        }
      ]
  }

let BT: Record =
  { indicator = "BT"
  , description = "Texas Location"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "BT"
        , position = 1
        , length = 2
        }
      , { description = "Railroad District"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 2
        }
      , { description = "Block or League Indicator"
        , type = FieldType.Alphanumeric
        , position = 5
        , length = 1
        }
      , { description = "Block or League Number"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 4
        }
      , { description = "Block Fraction"
        , type = FieldType.Alphanumeric
        , position = 10
        , length = 3
        }
      , { description = "Section or Labor Indicator"
        , type = FieldType.Alphanumeric
        , position = 13
        , length = 1
        }
      , { description = "Section or Labor Number"
        , type = FieldType.Alphanumeric
        , position = 14
        , length = 4
        }
      , { description = "Section Fraction"
        , type = FieldType.Alphanumeric
        , position = 18
        , length = 3
        }
      , { description = "Lot Number"
        , type = FieldType.Alphanumeric
        , position = 21
        , length = 4
        }
      , { description = "Township Direction"
        , type = FieldType.Alphanumeric
        , position = 25
        , length = 1
        }
      , { description = "Township Number"
        , type = FieldType.Alphanumeric
        , position = 26
        , length = 4
        }
      , { description = "Survey Name"
        , type = FieldType.Alphanumeric
        , position = 30
        , length = 16
        }
      , { description = "Abstract Number"
        , type = FieldType.Alphanumeric
        , position = 46
        , length = 7
        }
      , { description = "State Code"
        , type = FieldType.Alphanumeric
        , position = 53
        , length = 2
        }
      , { description = "County Code"
        , type = FieldType.Alphanumeric
        , position = 55
        , length = 3
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 58
        , length = 22
        }
      ]
  }

let BN: Record =
  { indicator = "BN"
  , description = "Northeast and Ohio Location"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "BN"
        , position = 1
        , length = 2
        }
      , { description = "Named Township"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 22
        }
      , { description = "Lot or Section Indicator"
        , type = FieldType.Alphanumeric
        , position = 25
        , length = 1
        }
      , { description = "Lot or Section Number"
        , type = FieldType.Alphanumeric
        , position = 26
        , length = 5
        }
      , { description = "Quadrangle Name"
        , type = FieldType.Alphanumeric
        , position = 31
        , length = 20
        }
      , { description = "Reference Latitude"
        , type = FieldType.G2
        , position = 51
        , length = 9
        }
      , { description = "Reference Longitude"
        , type = FieldType.G3
        , position = 60
        , length = 10
        }
      , { description = "State Code"
        , type = FieldType.Alphanumeric
        , position = 70
        , length = 2
        }
      , { description = "County Code"
        , type = FieldType.Alphanumeric
        , position = 72
        , length = 3
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 75
        , length = 5
        }
      ]
  }

let TwoNinetySeven: FileFormat =
  { header = FileHeader
  , records =
      [ StartLabel
      , EndLabel
      , General
      , BF
      , BC
      , BT
      , BN
      ]
  }

in TwoNinetySeven
