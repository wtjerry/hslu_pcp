% ?- set_difference([a, b, c, d], [b, d, e, f], [a, c]).
% true . 
% ?- set_difference([1, 2, 3, 4, 5, 6], [2, 4, 6], L).
% L = [1, 3, 5] .
% set_difference([], _, []).
% set_difference([In1Head | In1Tail], In2, Out) :-
%     set_difference(In1Tail, In2, Out2),
%     not(member(In1Head, In2)),
%     Out = [In1Head | Out2].

    
% set_difference([], _, []).
% set_difference([In1Head | In1Tail], In2, Out) :-
%     not(member(In1Head, In2)),
%     set_difference(In1Head, In2, Out2),
%     Out = [In1Head | Out2].
% 
% set_difference([In1Head | In1Tail], In2, Out) :-
%     member(In1Head, In2),
%     set_difference(In1Head, In2, Out).

set_difference([E | Set1], Set2, [E | SetDifference]) :-
    not(member(E, Set2)),
    set_difference(Set1, Set2, SetDifference).

set_difference([E | Set1], Set2, SetDifference) :-
    member(E, Set2),
    set_difference(Set1, Set2, SetDifference).

set_difference([], _, []).
