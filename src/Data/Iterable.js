'use strict';

export const unsafeIterator = function unsafeIterator(iterable) {
  return iterable[Symbol.iterator]();
};

export const nextImpl = function nextImpl(iterator) {
  return iterator.next();
};
