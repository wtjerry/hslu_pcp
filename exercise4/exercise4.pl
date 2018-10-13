:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_client)).
:- use_module(library(clpfd)).
:- consult(relationship).
:- consult(sudoku).
:- consult(problem).

relationship_url('http://localhost:16316/problem/relationship/').
sudoku_url('http://localhost:16316/problem/sudoku/').

solve(relationship, Id) :-
    get_problem(relationship_url, Id, relationship(_, Type, Person1, Person2)),
    solve_relationship(Type, Person1, Person2, Result),
    send_solution(relationship_url, relationship_solution(Result, Id)),
    !.
solve(sudoku, Id) :-
    get_problem(sudoku_url, Id, sudoku(_, Sudoku_0)),
    replace_0(Sudoku_0, Sudoku),
    sudoku(Sudoku),
    send_solution(sudoku_url, sudoku_solution(Sudoku, Id)),
    !.


% ---- relationship helpers

solve_relationship(Type, Person1, Person2, true) :-
    call(Type, Person1, Person2),
    !.
solve_relationship(Type, Person1, Person2, false) :-
    not(call(Type, Person1, Person2)),
    !.


% ---- sudoku helpers

replace_0(In, Out) :-
    maplist(replace_0_in_list, In, Out).
replace_0_in_list(In, Out) :-
    maplist(replace_0_in_atom, In, Out).
replace_0_in_atom(0, _).
replace_0_in_atom(X, X).


% ---- json object declations

:- json_object
    relationship(problemKey:integer, relationship:atom, firstPerson:atom, secondPerson:atom),
    relationship_solution(solution:atom, problemKey:integer),
    sudoku(problemKey:integer, sudoku:list),
    sudoku_solution(solution:list, problemKey:integer).

