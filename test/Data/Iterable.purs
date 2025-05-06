module Test.Data.Iterable where

import Data.Iterable
import Data.Maybe (Maybe(..))
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Prelude (Unit, discard, bind)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (runSpec)


main ∷ Aff Unit
main = runSpec [consoleReporter] do
  describe "purescript-iterable" do
    describe "iterator" do
      it "should return an iterator that can be iterated" do
        let it = iterator [1, 1, 2, 3, 5, 8]

        a <- liftEffect (next it)
        a `shouldEqual` (Just 1)

        b <- liftEffect (next it)
        b `shouldEqual` (Just 1)

        c <- liftEffect (next it)
        c `shouldEqual` (Just 2)

        d <- liftEffect (next it)
        d `shouldEqual` (Just 3)

        e <- liftEffect (next it)
        e `shouldEqual` (Just 5)

        f <- liftEffect (next it)
        f `shouldEqual` (Just 8)

        g <- liftEffect (next it)
        g `shouldEqual` Nothing

      it "should be isomorphic to an array" do
        let it' = [1,2,3,4]

        xs <- liftEffect (toArray (iterator it'))
        xs `shouldEqual` it'
