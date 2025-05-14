module Test.Data.Iterable where

import Prelude

import Control.Monad.ST.Global (toEffect)
import Data.Iterable (iterator, toArray)
import Data.Iterator (next)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class (liftEffect)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)

main ∷ Effect Unit
main = runSpecAndExitProcess [ consoleReporter ] do
  describe "purescript-iterable" do
    describe "iterator" do
      it "should return an iterator that can be iterated" do
        it <- liftEffect $ toEffect $ iterator [ 1, 1, 2, 3, 5, 8 ]

        a <- liftEffect $ toEffect (next it)
        a `shouldEqual` (Just 1)

        b <- liftEffect $ toEffect (next it)
        b `shouldEqual` (Just 1)

        c <- liftEffect $ toEffect (next it)
        c `shouldEqual` (Just 2)

        d <- liftEffect $ toEffect (next it)
        d `shouldEqual` (Just 3)

        e <- liftEffect $ toEffect (next it)
        e `shouldEqual` (Just 5)

        f <- liftEffect $ toEffect (next it)
        f `shouldEqual` (Just 8)

        g <- liftEffect $ toEffect (next it)
        g `shouldEqual` Nothing

      it "should be isomorphic to an array" do
        let it' = [ 1, 2, 3, 4 ]

        let xs = toArray it'
        xs `shouldEqual` it'
