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
    , type = FieldType.Literal "US WELL DATA"
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

let BO: Record =
  { indicator = "BO"
  , description = "Offshore Location"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "BO"
        , position = 1
        , length = 2
        }
      , { description = "OCS Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 8
        }
      , { description = "Block Prefix"
        , type = FieldType.Alphanumeric
        , position = 11
        , length = 1
        }
      , { description = "Block Number"
        , type = FieldType.Alphanumeric
        , position = 12
        , length = 6
        }
      , { description = "Block Suffix"
        , type = FieldType.Alphanumeric
        , position = 18
        , length = 1
        }
      , { description = "Area Name"
        , type = FieldType.Alphanumeric
        , position = 19
        , length = 8
        }
      , { description = "UTM Quadrant"
        , type = FieldType.Alphanumeric
        , position = 27
        , length = 7
        }
      , { description = "State/Federal Waters Indicator"
        , type = FieldType.Alphanumeric
        , position = 34
        , length = 1
        }
      , { description = "Water Bottom Zone"
        , type = FieldType.Alphanumeric
        , position = 35
        , length = 2
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 37
        , length = 43
        }
      ]
  }

let BM: Record =
  { indicator = "BM"
  , description = "Location from Monument"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "BM"
        , position = 1
        , length = 2
        }
      , { description = "Monument ID"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 6
        }
      , { description = "Monument Name"
        , type = FieldType.Alphanumeric
        , position = 9
        , length = 37
        }
      , { description = "Map distance from Monument to surface location"
        , type = FieldType.Numeric
        , position = 46
        , length = 6
        }
      , { description = "Azimuth"
        , type = FieldType.Numeric
        , position = 52
        , length = 5
        }
      , { description = "Distance North or South in feet"
        , type = FieldType.Numeric
        , position = 57
        , length = 5
        }
      , { description = "'N' - North or 'S' – South"
        , type = FieldType.Alphanumeric
        , position = 62
        , length = 1
        }
      , { description = "Distance East or West in feet"
        , type = FieldType.Numeric
        , position = 63
        , length = 5
        }
      , { description = "'E' - East or 'W' – West"
        , type = FieldType.Alphanumeric
        , position = 68
        , length = 1
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 69
        , length = 11
        }
      ]
  }

let C: Record =
  { indicator = "C"
  , description = "Operator Information"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "C"
        , position = 1
        , length = 1
        }
      , { description = "Operator Name"
        , type = FieldType.Alphanumeric
        , position = 2
        , length = 23
        }
      , { description = "Lease Name"
        , type = FieldType.Alphanumeric
        , position = 25
        , length = 19
        }
      , { description = "Well Number"
        , type = FieldType.Alphanumeric
        , position = 44
        , length = 10
        }
      , { description = "Permit Number"
        , type = FieldType.Alphanumeric
        , position = 54
        , length = 7
        }
      , { description = "Permit Date"
        , type = FieldType.MonthYYYYMM
        , position = 61
        , length = 6
        }
      , { description = "Field Code"
        , type = FieldType.Alphanumeric
        , position = 67
        , length = 6
        }
      , { description = "Province Code"
        , type = FieldType.Alphanumeric
        , position = 73
        , length = 3
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 76
        , length = 4
        }
      ]
  }

let DA: Record =
  { indicator = "DA"
  , description = "Miscellaneous General Information"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "DA"
        , position = 1
        , length = 2
        }
      , { description = "Bottom Hole Latitude"
        , type = FieldType.Numeric
        , position = 3
        , length = 9
        }
      , { description = "Bottom Hole Longitude"
        , type = FieldType.Numeric
        , position = 12
        , length = 10
        }
      , { description = "Field Name"
        , type = FieldType.Alphanumeric
        , position = 22
        , length = 17
        }
      , { description = "Platform"
        , type = FieldType.Alphanumeric
        , position = 39
        , length = 22
        }
      , { description = "Water Depth"
        , type = FieldType.Numeric
        , position = 61
        , length = 5
        }
      , { description = "Water/Ref Datum"
        , type = FieldType.Alphanumeric
        , position = 66
        , length = 4
        }
      , { description = "Lat/Long Source"
        , type = FieldType.Alphanumeric
        , position = 70
        , length = 1
        }
      , { description = "Spud Date"
        , type = FieldType.DateYYYYMMDD
        , position = 71
        , length = 8
        }
      , { description = "Directional Indicator"
        , type = FieldType.Alphanumeric
        , position = 79
        , length = 1
        }
      ]
  }

