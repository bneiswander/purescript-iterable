module Test.Data.Iterable where

import Data.Iterable

import Effect (Effect)
import Effect.Class (liftEffect)
import Data.Undefinable (toMaybe)
import Data.Maybe (Maybe(..))
import Prelude (Unit, discard, bind)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (run)


main ∷ Effect Unit
main = run [consoleReporter] do
  describe "purescript-iterable" do
    describe "iterator" do
      it "should return an iterator that can be iterated" do
        let it = iterator [1, 1, 2, 3, 5, 8]

        a <- liftEffect (next it)
        a.done `shouldEqual` false
        (toMaybe a.value) `shouldEqual` (Just 1)

        b <- liftEffect (next it)
        b.done `shouldEqual` false
        (toMaybe b.value) `shouldEqual` (Just 1)

        c <- liftEffect (next it)
        c.done `shouldEqual` false
        (toMaybe c.value) `shouldEqual` (Just 2)

        d <- liftEffect (next it)
        d.done `shouldEqual` false
        (toMaybe d.value) `shouldEqual` (Just 3)

        e <- liftEffect (next it)
        e.done `shouldEqual` false
        (toMaybe e.value) `shouldEqual` (Just 5)

        f <- liftEffect (next it)
        f.done `shouldEqual` false
        (toMaybe f.value) `shouldEqual` (Just 8)

        g <- liftEffect (next it)
        g.done `shouldEqual` true
        (toMaybe g.value) `shouldEqual` Nothing

      it "should be isomorphic to an array" do
        let it' = [1,2,3,4]

        xs <- liftEffect (toArray (iterator it'))
        xs `shouldEqual` it'
