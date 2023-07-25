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
  ]
let TwoNinetySeven: FileFormat =
  { header = FileHeader
  , records = []: List Record
  }
in TwoNinetySeven