let DB: Record =
  { indicator = "DB"
  , description = "Additional Miscellaneous General Information"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "DB"
        , position = 1
        , length = 2
        }
      , { description = "IC Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 12
        }
      , { description = "Activity Code"
        , type = FieldType.Alphanumeric
        , position = 15
        , length = 1
        }
      , { description = "Rig Release Date"
        , type = FieldType.DateYYYYMMDD
        , position = 16
        , length = 8
        }
      , { description = "Abandoned Location Date"
        , type = FieldType.DateYYYYMMDD
        , position = 24
        , length = 8
        }
      , { description = "First Report Date"
        , type = FieldType.DateYYYYMMDD
        , position = 32
        , length = 8
        }
      , { description = "WRS First Report Date"
        , type = FieldType.DateYYYYMMDD
        , position = 40
        , length = 8
        }
      , { description = "Last Activity Date"
        , type = FieldType.DateYYYYMMDD
        , position = 48
        , length = 8
        }
      , { description = "Projected Formation"
        , type = FieldType.Alphanumeric
        , position = 56
        , length = 8
        }
      , { description = "Projected Depth"
        , type = FieldType.Numeric
        , position = 64
        , length = 5
        }
      , { description = "Initial Lahee Class"
        , type = FieldType.Alphanumeric
        , position = 69
        , length = 3
        }
      , { description = "Final Lahee Class"
        , type = FieldType.Alphanumeric
        , position = 72
        , length = 3
        }
      , { description = "Whipstock Depth"
        , type = FieldType.Numeric
        , position = 75
        , length = 5
        }
      ]
  }

let DC: Record =
  { indicator = "DC"
  , description = "Additional Miscellaneous General Information (Permit Filer)"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "DC"
        , position = 1
        , length = 2
        }
      , { description = "Name of Permit Filer"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 21
        }
      , { description = "Title of Permit Filer"
        , type = FieldType.Alphanumeric
        , position = 24
        , length = 21
        }
      , { description = "Phone Number of Permit Filer"
        , type = FieldType.Alphanumeric
        , position = 45
        , length = 14
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 59
        , length = 21
        }
      ]
  }

let ET: Record =
  { indicator = "ET"
  , description = "Formation Tops"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "ET"
        , position = 1
        , length = 2
        }
      , { description = "Formation Code"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 8
        }
      , { description = "Formation Depth"
        , type = FieldType.Numeric
        , position = 11
        , length = 5
        }
      , { description = "Source of Top Data"
        , type = FieldType.Alphanumeric
        , position = 16
        , length = 1
        }
      , { description = "Show Code"
        , type = FieldType.Alphanumeric
        , position = 17
        , length = 1
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 18
        , length = 62
        }
      ]
  }

let EB: Record =
  { indicator = "EB"
  , description = "Formation Bottoms"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "EB"
        , position = 1
        , length = 2
        }
      , { description = "Formation Code"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 8
        }
      , { description = "Formation Base Depth"
        , type = FieldType.Numeric
        , position = 11
        , length = 5
        }
      , { description = "Source of Base Data"
        , type = FieldType.Alphanumeric
        , position = 16
        , length = 1
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 17
        , length = 63
        }
      ]
  }

let F: Record =
  { indicator = "F "
  , description = "Initial Potential"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "F"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Formation Code"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 8
        }
      , { description = "Interval Top"
        , type = FieldType.Numeric
        , position = 14
        , length = 5
        }
      , { description = "Interval Base"
        , type = FieldType.Numeric
        , position = 19
        , length = 5
        }
      , { description = "Oil Volume"
        , type = FieldType.Numeric
        , position = 24
        , length = 5
        }
      , { description = "Oil Rate or Description"
        , type = FieldType.Alphanumeric
        , position = 29
        , length = 4
        }
      , { description = "Gas Volume"
        , type = FieldType.Numeric
        , position = 33
        , length = 8
        }
      , { description = "Gas Rate or Description"
        , type = FieldType.Alphanumeric
        , position = 41
        , length = 4
        }
      , { description = "Water Volume"
        , type = FieldType.Numeric
        , position = 45
        , length = 5
        }
      , { description = "Water Rate or Description"
        , type = FieldType.Alphanumeric
        , position = 50
        , length = 2
        }
      , { description = "Flowing Tubing Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 52
        , length = 5
        }
      , { description = "Bottom Hole Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 57
        , length = 5
        }
      , { description = "Test Duration (hours)"
        , type = FieldType.Numeric
        , position = 62
        , length = 6
        }
      , { description = "Choke Size (64th of an inch)"
        , type = FieldType.Numeric
        , position = 68
        , length = 2
        }
      , { description = "Bottom Hole Temperature (°F)"
        , type = FieldType.Numeric
        , position = 70
        , length = 3
        }
      , { description = "Method of Production"
        , type = FieldType.Alphanumeric
        , position = 73
        , length = 1
        }
      , { description = "Gross Interval Note (G)"
        , type = FieldType.Alphanumeric
        , position = 74
        , length = 1
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 75
        , length = 5
        }
      ]
  }

