%apolloLemon
include "globals.mzn";

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%Variables

% Equations
% Separated into four lists
array[1..12,1..3] of var 0..9: number; %this will hold n1 op  n2 = n3   numbers
array[1..8,1..4] of var 0..9: number2; %this will hold n1 op2 n2 = n3n4 numbers
% two digit numbers need to have individual variables for each digit

% operations -> int (see Operation Predicate)
array[1..12] of var 1..3: operation; %this will hold n1 op   n2 = n3    operations
array[1..8] of var 1..3: operation2; %this will hold n1 op2  n2 = n3n4  operations
% For the 'order' of the Equations:
% ..wait


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Predicates

% Operation Predicate
% x o y = r
% o: 1:+ 2:- 3:*
%(this would be cool if it was a char code)
predicate op (var int:x, var int:y, var int:r, var 1..3 :o)=
  if o=1 then r=x+y
  elseif o=2 then r=x-y
  elseif o=3 then r=x*y
  else false
  endif;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%Constraints

% All Operations Are True
constraint forall % . op . = .
  (i in 1..12)
  (op(number[i,1],number[i,2],number[i,3],operation[i]));
constraint forall % . op . = ..
  (i in 1..8)
  (op(number2[i,1],number2[i,2],number2[i,3],operation2[i]));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TODO

% TODO Corner Constraint/Predicate
% What are Corners?
% in each loop the equations are connected at the corners
% thus some number(2) must be the same

% TODO Linker Constraint/Predicate
% What are the Linkers?
% the Equations that link the loops
% thus some number(2) must be the same

solve satisfy;