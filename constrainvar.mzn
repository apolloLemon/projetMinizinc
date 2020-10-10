% in this .mzn 'a' can have multiple answers
% but despite this, in the .dzn we can constrain this

var int : a;

constraint a<10;

solve satisfy;

output[show(a)];