let FA: Record =
  { indicator = "FA"
  , description = "IP Treat"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "FA"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Treatment Number"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 2
        }
      , { description = "Type of Treatment"
        , type = FieldType.Alphanumeric
        , position = 8
        , length = 4
        }
      , { description = "Interval Top"
        , type = FieldType.Numeric
        , position = 12
        , length = 5
        }
      , { description = "Interval Base"
        , type = FieldType.Numeric
        , position = 17
        , length = 5
        }
      , { description = "Volume or Weight"
        , type = FieldType.Numeric
        , position = 22
        , length = 6
        }
      , { description = "Measurement"
        , type = FieldType.Alphanumeric
        , position = 28
        , length = 4
        }
      , { description = "Amount of Propping Agent"
        , type = FieldType.Numeric
        , position = 32
        , length = 6
        }
      , { description = "Tons/Pounds ('TNS' or 'LBS')"
        , type = FieldType.Alphanumeric
        , position = 38
        , length = 3
        }
      , { description = "Formation Breakdown Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 41
        , length = 5
        }
      , { description = "Average Injection Rate (BBLS/min)"
        , type = FieldType.Numeric
        , position = 46
        , length = 3
        }
      , { description = "Type of Additive"
        , type = FieldType.Alphanumeric
        , position = 49
        , length = 4
        }
      , { description = "Number of Stages"
        , type = FieldType.Alphanumeric
        , position = 53
        , length = 3
        }
      , { description = "Propping Agent"
        , type = FieldType.Alphanumeric
        , position = 56
        , length = 4
        }
      , { description = "Remark"
        , type = FieldType.Alphanumeric
        , position = 60
        , length = 20
        }
      ]
  }

let FD: Record =
  { indicator = "FD"
  , description = "Detailed Perforations"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "FD"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Interval Top"
        , type = FieldType.Numeric
        , position = 6
        , length = 5
        }
      , { description = "Interval Base"
        , type = FieldType.Numeric
        , position = 11
        , length = 5
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 16
        , length = 64
        }
      ]
  }

let FN: Record =
  { indicator = "FN"
  , description = "IP Narrative"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "FN"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Line Number"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 2
        }
      , { description = "Narrative"
        , type = FieldType.Alphanumeric
        , position = 8
        , length = 72
        }
      ]
  }

let G: Record =
  { indicator = "G "
  , description = "Production Test"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "G"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Formation Code"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 8
        }
      , { description = "Interval Top"
        , type = FieldType.Numeric
        , position = 14
        , length = 5
        }
      , { description = "Interval Base"
        , type = FieldType.Numeric
        , position = 19
        , length = 5
        }
      , { description = "Oil Volume"
        , type = FieldType.Numeric
        , position = 24
        , length = 5
        }
      , { description = "Oil Rate or Description"
        , type = FieldType.Alphanumeric
        , position = 29
        , length = 4
        }
      , { description = "Gas Volume"
        , type = FieldType.Numeric
        , position = 33
        , length = 8
        }
      , { description = "Gas Rate or Description"
        , type = FieldType.Alphanumeric
        , position = 41
        , length = 4
        }
      , { description = "Water Volume"
        , type = FieldType.Numeric
        , position = 45
        , length = 5
        }
      , { description = "Water Rate or Description"
        , type = FieldType.Alphanumeric
        , position = 50
        , length = 2
        }
      , { description = "Flowing Tubing Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 52
        , length = 5
        }
      , { description = "Bottom Hole Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 57
        , length = 5
        }
      , { description = "Test Duration (hours)"
        , type = FieldType.Numeric
        , position = 62
        , length = 6
        }
      , { description = "Choke Size (64th of an inch)"
        , type = FieldType.Numeric
        , position = 68
        , length = 2
        }
      , { description = "Bottom Hole Temperature (° F)"
        , type = FieldType.Numeric
        , position = 70
        , length = 3
        }
      , { description = "Method of Production"
        , type = FieldType.Alphanumeric
        , position = 73
        , length = 1
        }
      , { description = "Gross Interval Note (G)"
        , type = FieldType.Alphanumeric
        , position = 74
        , length = 1
        }
      , { description = "Shut Off Type"
        , type = FieldType.Alphanumeric
        , position = 75
        , length = 4
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 79
        , length = 1
        }
      ]
  }

