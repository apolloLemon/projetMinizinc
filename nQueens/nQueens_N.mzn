%apollolemon
include "globals.mzn";

% Can we place n queens on an n by n board ?
% without any queens threatening each other ?

int:n; %size of problem

% only one queen per column
% we can design that constraint into the datastructure
% the queens are columns
array[1..n] of var 1..n: Q;
% for each Queen i, Q[i] gives us the row
% the rows must be all different too
constraint alldifferent(Q);

% for diagonals we can imagine the queens are points
% and the chessboard is a cartesian coordinate system
% we want to avoid slopes of +-1
constraint forall([ 
%  abs(Q[j]-Q[i])!=abs(j-i)
  Q[i] + i != Q[j] + j /\ Q[i] - i != Q[j] - j %more efficient than abs() method
  | i,j in 1..n where i!=j
]);

solve satisfy;

output	[show(n)]++[" queens :\n"] ++
	[	if fix(Q[i]) = j then "Q " else ". " endif ++
	 	if j = n then "\n" else "" endif
	|	i, j in 1..n
	];