/*1.
a. Write a predicate to determine the lowest common multiple of a list formed from integer numbers.
b. Write a predicate to add a value v after 1-st, 2-nd, 4-th, 8-th, … element in a list.
*/



/*a. We will use the great common divisor method. lcm(a, b) = a*b / (gcd(a, b))
so we will find the gcd of all the elements in a list
 gcd(a, b) = {
           a if b = 0
           b if a = 0
           gcd (b, a%b) otherwise
 }
 gcd(A, B, R)
     A - number
     B - number
     R - gcd
 flow model: (i, i, i) (i, i, o)
*/

gcd(0, B, B).
gcd(A, 0, A).
gcd(A, B, R):-
    P is mod(A, B),
    gcd(B, P, PR),
    R is PR.

/*
gcdList([l1,l2...ln], X) ={
           0 if n = 0
           gcd(l1, gcdList([l2,l3...ln], X)) otherwise
gcdList(L, X)
    L - list
    X - result
flow model (i, i) (i, o)
}
*/
gcdList([], 0).
gcdList([H|T], X):-
    gcdList(T, PX),
    gcd(H, PX, RX),
    X is RX.

/*
  main function: computes the product of all the elements from the list
  and then devides it by the gcd
*/
