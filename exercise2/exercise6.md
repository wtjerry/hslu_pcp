a)
The term 'X is 16 / 5 / 2' contains 2 distinct operators: 'is' and '/'.
'is' preference: 700, type: xfx
'/' precedence: 400, type: yfx
'/' is therefore evaluated before 'is'.
eg pseudocode:
'X is (16 / 5 / 2)'
'/' is of type yfx (left-assiciative). The expression is therefore evaluated as:
'X is ((16 / 5) / 2)'

b)
?- Y = 3, X = Y-1.
Y = 3,
X = 3-1.
because '-' takes precedence over '='
Why is 2 not assigned to X? 
 -> because '=' was used which does matching / assigning without evaluating a potential arithmetic expression. If we would like to assign 2 to X we need to use 'is' instead of '='.

c)
see b)
