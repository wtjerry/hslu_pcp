:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_client)).
:- use_module(library(clpfd)).
:- consult(relationship).
:- consult(sudoku).


solve(relationship, Id) :-
    get_relationship(Id, Type, Person1, Person2),
    solve_relationship(Type, Person1, Person2, Result),
    post_relationship(Result, Id),
    !.

solve(sudoku, Id) :-
    get_sudoku(Id, Sudoku),
    solve_sudoku(Sudoku, Solution),
    post_sudoku(Solution, Id),
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


% ---- solve sudoku

get_sudoku(Id, Sudoku) :-
    atom_concat('http://localhost:16316/problem/sudoku/', Id, Url),
    http_get(Url, Reply, []),
    json_to_prolog(Reply, sudoku(_, Sudoku)).

solve_sudoku(Sudoku, Solution) :-
    replace_0(Sudoku, Prepared_Sudoku),
    sudoku(Prepared_Sudoku),
    Solution = Prepared_Sudoku.

post_sudoku(Solution, Id) :-
    prolog_to_json(sudoku_solution(Solution, Id), Json),
    http_post('http://localhost:16316/problem/sudoku', json(Json), _, []).

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

