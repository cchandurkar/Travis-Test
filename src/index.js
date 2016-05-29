
module.exports = (function(){

  // Use Strict
  'use strict';

  // Operation Map
  let opMap = new Map();
  opMap.set('+', (x, y) => x + y);
  opMap.set('*', (x, y) => x * y);
  opMap.set('-', (x, y) => x - y);
  opMap.set('/', (x, y) => x / y);
  opMap.set('%', (x, y) => x % y);

  // Travis Tester
  let travisTester = {
    compute: (a, operator, b) => opMap.has(operator) ? opMap.get(operator).call(this, a, b) : null,
  };

  // Export
  return travisTester;

}());
