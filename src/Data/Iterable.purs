module Data.Iterable where

import Data.Undefinable (Undefinable)
import Effect (Effect)

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

-- | `next()` is an effectful function, treating a `Iterator value` as a stateful reference.
foreign import next :: forall value. Iterator value -> Effect { value :: Undefinable value, done :: Boolean }
