include "globals.mzn";
include "../mulxor.mzn";

%------------------------------------------------------------------------------%
% Parameters

int: n; % size

%------------------------------------------------------------------------------%
% Variables

array[1..n,1..n] of var bool: board;

%------------------------------------------------------------------------------%
% Constraints

constraint forall(i, j in 1..n)(
	board[i,j] = not (
		exists(j1 in 1..n where j1 != j)(board[i,j1])     %check row/col
	\/	exists(i1 in 1..n where i1 != i)(board[i1,j])   %check col/row
	\/	exists(k in 1..n-1)(                             %check diagonals
			board[i+k,j+k] \/ board[i-k,j+k]
	    \/	board[i+k,j-k] \/ board[i-k,j-k]
		)
	)
);

constraint mul2dmor(board,n);                          %makes sure there are n queens

solve satisfy;