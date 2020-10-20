include "globals.mzn";

array[1..10] of var 1..10: n;

constraint alldifferent(n);

solve satisfy;

output [show(n)];