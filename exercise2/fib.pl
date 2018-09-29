fib(0,0).
fib(1,1).
fib(X,R) :-
  Xsub1 is X-1,
  Xsub2 is X-2,
  fib(Xsub2, R1),
  fib(Xsub1, R2),
  R is R1 + R2.
