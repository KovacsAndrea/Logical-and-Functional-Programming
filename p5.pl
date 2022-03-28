% 5. Two integers, n and m are given.
% Write a predicate to determine all possible sequences of numbers from 1 to n,
% such that between any two numbers from consecutive positions,
% the absolute difference to be >= m.

% diff(a, b) =
%	b - a, a < b
%	a - b, a > b

% diff(A:number, B:number, R:number)
% diff(i, i, o)

diff(A, B, R) :-
    A < B,
    R is B - A.
diff(A, B, R) :-
    A > B,
    R is A - B.

% subsets(n, i) = {
%	[], i >= n + 1
%	i U sequences(n, i + 1), i <= n
%	sequences(n, i + 1), i <= n
%	}
% subsets(N:number, I:number, R:list)
% subsets(i, i, o)
% The sequences function generates all the subsets of the set
% [i, i+1, i+2... n], where i will start from 1.
% At each call we can either add i in the set or not

subsets(N, I, []) :-
    I >= N + 1, !.
subsets(N, I, R) :-
    I =< N,
    NI is I + 1,
    subsets(N, NI, PR),
    R = [I|PR].
subsets(N, I, R) :-
    I =< N,
    NI is I + 1,
    subsets(N, NI, R).

% check(l1...ln, m) =
%	true, diff(l1, l2) >= m and n = 2
%	check(l2...ln, m), diff(l1, l2) >= m and n > 2
%	false, otherwise (because for a list with one or zero elements
%                         there would be nothing to check against)
% The check function checks to see if the difference between any
% consecutive numbers is at least M.
% check(L:list, M:mumber) check(i, i)

check([H1, H2], M):-
    diff(H1, H2, RD),
    RD >= M, !.
check([H1, H2|T], M) :-
    diff(H1, H2, RD),
    RD >= M,
    check([H2|T], M).

% onesolution(N:number, M:number, R:list)
% onesolution(i, i, o)
% Generates one solution using the subsets function and then checks to
% see if the difference between any consecutive numbers is n. Subsets is
% given 1 as the second parameter so the set on wich it will operate is
% [1, 2, 3... n]

onesolution(N, M, R) :-
    subsets(N, 1, R),
    check(R, M).

% allsolutions(N:number, M:number R:list)
% allsolutions(i, i, o)
%
% set_prolog_flag(answer_write_options,[max_depth(0)]).
% allsolutions(4, 0, R).
% allsolutions(10, 1, R).
% allsolutions(10, 5, R).
allsolutions(N, M, R) :-
    findall(RPartial, onesolution(N, M, RPartial), R).
