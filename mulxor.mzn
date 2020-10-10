predicate mulxor(array[int] of var bool: b) = 
  sum(i in 1..length(b))(bool2int(b[i])) == 1