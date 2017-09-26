'use strict';

exports.iterator = function(iterable) {
  return iterable[Symbol.iterator]();
};
