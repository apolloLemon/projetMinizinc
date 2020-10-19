%apolloLemon
include "globals.mzn";

array[1..16,1..3] of var 0..9: numbers; %this will hold . op . = .  operations
array[1..4,1..4] of var 0..9: numbers2; %this will hold . op2 . = .. operations

array[1..16] of var 1..3: operation;
array[1..4] of var 1..3: operations2;

predicate op (var int:x, var int:y, var int:r, var 1..3 :o)=
  if o=1 then r=x+y
  elseif o=2 then r=x-y
  elseif o=3 then r=x*y
  else false
  endif;

constraint forall 
  (i in 1..16)
  (op(numbers[i,1],numbers[i,2],numbers[i,3],operation[i]));
constraint forall 
  (i in 1..4)
  (op(numbers2[i,1],numbers2[i,2],numbers2[i,3],operation2[i]));

solve satisfy;
