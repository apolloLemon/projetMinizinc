%apolloLemon
include "globals.mzn";

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
% in number/operation we have a list of 1..8
% the top then bottom of the 'squares' in left->right top->bottom order
% AND number/operatoin 9.12 we have top->bottom then left->right of the links between squares
% in number2/operation2 we have a list of 1..8
% left->right in squares ordered left->right top->bottom
% see 0.dzn and images

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Predicates

% Operation Predicate
% x o y = r
% o: 1:+ 2:- 3:*
%(this would be cool if it was a char code)
predicate op (var int:x, var int:y, var int:r, var 1..3 :o)=
  if     o=1 then r=x+y
  elseif o=2 then r=x-y
  elseif o=3 then r=x*y
  else false
  endif;
predicate op2 (var int:x, var int:y, var int:r, var int:s, var 1..3 :o)=
  if     o=1 then r*10+s=x+y
  elseif o=2 then r*10+s=x-y
  elseif o=3 then r*10+s=x*y
  else false
  endif;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Constraints

% All Operations Are True
constraint forall % . op . = .
  (i in 1..12)
  (op(number[i,1],number[i,2],number[i,3],operation[i]));
constraint forall % . op . = ..
  (i in 1..8)
  (op2(number2[i,1],number2[i,2],number2[i,3],number2[i,4],operation2[i]));


% Corner 
constraint forall
  (i in 1..8)
  (
    if i mod 2 = 1 then
      number[i,1]=number2[i,1] /\ number[i,3]=number2[i+1,1]
    else
      number[i,3]=number2[i,4] /\ number[i,1]=number2[i-1,4]
    endif
  );
  
% Silly Linker
constraint number2[2,2] = number[9,1];
constraint number2[3,2] = number[9,3];

constraint number2[6,2] = number[10,1];
constraint number2[7,2] = number[10,3];

constraint number[2,2] = number[11,1];
constraint number[5,2] = number[11,3];

constraint number[4,2] = number[12,1];
constraint number[7,2] = number[12,3];

% . op . = >0 .
% the decadigit of 4 digit operations can't be 0
constraint forall(i in 1..8)(number2[i,3]>0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
solve satisfy;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

output [
  show(number[i,1]) ++
  
  if fix(operation[i])=1 then "+"
  elseif fix(operation[i])=2 then "-"
  elseif fix(operation[i])=3 then "*"
  else "o" endif ++
  
  show(number[i,2]) ++
  "=" ++
  show(number[i,3]) ++ "\n"
  | i in 1..12
] ++ [
  show(number2[i,1]) ++
  
  if fix(operation2[i])=1 then "+"
  elseif fix(operation2[i])=2 then "-"
  elseif fix(operation2[i])=3 then "*"
  else "o" endif ++
  
  show(number2[i,2]) ++
  "=" ++
  show(number2[i,3]) ++ show(number2[i,4]) ++"\n"
  | i in 1..8
];