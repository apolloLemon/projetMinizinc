include "globals.mzn";

int:n=4;
array[1..n] of var 1..n: col2Queen;

constraint alldifferent(col2Queen);

constraint forall([ 
  abs(col2Queen[j]-col2Queen[i])!=abs(j-i) 
  | i,j in 1..n where j>i 
]);

solve satisfy;