let GA: Record =
  { indicator = "GA"
  , description = "PDT Treat"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "GA"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Treatment Number"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 2
        }
      , { description = "Type of Treatment"
        , type = FieldType.Alphanumeric
        , position = 8
        , length = 4
        }
      , { description = "Interval Top"
        , type = FieldType.Numeric
        , position = 12
        , length = 5
        }
      , { description = "Interval Base"
        , type = FieldType.Numeric
        , position = 17
        , length = 5
        }
      , { description = "Volume or Weight"
        , type = FieldType.Numeric
        , position = 22
        , length = 6
        }
      , { description = "Measurement"
        , type = FieldType.Alphanumeric
        , position = 28
        , length = 4
        }
      , { description = "Amount of Propping Agent"
        , type = FieldType.Numeric
        , position = 32
        , length = 6
        }
      , { description = "Tons/Pounds ('TNS' or 'LBS')"
        , type = FieldType.Alphanumeric
        , position = 38
        , length = 3
        }
      , { description = "Formation Breakdown Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 41
        , length = 5
        }
      , { description = "Average Injection Rate (BBLS/min)"
        , type = FieldType.Numeric
        , position = 46
        , length = 3
        }
      , { description = "Type of Additive"
        , type = FieldType.Alphanumeric
        , position = 49
        , length = 4
        }
      , { description = "Number of Stages"
        , type = FieldType.Alphanumeric
        , position = 53
        , length = 3
        }
      , { description = "Propping Agent"
        , type = FieldType.Alphanumeric
        , position = 56
        , length = 4
        }
      , { description = "Remark"
        , type = FieldType.Alphanumeric
        , position = 60
        , length = 20
        }
      ]
  }

let GD: Record =
  { indicator = "GD"
  , description = "PDT Perforations"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "GD"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Interval Top"
        , type = FieldType.Numeric
        , position = 6
        , length = 5
        }
      , { description = "Interval Base"
        , type = FieldType.Numeric
        , position = 11
        , length = 5
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 16
        , length = 64
        }
      ]
  }

{- the spec I have has this as (a second) 'GD' indicator, but that
 - doesn't make sense; I'm guessing it's got to be 'GN'
 -}
let GN: Record =
  { indicator = "GN"
  , description = "PDT Narrative"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "GN"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Line Number"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 2
        }
      , { description = "Narrative"
        , type = FieldType.Alphanumeric
        , position = 8
        , length = 72
        }
      ]
  }

let H: Record =
  { indicator = "H "
  , description = "Drill Stem Tests"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "H"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Formation Code"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 8
        }
      , { description = "Interval Top"
        , type = FieldType.Numeric
        , position = 14
        , length = 5
        }
      , { description = "Interval Bottom"
        , type = FieldType.Numeric
        , position = 19
        , length = 5
        }
      , { description = "Initial Hydrostatic Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 24
        , length = 5
        }
      , { description = "Final Hydrostatic Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 29
        , length = 6
        }
      , { description = "Top Choke (64th of an inch)"
        , type = FieldType.Numeric
        , position = 35
        , length = 3
        }
      , { description = "Bottom Hole Temperature (° F)"
        , type = FieldType.Numeric
        , position = 38
        , length = 3
        }
      , { description = "Cushion Amount (ft)"
        , type = FieldType.Numeric
        , position = 41
        , length = 5
        }
      , { description = "Cushion Type"
        , type = FieldType.Alphanumeric
        , position = 46
        , length = 6
        }
      , { description = "Test Indicator"
        , type = FieldType.Alphanumeric
        , position = 52
        , length = 1
        }
      , { description = "Oil Gravity"
        , type = FieldType.Numeric
        , position = 53
        , length = 4
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 57
        , length = 23
        }
      ]
  }

let HA: Record =
  { indicator = "HA"
  , description = "Drill Stem Tests, Pipe Recovery Detail"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "HA"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Recovery Amount"
        , type = FieldType.Numeric
        , position = 6
        , length = 5
        }
      , { description = "Unit of Measurement"
        , type = FieldType.Alphanumeric
        , position = 11
        , length = 3
        }
      , { description = "Description of Recovery"
        , type = FieldType.Alphanumeric
        , position = 14
        , length = 7
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 21
        , length = 59
        }
      ]
  }

let HB: Record =
  { indicator = "HB"
  , description = "Drill Stem Tests, Material to Surface Detail"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "HB"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Amount"
        , type = FieldType.Numeric
        , position = 6
        , length = 7
        }
      , { description = "Unit of Measurement"
        , type = FieldType.Alphanumeric
        , position = 13
        , length = 4
        }
      , { description = "Type of Material"
        , type = FieldType.Alphanumeric
        , position = 17
        , length = 4
        }
      , { description = "Time to Surface"
        , type = FieldType.Alphanumeric
        , position = 21
        , length = 6
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 27
        , length = 53
        }
      ]
  }

