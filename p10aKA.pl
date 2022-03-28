/*
10. a. For a list of integer numbers, define a predicate to write twice in
list every prime number.
*/

/*First a function that determines if a number is prime
prime(n, i) = {
    true if n = 2,
    true if i*i > n,
    prime(n, i + 1) otherwise.
}
*/
/*prime(N, I),
    N - given number integer
    I - divisor, integer
  flow model (i, i)
*/
prime(2, _).
prime(N, I):-
    P = I*I,
    N < P.
prime(N, I):-
    D is mod(N, I),
    D \= 0,
    prime(N, I+1).

/*isPrime(N),
    N - integer, given number
  isPrime(n) = {
      prime(N, 2) if N >= 2
      false otherwise
  }
  flow model (i)
*/
isPrime(N):-
    N >= 2,
    prime(N, 2).

/*primeList([l1,l2..ln]) = {
      [] if n = 0
      l1 U l1 U primeList([l2,l3...ln]) if l1 is prime,
      l1 U primeList([l2,l3...ln]) otherwise.
  }
 primeList(L, R)
      l - list of integers,
      R - result list, integers
 flow model (i, i), (i, o)
*/

primeList([], []).
primeList([H|T], R):-
    isPrime(H), !,
    primeList(T, PR),
    R = [H,H|PR].
primeList([H|T], R):-
    primeList(T, PR),
    R = [H|PR].

/*?- set_prolog_flag(answer_write_options,[max_depth(0)]).
true.
apparently won't show entire list without this?
primeList([], R).
primeList([-1], R).
primeList([2], R).
primeList([2,3,5,7], R).
primeList([2,2,3,3,5,5], R).
primeList([4,6,8,10,12,14,16],R).
primeList([4,4,6,6,8,8], R).
primeList([1,2,3,4,5,6,7,8,9,7],R).
primeList([2,3,1,4,7,5,8], R).
*/
