/*
12.Generate all sub-strings of a length 2*n+1, formed from values of 0,1 or -1, so a1 = ..., a2n+1 = 0 and |a(i+1) -ai| = 1 or 2, for every1 <= i <= 2n.
The length of the result lists is fixed, and the order matters, so we
will be using a sort of "modified" subsets function which at each call
will add 0 or 1 or -1.
generator(n) = {
     [] if the length of the list is 2n+2,
     0 if the length of the list is <= 2n+1, (or)
     1 if the length of the list is <= 2n+1,  (or)
     -1 if the length of the list is <= 2n+1.
}
generator(N - integer, the given length
          L - integer, the current length, initialized with 0
          R - list, the result
flow model(i, i, o), (i, i, i)
*/
generator(N, L, [0]):-
    L =:= N+1.
generator(N, L, R):-
    L=<N,
    LN is L+1,
    generator(N, LN, PR),
    R = [1|PR].
generator(N, L, R):-
    L=<N,
    LN is L+1,
    generator(N, LN, PR),
    R = [0|PR].
generator(N, L, R):-
    L=<N,
    LN is L+1,
    generator(N, LN, PR),
    R = [-1|PR].

generate_all(N, R):-
    CN is 2*N,
    %We compute the length were so we don't have to compute it in
    %each branch of the function
    findall(PR, generator(CN, 1, PR), R).

generator_wrapper(N, R):-
    CN is 2*N,
    generator(CN, 1, R).

% |a(i+1) -ai| = 1 or 2, so the absolute difference between any two
% numbers can be 1 or 2
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
% Now we need a function that checks if the difference between any
% consecutive numbers in a list is 1 or 2. Since we only have the values
% 0 or 1 or -1 in our list, the max possible absolute difference is 2,
% so we can get away with checking that the diff is greater or equal to
% 1.

%check_diff(l1...ln) =
%	true, diff(l1, l2) >= 1 and n = 2
%	check_diff(l2...ln, m), diff(l1, l2) >= 1 and n > 2
%	false, otherwise (because for a list with one or zero elements
%                          there would be nothing to check against) The
%check_diff(L:list), flow model (i)

check_diff([H1, H2]):-
    diff(H1, H2, RD),
    RD >= 1, !.
check_diff([H1, H2|T]) :-
    diff(H1, H2, RD),
    RD >= 1,
    check_diff([H2|T]).

%transforms a list into a string
list_to_string(L, R):-
    maplist(atom_chars, L, Lists),
    append(Lists, List),
    atom_chars(R, List).

one_solution(N, PR):-
    generator_wrapper(N, R),
    check_diff(R),
    list_to_string(R, PR).

all_solutions(N, R):-
    findall(PR, one_solution(N, PR), R).
