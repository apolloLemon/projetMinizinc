%apolloLemon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Variables
int:n; %size of the problem/board
array[1..n,1..3] of var int: snake; %array of coordinates
% successif numbers are NextTo each other on the board
% we can choose to make the coordinates the problem variables
% we can use cube coordinates

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Predicats

% TODO NextTo
predicate NextTo(array[1..3] of var int: I,array[1..3] of var int: J) = 
  true; % TODO

predicate ValidCoord(array[1..3] of var int: xyz)=
  let{%s use cube coordinates
    var int: x = xyz[1],
    var int: y = xyz[2],
    var int: z = xyz[3],
  } in x+y+z = 0
  /\   abs(x)<=3 /\ abs(y)<=3 /\ abs(z)<=3 %we need a formula for these values
/\true; %we might add other things here
  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Constraints

% All Coordinates Are Valid
constraint forall (i in 1..n)(
  let {
    array[1..3] of var int: xyz = [snake[i,j] | j in 1..3]
  } in ValidCoord(xyz)
);

% All Numbers Are Next To Each Other
constraint forall (i,j in 1..n where j-1==1)( % successif numbers i and j
  let {
    array[1..3] of var int: I = [snake[i,x] | x in 1..3], % coords of i
    array[1..3] of var int: J = [snake[j,x] | x in 1..3], % coords of j
  } in NextTo(I,J) % NextTo each other on the board
);

% TODO All Valid Coordinates Are Used
% We need the coordinates to be on the board
% and for all cells of the board to be used

% TODO All Tunnels Are Used
% in Rikudo some hexcells share a mandatory path between them

solve satisfy;