u(1).
u(X) :- v(X).
u(2).
v(_X) :- !, write("CUT").
v(123).
