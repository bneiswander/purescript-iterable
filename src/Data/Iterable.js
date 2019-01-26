'use strict';

exports.unsafeIterator = function unsafeIterator(iterable) {
  return iterable[Symbol.iterator]();
};

exports.nextImpl = function nextImpl(iterator) {
  return iterator.next();
};
