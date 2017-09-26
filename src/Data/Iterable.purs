module Data.Iterable where

import Data.Undefinable (Undefinable)

-- | The Iterable class corresponds to the Iterable interface in JS.
-- | Instances should have a property with the Symbol.iterator as the key. The
-- | property should return a function that takes no arguments and returns an
-- | Iterator
class Iterable iterable value | iterable -> value

-- | Returns the Iterator from an Iterable
foreign import iterator
  ∷ ∀ iterable value. Iterable iterable value ⇒ iterable → Iterator value

foreign import data Iterator ∷ Type → Type

foreign import next
  ∷ ∀ value
  . Iterator value
  → { value ∷ Undefinable value, done ∷ Boolean }

instance iterableArray ∷ Iterable (Array a) a
