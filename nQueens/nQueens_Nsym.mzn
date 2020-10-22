include "globals.mzn";

int:n;
array[1..n] of var 1..n: Q;

constraint alldifferent(Q);

constraint forall([ 
  abs(Q[j]-Q[i])!=abs(j-i) 
  | i,j in 1..n where i!=j 
]);

solve satisfy;