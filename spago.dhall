{ name = "purescript-errors"
, dependencies =
  [ "control"
  , "effect"
  , "either"
  , "identity"
  , "maybe"
  , "newtype"
  , "prelude"
  , "test-unit"
  , "transformers"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
