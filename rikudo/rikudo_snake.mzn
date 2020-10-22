%apolloLemon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Variables
int:r; %size of problem
int:n; %size of array
array[1..n,1..3] of var int: snake; %array of coordinates
% successif numbers are NextTo each other on the board
% we can choose to make the coordinates the problem variables
% we can use cube coordinates

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Predicats

% ProblemSize
predicate ValidProblem(var int: range, var int: numbers) =
  sum(i in 1..range)(i*6) = numbers;


% NextTo
predicate NextTo(array[1..3] of var int: I,array[1..3] of var int: J) = 
  let{%s use cube coordinates
    var int: ix = I[1], var int: jx = J[1],
    var int: iy = I[2], var int: jy = J[2],
    var int: iz = I[3], var int: jz = J[3]
  } in abs(ix - jx) + abs(iy - jy) + abs(iz - jz) = 2; % Hex Distance = 1

%Valid Coordinate
predicate inrange(var int: x) = 
  abs(x)<=r; %

predicate ValidCoord(array[1..3] of var int: xyz)=
    sum(xyz) = 0
/\  forall(i in 1..3)(inrange(xyz[i]))
/\  true; %we might add other things here
  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Constraints

% The Problem is Valid
constraint ValidProblem(r,n);

% All Coordinates Are Valid
constraint forall (i in 1..n)(
  let {
    array[1..3] of var int: xyz = [snake[i,j] | j in 1..3]
  } in ValidCoord(xyz)
);

% All Numbers Are Next To Each Other
constraint forall (i,j in 1..n where j-i=1)( % successif numbers i and j
  let {
    array[1..3] of var int: I = [snake[i,x] | x in 1..3], % coords of i
    array[1..3] of var int: J = [snake[j,x] | x in 1..3], % coords of j
  } in NextTo(I,J) % NextTo each other on the board
);

% TODO All Valid Coordinates Are Used
% We need the coordinates to be on the board
% and for all cells of the board to be used
% 0,0,0 isn't valid

% TODO All Tunnels Are Used (low Priority)
% in Rikudo some hexcells share a mandatory path between them

solve satisfy;

output	["rikudo snake:\n"] ++
	[	show(snake[i,j]) ++ "\t"++
	 	if j = 3 then "xyz of "++show(i)++"\n" else "" endif
	|	i in 1..n, j in 1..3
	];