%apolloLemon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Variables
int:r; %size of problem
int:n; %size of array
array[1..n,1..3] of var int: snake; %array of coordinates
% successif numbers are NextTo each other on the board
% we can choose to make the coordinates the problem variables
% we can use cube coordinates

int:t; % number of tunnels
array[1..t,1..2,1..3] of var int: tunnels; %array of couples of coordinates
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

% Different
predicate Different(array[1..3] of var int: I,array[1..3] of var int: J) = 
  let{%s use cube coordinates
    var int: ix = I[1], var int: jx = J[1],
    var int: iy = I[2], var int: jy = J[2],
    var int: iz = I[3], var int: jz = J[3]
  } in (ix != jx)  \/ (iy != jy) \/ (iz != jz); % all coords are differ

%Valid Coordinate
predicate inrange(var int: x) = 
  abs(x)<=r; %

predicate ValidCoord(array[1..3] of var int: xyz)=
    sum(xyz) = 0
/\  forall(i in 1..3)(inrange(xyz[i]))
% 0,0,0 isn't valid
/\ let { array[1..3] of var int: zero = [0,0,0] } in Different(xyz,zero)
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

% All Coordinates Are Different
constraint forall (i,j in 1..n where i<j)( %i<j to only check each couple once
           %we could not check neighbours
  let {
    array[1..3] of var int: I = [snake[i,x] | x in 1..3], % coords of i
    array[1..3] of var int: J = [snake[j,x] | x in 1..3], % coords of j
  } in Different(I,J) % Different to each other
);


% All Tunnels Are Used
% if in a sequence of 3 numbers the middle one is at the opening of a tunnel
% then either the one before or after is at the other opening of the tunnel

% we loop over the snake in chunks of 3, a "part of a snake"
constraint forall (i,j,k in 1..n where j-i=1 /\ k-j=1)( % successif numbers i, j and k
  let {
    array[1..3] of var int: I = [snake[i,x] | x in 1..3], % coords of i
    array[1..3] of var int: J = [snake[j,x] | x in 1..3], % coords of j
    array[1..3] of var int: K = [snake[k,x] | x in 1..3], % coords of k
  } in forall(s in 1..t)(
      let { %for each part of the snake we see if it is near any tunnels
        array[1..3] of var int: A = [tunnels[s,1,x] | x in 1..3], % coords of A
        array[1..3] of var int: B = [tunnels[s,2,x] | x in 1..3], % coords of B
      } in (
      if (Different(J,A) /\  Different(J,B)) then true else (
      % if a part of the snake is next to a tunnel it must go through
      % we know that if the middle J of the part is at a tunnel extremity
      % thus I or J must be at the other end of the tunnel
         (if ( not Different(J,A) ) then 
            (not Different(I,B) \/ not Different(K,B) )else false endif
          ) \/ (
          if ( not Different(J,B) ) then 
            (not Different(I,A) \/ not Different(K,A) ) else false endif)
      )endif
      )
  )
);
% All Tunnels are Valid
constraint forall(s in 1..t)(
  let {
    array[1..3] of var int: A = [tunnels[s,1,x] | x in 1..3], % coords of A
    array[1..3] of var int: B = [tunnels[s,2,x] | x in 1..3], % coords of B
  } in ValidCoord(A) /\ ValidCoord(B) /\ NextTo(A,B)
);

solve satisfy;

output	["rikudo snake:\n"] ++
	[	show(snake[i,j]) ++ "\t"++
	 	if j = 3 then "xyz of "++show(i)++"\n" else "" endif
	|	i in 1..n, j in 1..3
	];