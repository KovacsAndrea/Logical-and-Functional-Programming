/*
9.     b. Define a predicate to determine the greatest common divisor
        of all numbers from a list.


gcd(N1 - integer,
    N2 - integer,
    D - result, gcd of N1 and N2, integer)
    flow model: (i, i, o), (i, i, i)
gcd (a, b) =
    a, if b = 0
    gcd(b, a%b), otherwise


for our problem:
gcd9 (L - list of integers,
      R - result, integer)
      flow model: (i, o), (i, i)
gcd9 ([l1,l2...ln]) =
      [], if the list is empty
      gcd(l1, gcd9([l2,l3...ln])), otherwise


*/

gcd(N1, 0, N1).
gcd(N1, N2, D):-
     N2 \= 0,
     P is mod(N1, N2),
     gcd(N2, P, D).

gcd9([], 0).
gcd9([H|T], R):-
    gcd9(T, RT),
    gcd(H, RT, PR),
    R is PR.


