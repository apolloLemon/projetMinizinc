% A big problem with this code is the corner cases (see cornercase.img)
% with this model, single digits of operation results can't be individually from the .dzn
% also it's missing top corners....

include "globals.mzn";

array[1..20,1..3] of var int: numbers;
array[1..20] of var 1..3: operation;

predicate op (var int:x, var int:y, var int:r, var 1..3 :o)=
  if o=1 then r=x+y
  elseif o=2 then r=x-y
  elseif o=3 then r=x*y
  else false
  endif;

constraint forall
  (i in {3,8,13,18}) %i mod 5 = 3
  (numbers[i,3]=numbers[i-1,3] mod 10 /\ numbers[i,1]=numbers[i+1,3] mod 10);

constraint forall 
  (i in 1..20)
  (op(numbers[i,1],numbers[i,2],numbers[i,3],operation[i]));

solve satisfy;
