friend(X,Y):-
  knows(X,Y).
friend(X,Z):-
  knows(X,Y),
  friend(Y,Z).

knows(brian,somebodyElse).
knows(brian,tom).
knows(tom,peter).

