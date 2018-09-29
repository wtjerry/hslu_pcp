mult(0,_,0).
mult(_,0,0).
mult(1,1,1).
mult(1,X,X).
mult(X,1,X).
mult(X,Y,R) :-
    X > 1,
    Y > 1,
    Ysub1 is Y-1,
    mult(X,Ysub1,R1),
    R is X + R1.