let HF: Record =
  { indicator = "HF"
  , description = "Drill Stem Tests, Flow Period"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "HF"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "(Initial) Initial Flowing Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 6
        , length = 5
        }
      , { description = "(Initial) Final Flowing Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 11
        , length = 5
        }
      , { description = "(Final) Initial Flowing Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 16
        , length = 5
        }
      , { description = "(Final) Final Flowing Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 21
        , length = 5
        }
      , { description = "Initial Shut-in Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 26
        , length = 5
        }
      , { description = "Final Shut-in Pressure (ppsi)"
        , type = FieldType.Numeric
        , position = 31
        , length = 5
        }
      , { description = "Final Open Time"
        , type = FieldType.Alphanumeric
        , position = 36
        , length = 5
        }
      , { description = "Final Shut-in Time"
        , type = FieldType.Alphanumeric
        , position = 41
        , length = 5
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 46
        , length = 34
        }
      ]
  }

let HN: Record =
  { indicator = "HN"
  , description = "Drill Stem Test Narrative"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "HN"
        , position = 1
        , length = 2
        }
      , { description = "Test Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Line Number"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 2
        }
      , { description = "Narrative"
        , type = FieldType.Alphanumeric
        , position = 8
        , length = 72
        }
      ]
  }

let I: Record =
  { indicator = "I"
  , description = "Core Data"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "I"
        , position = 1
        , length = 1
        }
      , { description = "Core Number"
        , type = FieldType.Alphanumeric
        , position = 2
        , length = 3
        }
      , { description = "Core Top Depth"
        , type = FieldType.Numeric
        , position = 5
        , length = 5
        }
      , { description = "Core Base Depth"
        , type = FieldType.Numeric
        , position = 10
        , length = 5
        }
      , { description = "Recovery"
        , type = FieldType.Numeric
        , position = 15
        , length = 6
        }
      , { description = "Unit of Measure"
        , type = FieldType.Alphanumeric
        , position = 21
        , length = 2
        }
      , { description = "Formation Code"
        , type = FieldType.Alphanumeric
        , position = 23
        , length = 8
        }
      , { description = "Core Type"
        , type = FieldType.Alphanumeric
        , position = 31
        , length = 4
        }
      , { description = "Show"
        , type = FieldType.Alphanumeric
        , position = 35
        , length = 4
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 39
        , length = 41
        }
      ]
  }

let ID: Record =
  { indicator = "ID"
  , description = "Core Depth/Interval Data"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "ID"
        , position = 1
        , length = 2
        }
      , { description = "Core Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Interval Number"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 3
        }
      , { description = "Thickness"
        , type = FieldType.Numeric
        , position = 9
        , length = 7
        }
      , { description = "Top Depth"
        , type = FieldType.Numeric
        , position = 16
        , length = 5
        }
      , { description = "Base Depth"
        , type = FieldType.Numeric
        , position = 21
        , length = 5
        }
      , { description = "Lithology"
        , type = FieldType.Alphanumeric
        , position = 26
        , length = 10
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 36
        , length = 44
        }
      ]
  }

let IN: Record =
  { indicator = "IN"
  , description = "Core Narrative Data"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "IN"
        , position = 1
        , length = 2
        }
      , { description = "Core Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 3
        }
      , { description = "Interval Number"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 3
        }
      , { description = "Core Narrative Description"
        , type = FieldType.Alphanumeric
        , position = 9
        , length = 71
        }
      ]
  }

let J: Record =
  { indicator = "J"
  , description = "Logs Data"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "J"
        , position = 1
        , length = 1
        }
      , { description = "Run Number"
        , type = FieldType.Numeric
        , position = 2
        , length = 3
        }
      , { description = "Log Type"
        , type = FieldType.Alphanumeric
        , position = 5
        , length = 4
        }
      , { description = "Log Top Depth"
        , type = FieldType.Numeric
        , position = 9
        , length = 5
        }
      , { description = "Log Base Depth"
        , type = FieldType.Numeric
        , position = 14
        , length = 5
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 19
        , length = 61
        }
      ]
  }

let K: Record =
  { indicator = "K"
  , description = "Mud Data"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "K"
        , position = 1
        , length = 1
        }
      , { description = "Weight"
        , type = FieldType.Numeric
        , position = 2
        , length = 5
        }
      , { description = "Unit of Measurement (ppg/ppc)"
        , type = FieldType.Alphanumeric
        , position = 7
        , length = 3
        }
      , { description = "Depth"
        , type = FieldType.Numeric
        , position = 10
        , length = 5
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 15
        , length = 65
        }
      ]
  }

