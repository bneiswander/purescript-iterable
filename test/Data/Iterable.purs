module Test.Data.Iterable where

import Data.Iterable

import Control.Monad.Eff (Eff)
import Data.Undefinable (toMaybe)
import Data.Maybe (Maybe(..))
import Prelude (Unit, discard)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (RunnerEffects, run)


main ∷ Eff (RunnerEffects ()) Unit
main = run [consoleReporter] do
  describe "purescript-iterable" do
    describe "iterator" do
      it "should return an iterator that can be iterated" do
        let it = iterator [1, 1, 2, 3, 5, 8]

        let a = next it
        a.done `shouldEqual` false
        (toMaybe a.value) `shouldEqual` (Just 1)

        let b = next it
        b.done `shouldEqual` false
        (toMaybe b.value) `shouldEqual` (Just 1)

        let c = next it
        c.done `shouldEqual` false
        (toMaybe c.value) `shouldEqual` (Just 2)

        let d = next it
        d.done `shouldEqual` false
        (toMaybe d.value) `shouldEqual` (Just 3)

        let e = next it
        e.done `shouldEqual` false
        (toMaybe e.value) `shouldEqual` (Just 5)

        let f = next it
        f.done `shouldEqual` false
        (toMaybe f.value) `shouldEqual` (Just 8)

        let g = next it
        g.done `shouldEqual` true
        (toMaybe g.value) `shouldEqual` Nothing
