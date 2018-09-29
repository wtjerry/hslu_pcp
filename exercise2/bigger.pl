bigger(elephant, horse).
bigger(horse, dog).
bigger(horse, sheep).

is_bigger(X, Y) :- bigger(X, Y).
is_bigger(X, Z) :- bigger(X, Y), bigger(Y, Z).

is_smaller(X, Y) :- is_bigger(Y, X).

