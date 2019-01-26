'use strict';

exports.iterator = function() {
  return function(iterable) {
    return iterable[Symbol.iterator]();
  };
};

exports.next = function(iterator) {
  return iterator.next();
};
