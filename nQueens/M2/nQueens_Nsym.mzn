%apolloLemon
include "globals.mzn";

int:n;
array[1..n] of var 1..n: Q;

constraint alldifferent(Q);

constraint forall([ 
%  abs(Q[j]-Q[i])!=abs(j-i)
  Q[i] + i != Q[j] + j /\ Q[i] - i != Q[j] - j %more efficient than abs() method
  | i,j in 1..n where i!=j 
]);

constraint Q[1] <= n/2; % this constraint removes vertical symetry


%%% After testing, these don't work on size 4..
%%% But the idea started for odd grids
%these might remove a couple rotations
%constraint Q[n div 2] != 1;
%constraint forall(i in 1..n where i >= n div 2)(Q[i]!=1); % generalise the 2 above?
%constraint Q[n div 2] != n;
%constraint forall(i in 1..n where i <= n div 2)(Q[i]!=n);
%constraint Q[n]       != n/2;%this doesn't improve anything, but was supposed to be the last


solve satisfy;
