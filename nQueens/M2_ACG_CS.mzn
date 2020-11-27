
include "globals.mzn";

int:n;
array[1..n] of var 1..n: Q;
% pour chaque reine i, Q [i] nous donne la ligne
% les lignes doivent être toutes différentes aussi c'est une contrainte globale

constraint alldifferent(Q);
constraint alldifferent(i in 1..n)(Q[i] + i);
constraint alldifferent(i in 1..n)(Q[i] - i);

% En cassant la symétrie
% cette contrainte supprime la symétrie verticale
constraint Q[1] <= n/2; 

solve satisfy;
output	[show(n)]++[" queens :\n"] ++
	[	if fix(Q[i]) = j then "Q " else ". " endif ++
	 	if j = n then "\n" else "" endif
	|	i, j in 1..n
	];
