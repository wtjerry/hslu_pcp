:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_client)).
:- consult(relationship).


solve(relationship, Id) :-
    get_relationship(Id, Type, Person1, Person2),
    solve_relationship(Type, Person1, Person2, Result),
    post_relationship(Result, Id),
    !.

solve(sudoku, Id) :-
    write('ProblemId: '),
    write(Id),
    write('. Nope, not solving that'),
    !.

solve(_, _) :-
    write('Undefined problem type'),
    !.

% ---- solve relationship

get_relationship(Id, Type, Person1, Person2) :-
    atom_concat('http://localhost:16316/problem/relationship/', Id, Url),
    http_get(Url, Reply, []),
    json_to_prolog(Reply, relationship(_, Type, Person1, Person2)).

solve_relationship(Type, Person1, Person2, true) :-
    call(Type, Person1, Person2),
    !.

solve_relationship(Type, Person1, Person2, false) :-
    not(call(Type, Person1, Person2)),
    !.

post_relationship(Boolean, Id) :-
    prolog_to_json(relationship_solution(Boolean, Id), Json),
    http_post('http://localhost:16316/problem/relationship', json(Json), _, []).


% ---- json object declations

:- json_object
    relationship(problemKey:integer, relationship:atom, firstPerson:atom, secondPerson:atom),
    relationship_solution(solution:atom, problemKey:integer).

