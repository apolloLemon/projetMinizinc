
include "globals.mzn";
int:n; 
% une seule reine par colonne
% nous pouvons concevoir cette contrainte dans la structure de données
% les reines sont des colonnes
array[1..n] of var 1..n: Q;
% pour chaque reine i, Q [i] nous donne la ligne
% pour les diagonales, on peut imaginer que les reines sont des points
% et l'échiquier est un système de coordonnées cartésien
% on veut éviter les pentes de + -1
constraint forall([ 
% la methode de la valeur abs
% abs(Q[j]-Q[i])!=abs(j-i)
% Notre proposition est plus optimale que la solution de la valeur absolue 
Q[i] != Q[j] /\ Q[i] + i != Q[j] + j /\ Q[i] - i != Q[j] - j 
     |i,j in 1..n where i!=j
]);

solve satisfy;

output	[show(n)]++[" queens :\n"] ++
	[	if fix(Q[i]) = j then "Q " else ". " endif ++
	 	if j = n then "\n" else "" endif
	|	i, j in 1..n
	];