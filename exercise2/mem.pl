mem(X, [X, _]).
mem(X, [_| Tail]) :- mem(X, Tail).
