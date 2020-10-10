include "globals.mzn";
include "../mulxor.mzn";

% Can we place n queens on an n by n board ?
% without any queens threatening each other ?

int:n; %size of problem

array[1..n,1..n] of var bool: board; %board[i,j]=true => queen

% this is a xor on column and row arrays made with list comprehensions
% to make sure there's only one queen per column and row
constraint forall(i in 1..n)(
            let {
              array[1..n] of var bool: C = [board[i,j] | j in 1..n], %array of column i
              array[1..n] of var bool: R = [board[j,i] | j in 1..n], %array of row i
            } in mulxor(C) /\ mulxor(R) %column/row i only has one queen
);

% but diagonals aren't checked 2(2n-3) to check using xor broadly
% if we check only for diagonals with queens on them, 
% or check that no two queens are on the same diagonal like in nqueens_n
% it could be faster

solve satisfy;

%output ["a clean 2d matrix of booleans pls" ];