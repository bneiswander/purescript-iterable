module Data.Iterable
  ( class Iterable, iterator, unsafeIterator, Iterator, next, traverse_, toArray
  ) where

import Prelude (Unit, (<$), unit, (>>=), pure, void, bind, discard, (<$>), otherwise)
import Data.Maybe (Maybe (..), maybe)
import Data.Array (snoc) as Array
import Control.Monad.Rec.Class (tailRecM, Step (..))
import Foreign (Foreign, unsafeFromForeign)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import Effect.Ref (new, modify, read) as Ref

-- | The Iterable class corresponds to the Iterable interface in JS.
-- | Instances should have a canonical `Iterator` returned.
class Iterable iterable value | iterable -> value where
  -- | Returns the `Iterator` from an `Iterable`
  iterator :: iterable -> Iterator value
instance iterableArray ∷ Iterable (Array a) a where
  iterator = unsafeIterator

-- | Assume the `iterable` value has a property with the `Symbol.iterator` as the key, which is a nullary function
-- | returning the `Iterator`.
foreign import unsafeIterator :: forall iterable value. iterable -> Iterator value

-- | Corresponds to an `Iterator` object in JS.
foreign import data Iterator :: Type -> Type

foreign import nextImpl :: forall value. EffectFn1 (Iterator value) { value :: Foreign, done :: Boolean }

-- | `next()` is an effectful function, treating a `Iterator value` similarly to a `Ref`.
next :: forall value. Iterator value -> Effect (Maybe value)
next i = toMaybe <$> runEffectFn1 nextImpl i
  where
    toMaybe {done,value}
      | done = Nothing
      | otherwise = Just (unsafeFromForeign value)

-- | Consumes all values in the `Iterator`.
traverse_ :: forall value. (value -> Effect Unit) -> Iterator value -> Effect Unit
traverse_ f i = tailRecM go unit
  where
    go :: Unit -> Effect (Step Unit Unit)
    go _ = next i >>= \mv -> maybe (pure (Done unit)) (\x -> Loop unit <$ f x) mv

-- | Consumes all values in the `Iterator`, and turns it into an array.
toArray :: forall value. Iterator value -> Effect (Array value)
toArray i = do
  xsRef <- Ref.new []
  traverse_ (\x -> void (Ref.modify (\ys -> ys `Array.snoc` x) xsRef)) i
  Ref.read xsRef
