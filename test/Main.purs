module Test.Main where

import Prelude
import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Data.Iterable (main) as Test

main ∷ Effect Unit
main = launchAff_ Test.main
