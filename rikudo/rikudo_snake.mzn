%apolloLemon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Variables
int:n;
array[1..n,1..3] of var int: snake;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Predicats

% TODO NextTo
predicate NextTo(array[1..3] of var int: I,array[1..3] of var int: J) = 
  false; % TODO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Constraints

% All Numbers Are Next To Each Other
constraint forall (i,j in 1..n where j-1==1)(
  let {
    array[1..3] of var int: I = [snake[i,x] | x in 1..3],
    array[1..3] of var int: J = [snake[j,x] | x in 1..3],
  } in NextTo(I,J)
);

% TODO All Valid Coordinates Are Used
% TODO All Tunnels Are Used

solve satisfy;