let L: Record =
  { indicator = "L"
  , description = "Casing Data"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "L"
        , position = 1
        , length = 1
        }
      , { description = "Sequence Number"
        , type = FieldType.Alphanumeric
        , position = 2
        , length = 2
        }
      , { description = "Size"
        , type = FieldType.Alphanumeric
        , position = 4
        , length = 9
        }
      , { description = "Depth"
        , type = FieldType.Numeric
        , position = 13
        , length = 5
        }
      , { description = "Cement"
        , type = FieldType.Numeric
        , position = 18
        , length = 5
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 23
        , length = 57
        }
      ]
  }

let M: Record =
  { indicator = "M"
  , description = "Liner Data"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "M"
        , position = 1
        , length = 1
        }
      , { description = "Sequence Number"
        , type = FieldType.Alphanumeric
        , position = 2
        , length = 3
        }
      , { description = "Size"
        , type = FieldType.Alphanumeric
        , position = 5
        , length = 9
        }
      , { description = "Type"
        , type = FieldType.Alphanumeric
        , position = 14
        , length = 5
        }
      , { description = "Cement"
        , type = FieldType.Numeric
        , position = 19
        , length = 5
        }
      , { description = "Liner Top"
        , type = FieldType.Numeric
        , position = 24
        , length = 5
        }
      , { description = "Liner Base"
        , type = FieldType.Numeric
        , position = 29
        , length = 5
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 34
        , length = 46
        }
      ]
  }

let N: Record =
  { indicator = "N"
  , description = "Tubing Data"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "N"
        , position = 1
        , length = 1
        }
      , { description = "Size"
        , type = FieldType.Alphanumeric
        , position = 2
        , length = 9
        }
      , { description = "Depth"
        , type = FieldType.Numeric
        , position = 11
        , length = 5
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 16
        , length = 54
        }
      ]
  }

let ON: Record =
  { indicator = "ON"
  , description = "Location Narrative"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "ON"
        , position = 1
        , length = 2
        }
      , { description = "Narrative"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 77
        }
      ]
  }

let OA: Record =
  { indicator = "OA"
  , description = "Drilling Narrative"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "OA"
        , position = 1
        , length = 2
        }
      , { description = "Date"
        , type = FieldType.DateYYYYMMDD
        , position = 3
        , length = 8
        }
      , { description = "Remarks"
        , type = FieldType.Alphanumeric
        , position = 11
        , length = 69
        }
      ]
  }

let PF: Record =
  { indicator = "PF"
  , description = "Proposed Bottom Hole Location (Footage)"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "PF"
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
        , length = 4,
        }
      , { description = "Projection"
        , type = FieldType.Alphanumeric
        , position = 61
        , length = 1,
        }
      , { description = "Feet or Meters (F/M)"
        , type = FieldType.Alphanumeric
        , position = 62
        , length = 1,
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 63
        , length = 17,
        }
      ]
  }

let PC: Record =
  { indicator = "PC"
  , description = "Proposed Bottom Hole Location (Congressional and Carter)"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "PC"
        , position = 1
        , length = 2
        }
      , { description = "Township Direction"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 1,
        }
      , { description = "Township Number"
        , type = FieldType.Alphanumeric
        , position = 4
        , length = 5,
        }
      , { description = "Range Direction"
        , type = FieldType.Alphanumeric
        , position = 9
        , length = 1,
        }
      , { description = "Range Number"
        , type = FieldType.Alphanumeric
        , position = 10
        , length = 5,
        }
      , { description = "Section or Equivalent Indicator"
        , type = FieldType.Alphanumeric
        , position = 15
        , length = 3,
        }
      , { description = "Section or Equivalent Number"
        , type = FieldType.Alphanumeric
        , position = 18
        , length = 5,
        }
      , { description = "Spot"
        , type = FieldType.Alphanumeric
        , position = 23
        , length = 8,
        }
      , { description = "Meridian Code"
        , type = FieldType.Alphanumeric
        , position = 31
        , length = 2,
        }
      , { description = "Meridian Name"
        , type = FieldType.Alphanumeric
        , position = 33
        , length = 17,
        }
      , { description = "State Code"
        , type = FieldType.Alphanumeric
        , position = 50
        , length = 2,
        }
      , { description = "County Code"
        , type = FieldType.Alphanumeric
        , position = 52
        , length = 3,
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 55
        , length = 25,
        }
      ]
  }

