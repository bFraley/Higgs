load('benchmarks/ostrich/common_rand.js');
load('benchmarks/ostrich/backprop.js');

Float64Array = Array;
console = { log: function () {} }

NB_INPUT_ELEMS = 5000
runBackProp(NB_INPUT_ELEMS)

