module Test.Main where

import Prelude
import Effect (Effect)
import Test.Data.Iterable (main) as Test

main ∷ Effect Unit
main = Test.main
