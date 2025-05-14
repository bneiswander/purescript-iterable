module Data.Iterable where

import Prelude

import Control.Monad.ST (ST, run)
import Control.Monad.ST.Uncurried (STFn1, runSTFn1)
import Data.Iterator (Iterator)
import Data.Iterator as Iterator

-- | The Iterable class corresponds to the Iterable interface in JS.
-- | Instances should have a canonical `Iterator` returned.
class Iterable iterable value | iterable -> value where
  -- | Returns the `Iterator` from an `Iterable`
  iterator :: forall r. iterable -> ST r (Iterator value)

instance iterableArray ∷ Iterable (Array a) a where
  iterator = unsafeIterator

-- | Assume the `iterable` value has a property with the `Symbol.iterator` as the key, which is a nullary function
-- | returning the `Iterator`.
foreign import unsafeIteratorImpl :: forall iterable value r. STFn1 iterable r (Iterator value)

-- unsafeIterator :: forall iterable value. iterable -> forall r. ST r (Iterator value)
unsafeIterator :: forall iterable r value. iterable -> ST r (Iterator value)
unsafeIterator = runSTFn1 unsafeIteratorImpl

toArray :: forall iterable value. Iterable iterable value => iterable -> Array value
toArray i = run (Iterator.toArray =<< iterator i)
