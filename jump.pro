%Louis Gonzales
%CSCE 4430
%Source: http://sandbox.mc.edu/~bennet/cs404/doc/jump2_pl.html

% The starting board shape. The x's are filled in holes, the O's are empty.

% [ [o], [x, x], [x, x, x], [x, x, x, x] [x, x, x, x, x]]


% Possible jumps that can be made on a line.

jumptheline([x, x, o | T], [o, o, x | T]).

jumptheline([o, x, x | T], [x, o, o | T]).

jumptheline([H|T1], [H|T2]) :- jumptheline(T1,T2).


% Rotations

rotate([ [A], [B, C], [D, E, F], [G, H, I, J], [K, L, M, N, O]],
        [ [K], [L, G], [M, H, D], [N, I, E, B], [O, J, F, C, A]]).



% Jump the Line

horjump([A|T],[B|T]) :- jumptheline(A,B).

horjump([H|T1],[H|T2]) :- horjump(T1,T2).


% One legal jump.

jump(B,A) :- horjump(B,A).

jump(B,A) :- rotate(B,BR), horjump(BR,BRJ), rotate(A,BRJ).

jump(B,A) :- rotate(BR,B), horjump(BR,BRJ), rotate(BRJ,A).


% Series of legal boards.

series(From, To, [From, To]) :- jump(From, To).

series(From, To, [From, By | Rest])
        :- jump(From, By), 
           series(By, To, [By | Rest]).


% Print a series of inputed boards and prints them back out in the correctly formatted shape

print_series_r([]) :- 
    write_ln('-------------------------------------------------------').

print_series_r([X|Y]) :- write_ln(X), print_series_r(Y).

print_series(Z) :- 
    write_ln('\n-------------------------------------------------------'),
    print_series_r(Z).



% A solution for the classic 15 holes problem. 

solution(L) :- series([[o], [x, x], [x, x, x], [x, x, x, x], [x, x, x, x, x]],
                   [[x], [o, o], [o, o, o], [o, o, o, o], [o, o, o, o, o]], L).


% Use this to print out the complete solution to the final 15 hole problem.

solve :- solution(X), print_series(X).

% Find all the solutions possible

solveall :- solve, fail.

% Shows the steps of solution

solvestep(Z) :- Z = next, solution(X), print_series(X).
