module Data.Iterator
  ( Iterator
  , next
  , toArray
  , traverse_
  ) where

import Control.Monad.ST.Uncurried

import Control.Monad.Rec.Class (tailRecM, Step(..))
import Control.Monad.ST (ST)
import Control.Monad.ST.Internal as ST
import Data.Array (snoc) as Array
import Data.Maybe (Maybe(..), maybe)
import Foreign (Foreign, unsafeFromForeign)
import Prelude (Unit, (<$), unit, (>>=), pure, void, bind, discard, (<$>), otherwise)

-- | Corresponds to an `Iterator` object in JS.
foreign import data Iterator :: Type -> Type

foreign import nextImpl :: forall value r. STFn1 (Iterator value) r { value :: Foreign, done :: Boolean }

-- | `next()` is an effectful function, treating a `Iterator value` similarly to a `Ref`.
next :: forall value r. Iterator value -> ST r (Maybe value)
next i = toMaybe <$> runSTFn1 nextImpl i
  where
  toMaybe { done, value }
    | done = Nothing
    | otherwise = Just (unsafeFromForeign value)

-- | Consumes all values in the `Iterator`.
traverse_ :: forall value r. (value -> ST r Unit) -> Iterator value -> ST r Unit
traverse_ f i = tailRecM go unit
  where
  go :: Unit -> ST r (Step Unit Unit)
  go _ = next i >>= \mv -> maybe (pure (Done unit)) (\x -> Loop unit <$ f x) mv

-- | Consumes all values in the `Iterator`, and turns it into an array.
toArray :: forall value r. Iterator value -> ST r (Array value)
toArray i = do
  xsRef <- ST.new []
  traverse_ (\x -> void (ST.modify (\ys -> ys `Array.snoc` x) xsRef)) i
  ST.read xsRef
