'use strict';

export const unsafeIteratorImpl = function unsafeIteratorImpl(iterable) {
  return iterable[Symbol.iterator]();
};
