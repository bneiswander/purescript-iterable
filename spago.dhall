{ name = "iterable"
, dependencies =
  [ "aff"
  , "arrays"
  , "effect"
  , "foreign"
  , "maybe"
  , "prelude"
  , "refs"
  , "spec"
  , "tailrec"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
