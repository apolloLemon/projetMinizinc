include "globals.mzn";

% Can we place n queens on an n by n board ?
% without any queens threatening each other ?

int:n; %size of problem

% only one queen per column
% we can design that constraint into the datastructure
% the queens are columns
array[1..n] of var 1..n: Queen2row;
% for each Queen i, Queen2row[i] gives us the row
% the rows must be all different too
constraint alldifferent(Queen2row);

% for diagonals we can imagine the queens are points
% and the chessboard is a cartesian coordinate system
% we want to avoid slopes of +-1
constraint forall([ 
  abs(Queen2row[j]-Queen2row[i])!=abs(j-i) 
%  | i,j in 1..n where j>i %the where here constrains search space might be symetry breaking
  | i,j in 1..n where i!=j
]);

solve satisfy;
