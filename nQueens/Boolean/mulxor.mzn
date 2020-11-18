%apolloLemon
%these predicates makes sur arrays have specific numbers of trues

%special case of the mulmor(x,1) which is the xor
predicate mulxor(array[int] of var bool: b) = 
  sum(i in 1..length(b))(bool2int(b[i])) == 1;
  
predicate mulmor(array[int] of var bool: b, var int: m) = 
  sum(i in 1..length(b))(bool2int(b[i])) == m;
  
predicate mul2dmor(array[int,int] of var bool: b, var int: m )=
  sum(i,j in 1..length(b))(bool2int(b[i,j]))==m;
