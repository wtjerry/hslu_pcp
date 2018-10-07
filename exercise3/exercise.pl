% ?- add_tail(x, [a, b, c], L).
% L = [a, b, c, x].
add_tail(Element, [], [Element]).
add_tail(Element, [X], NewList) :- 
    NewList = [X, Element].
add_tail(Element, [X | XS], NewList) :- 
    add_tail(Element, XS, NewList2),
    NewList = [X | NewList2].


% ?- del([a, b, c], c, L).
% L = [a, b] 
del([], _, []).
del([Element | XS], Element, XS).
del([X | XS], Element, NewList) :-
    del(XS, Element, NewList2),
    NewList = [X | NewList2].
del([Element], _, [Element]).   % used to not "return" false when element to delete is not actually in list


% ?- mem_d(a, [a, b, c]).
% true.
% 
% ?- mem_d(x, [a, b, c]).
% false.
mem_d(Element, List) :-
    del(List, Element, Tmp),
    not(List = Tmp).


% ?- rev_acc([a, b, c, d], [], L).
% L = [d, c, b, a].
rev_acc([], L, L).
rev_acc([H | T], Acc, L) :- rev_acc(T, [H | Acc], L).


rev(Input, Output) :- rev_acc(Input, [], Output).


% warn(T) :- T < 80, write('Temperatur ok'), !.
% warn(T) :- T < 100, write('Temperatur sehr warm'), !.
% warn(_) :- write('Temperatur zu heiss').
warn(T) :- T < 80, write('Temperatur ok').
warn(T) :- T >= 80, T < 100, write('Temperatur sehr warm').
warn(T) :- T >= 100, write('Temperatur zu heiss').


mem(X, [X | _]).
mem(X, [_ | Tail]) :- mem(X, Tail).
% L=[_,_,_], mem(a,L), mem(b,L), mem(c,L), !.
% wenn alle 4 goals das erste mal gematched sind, werden a, b und c zu den jeweiligen anonymen variblen gebunden (in der Liste L) und es können desshalb keine weiteren matches mehr gefunden werden.