let PT: Record =
  { indicator = "PT"
  , description = "Proposed Bottom Hole Location (Texas)"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "PT"
        , position = 1
        , length = 2
        }
      , { description = "Railroad District"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 2,
        }
      , { description = "Block or League Indicator"
        , type = FieldType.Alphanumeric
        , position = 5
        , length = 1,
        }
      , { description = "Block or League Number"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 4,
        }
      , { description = "Block Fraction"
        , type = FieldType.Alphanumeric
        , position = 10
        , length = 3,
        }
      , { description = "Section or Labor Indicator"
        , type = FieldType.Alphanumeric
        , position = 13
        , length = 1,
        }
      , { description = "Section or Labor Number"
        , type = FieldType.Alphanumeric
        , position = 14
        , length = 4,
        }
      , { description = "Section Fraction"
        , type = FieldType.Alphanumeric
        , position = 18
        , length = 3,
        }
      , { description = "Lot Number"
        , type = FieldType.Alphanumeric
        , position = 21
        , length = 4,
        }
      , { description = "Township Direction"
        , type = FieldType.Alphanumeric
        , position = 25
        , length = 1,
        }
      , { description = "Township Number"
        , type = FieldType.Alphanumeric
        , position = 26
        , length = 4,
        }
      , { description = "Survey Name"
        , type = FieldType.Alphanumeric
        , position = 30
        , length = 16,
        }
      , { description = "Abstract Number"
        , type = FieldType.Alphanumeric
        , position = 46
        , length = 7,
        }
      , { description = "State Code"
        , type = FieldType.Alphanumeric
        , position = 53
        , length = 2,
        }
      , { description = "County Code"
        , type = FieldType.Alphanumeric
        , position = 55
        , length = 3,
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 58
        , length = 22,
        }
      ]
  }

let PN: Record =
  { indicator = "PN"
  , description = "Proposed Bottom Hole Location (Northeast and Ohio)"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "PN"
        , position = 1
        , length = 2
        }
      , { description = "Named Township"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 22,
        }
      , { description = "Lot or Section Indicator"
        , type = FieldType.Alphanumeric
        , position = 25
        , length = 1,
        }
      , { description = "Lot or Section Number"
        , type = FieldType.Alphanumeric
        , position = 26
        , length = 5,
        }
      , { description = "Quadrangle Name"
        , type = FieldType.Alphanumeric
        , position = 31
        , length = 20,
        }
      , { description = "Reference Latitude"
        , type = FieldType.G2
        , position = 51
        , length = 9,
        }
      , { description = "Reference Longitude"
        , type = FieldType.G3
        , position = 60
        , length = 10,
        }
      , { description = "State Code"
        , type = FieldType.Alphanumeric
        , position = 70
        , length = 2,
        }
      , { description = "County Code"
        , type = FieldType.Alphanumeric
        , position = 72
        , length = 3,
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 75
        , length = 5,
        }
      ]
  }

let PO: Record =
  { indicator = "PO"
  , description = "Proposed Bottom Hole Location (Offshore)"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "PO"
        , position = 1
        , length = 2
        }
      , { description = "OCS Code/Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 8
        }
      , { description = "Block Prefix"
        , type = FieldType.Alphanumeric
        , position = 11
        , length = 1
        }
      , { description = "Block Number"
        , type = FieldType.Alphanumeric
        , position = 12
        , length = 6
        }
      , { description = "Block Suffix"
        , type = FieldType.Alphanumeric
        , position = 18
        , length = 1
        }
      , { description = "Area Name"
        , type = FieldType.Alphanumeric
        , position = 19
        , length = 8
        }
      , { description = "UTM Quadrant"
        , type = FieldType.Alphanumeric
        , position = 27
        , length = 7
        }
      , { description = "State/Fed Waters Indicator"
        , type = FieldType.Alphanumeric
        , position = 34
        , length = 1
        }
      , { description = "Water Bottom Zone"
        , type = FieldType.Alphanumeric
        , position = 35
        , length = 2
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 37
        , length = 43
        }
      ]
  }

{- I made this one up; it's not in the spec I have.
 - However, I've got data (from IHS) which contains it, and the pattern
 - (each Px has a corresponding Qx record) is pretty easy to see.
 -}
let QF: Record =
  { indicator = "QF"
  , description = "Actual Bottom Hole Location (Footage)"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "QF"
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
        , length = 4,
        }
      , { description = "Projection"
        , type = FieldType.Alphanumeric
        , position = 61
        , length = 1,
        }
      , { description = "Feet or Meters (F/M)"
        , type = FieldType.Alphanumeric
        , position = 62
        , length = 1,
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 63
        , length = 17,
        }
      ]
  }


