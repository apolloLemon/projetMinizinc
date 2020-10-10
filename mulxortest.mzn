include "mulxor.mzn";

array[1..20] of var bool: statements;

constraint mulxor(statements);
%constraint forall(i in 1..20 where i mod 2 == 1)(statements[i]==false);
solve satisfy;