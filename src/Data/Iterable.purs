module Data.Iterable where

import Data.Undefinable (Undefinable)

-- | The Iterable class corresponds to the Iterable interface in JS.
-- | Instances should have a property with the Symbol.iterator as the key. The
-- | property should return a function that takes no arguments and returns an
-- | Iterator
class Iterable i

-- | Returns the Iterator from an Iterable
foreign import iterator ∷ ∀ a b. Iterable a ⇒ Iterator b ⇒ a → b

class Iterator i where
  next ∷ ∀ a. i → { value ∷ Undefinable a, done ∷ Boolean }

instance iterableArray ∷ Iterable (Array a)