let QC: Record =
  { indicator = "QC"
  , description = "Actual Bottom Hole Location (Congressional and Carter)"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "QC"
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

let QT: Record =
  { indicator = "QT"
  , description = "Actual Bottom Hole Location (Texas)"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "QT"
        , position = 1
        , length = 2
        }
      , { description = "Railroad District"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 2,
        }
      , { description = "Block or League Indicator"
        , type = FieldType.Alphanumeric
        , position = 5
        , length = 1,
        }
      , { description = "Block or League Number"
        , type = FieldType.Alphanumeric
        , position = 6
        , length = 4,
        }
      , { description = "Block Fraction"
        , type = FieldType.Alphanumeric
        , position = 10
        , length = 3,
        }
      , { description = "Section or Labor Indicator"
        , type = FieldType.Alphanumeric
        , position = 13
        , length = 1,
        }
      , { description = "Section or Labor Number"
        , type = FieldType.Alphanumeric
        , position = 14
        , length = 4,
        }
      , { description = "Section Fraction"
        , type = FieldType.Alphanumeric
        , position = 18
        , length = 3,
        }
      , { description = "Lot Number"
        , type = FieldType.Alphanumeric
        , position = 21
        , length = 4,
        }
      , { description = "Township Direction"
        , type = FieldType.Alphanumeric
        , position = 25
        , length = 1,
        }
      , { description = "Township Number"
        , type = FieldType.Alphanumeric
        , position = 26
        , length = 4,
        }
      , { description = "Survey Name"
        , type = FieldType.Alphanumeric
        , position = 30
        , length = 16,
        }
      , { description = "Abstract Number"
        , type = FieldType.Alphanumeric
        , position = 46
        , length = 7,
        }
      , { description = "State Code"
        , type = FieldType.Alphanumeric
        , position = 53
        , length = 2,
        }
      , { description = "County Code"
        , type = FieldType.Alphanumeric
        , position = 55
        , length = 3,
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 58
        , length = 22,
        }
      ]
  }

let QN: Record =
  { indicator = "QN"
  , description = "Actual Bottom Hole Location (Northeast and Ohio)"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "QN"
        , position = 1
        , length = 2
        }
      , { description = "Named Township"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 22,
        }
      , { description = "Lot or Section Indicator"
        , type = FieldType.Alphanumeric
        , position = 25
        , length = 1,
        }
      , { description = "Lot or Section Number"
        , type = FieldType.Alphanumeric
        , position = 26
        , length = 5,
        }
      , { description = "Quadrangle Name"
        , type = FieldType.Alphanumeric
        , position = 31
        , length = 20,
        }
      , { description = "Reference Latitude"
        , type = FieldType.G2
        , position = 51
        , length = 9,
        }
      , { description = "Reference Longitude"
        , type = FieldType.G3
        , position = 60
        , length = 10,
        }
      , { description = "State Code"
        , type = FieldType.Alphanumeric
        , position = 70
        , length = 2,
        }
      , { description = "County Code"
        , type = FieldType.Alphanumeric
        , position = 72
        , length = 3,
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 75
        , length = 5,
        }
      ]
  }

let QO: Record =
  { indicator = "QO"
  , description = "Actual Bottom Hole Location (Offshore)"
  , fields =
      [ { description = "Record Type Indicator"
        , type = FieldType.Literal "QO"
        , position = 1
        , length = 2
        }
      , { description = "OCS Code/Number"
        , type = FieldType.Alphanumeric
        , position = 3
        , length = 8
        }
      , { description = "Block Prefix"
        , type = FieldType.Alphanumeric
        , position = 11
        , length = 1
        }
      , { description = "Block Number"
        , type = FieldType.Alphanumeric
        , position = 12
        , length = 6
        }
      , { description = "Block Suffix"
        , type = FieldType.Alphanumeric
        , position = 18
        , length = 1
        }
      , { description = "Area Name"
        , type = FieldType.Alphanumeric
        , position = 19
        , length = 8
        }
      , { description = "UTM Quadrant"
        , type = FieldType.Alphanumeric
        , position = 27
        , length = 7
        }
      , { description = "State/Fed Waters Indicator"
        , type = FieldType.Alphanumeric
        , position = 34
        , length = 1
        }
      , { description = "Water Bottom Zone"
        , type = FieldType.Alphanumeric
        , position = 35
        , length = 2
        }
      , { description = "Blank"
        , type = FieldType.Alphanumeric
        , position = 37
        , length = 43
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
      , BO
      , BM
      , C
      , DA
      , DB
      , DC
      , ET
      , EB
      , F
      , FA
      , FD
      , FN
      , G
      , GA
      , GD
      , GN
      , H
      , HA
      , HB
      , HF
      , HN
      , I
      , ID
      , IN
      , J
      , K
      , L
      , M
      , N
      , ON
      , OA
      , PF
      , PC
      , PT
      , PN
      , PO
      , QF
      , QC
      , QT
      , QN
      , QO
      ]
  }

in TwoNinetySeven
