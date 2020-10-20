include "globals.mzn";

array[1..4,1..4] of var int: n;

constraint forall (i,j in 1..4)(
  let {
    array[1..4] of var int: C = [n[i,j] | j in 1..4]
    } in alldifferent(C)
);

solve satisfy;

output [show(n)];