'use strict';

exports.unsafeIterator = function unsafeIterator(iterable) {
  return iterable[Symbol.iterator]();
};

exports.next = function next(iterator) {
  return function next_() {
    return iterator.next();
  };
};
