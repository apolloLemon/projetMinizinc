include "globals.mzn";

int:n;
array[1..n] of var 1..n: Q;

constraint alldifferent(Q);

constraint forall([ 
  abs(Q[j]-Q[i])!=abs(j-i) 
  | i,j in 1..n where i!=j 
]);

constraint Q[1] <= n/2; % this constraint removes vertical symetry

%these might remove a couple rotations
constraint Q[n div 2] != 1;
constraint Q[n div 2] != n;
%constraint Q[n]       != n/2;%this doesn't improve anything, but was supposed to be the last


solve satisfy;