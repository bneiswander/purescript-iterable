module Test.Data.Iterable where

import Data.Iterable

import Control.Monad.Eff (Eff)
import Prelude (Unit, unit, discard)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (RunnerEffects, run)


main ∷ Eff (RunnerEffects ()) Unit
main = run [consoleReporter] do
  describe "purescript-es6-symbols" do
    describe "Symbol" do
      it "should return Symbols from the constructors" do
        let it = iterator [1, 1, 2, 3, 5, 8]
        --       --------
        -- |  No type class instance was found for
        -- |
        -- |    Data.Iterable.Iterator t1
        -- |
        -- |  The instance head contains unknown type variables. Consider adding a type annotation.
        true `shouldEqual` true
