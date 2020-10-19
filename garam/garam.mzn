%apolloLemon
include "globals.mzn";

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%Variables

% Equations
% Separated into four lists
array[1..16,1..3] of var 0..9: number; %this will hold n1 op  n2 = n3   numbers
array[1..4,1..4] of var 0..9: number2; %this will hold n1 op2 n2 = n3n4 numbers

array[1..16] of var 1..3: operation; %this will hold n1 op   n2 = n3   operations
array[1..4] of var 1..3: operation2; %this will hold n1 op2  n2 = n3n4 operations
% For the 'order' of the Equations:
% First left verticals, then right verticals
% Aaaand that's as much as I've got so far (see corner constraint for details)


%Predicates

% Operation predicate
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
  (i in 1..16)
  (op(number[i,1],number[i,2],number[i,3],operation[i]));
constraint forall % . op . = ..
  (i in 1..4)
  (op(number2[i,1],number2[i,2],number2[i,3],operation2[i]));

% TODO Corner Constraint/Predicate
% TODO Linker Constraint/Predicate

solve satisfy;
