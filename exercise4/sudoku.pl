sudoku(Rows) :-
    append(Rows, Vs), Vs ins 1..9,                                  % allow only numbers 1 to 9
    maplist(all_distinct, Rows),                                    % all numbers different per row
    transpose(Rows, Columns),
    maplist(all_distinct, Columns),                                 % all numbers different per column
    Rows = [R1, R2, R3, R4, R5, R6, R7, R8, R9],
    blocks(R1, R2, R3), blocks(R4, R5, R6), blocks(R7, R8, R9),     % all numbers different per block
    maplist(label, Rows).

blocks([], [], []).
blocks(
    [C1R1, C2R1, C3R1 | Rest_Columns_Of_Row1],
    [C1R2, C2R2, C3R2 | Rest_Columns_Of_Row2],
    [C1R3, C2R3, C3R3 | Rest_Columns_Of_Row3]) :-
    all_distinct([C1R1, C2R1, C3R1, C1R2, C2R2, C3R2, C1R3, C2R3, C3R3]),
    blocks(Rest_Columns_Of_Row1, Rest_Columns_Of_Row2, Rest_Columns_Of_Row3).
