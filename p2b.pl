/*
frq([l1,l2...ln], E) =
0 if the list is empty
1 + frq([l2...ln], E) if l1 == E
0 + frq([l2...ln], E) if l1 != E
frq([],_,0).
frq([H|T], E, R):-
    H =:= E,
    frq(T, E, RT),
    R is 1 + RT.
frq([H|T], E, R):-
    H =\= E,
    frq(T, E, RT),
    R is RT.
/*
With frq we can determine the number of occurances of each element in
the given list.
numberatom([1, 2, 1, 2, 1, 3, 1], X) => X =[[1, 4], [2, 2], [3, 1]].
So when we get to the 1 on position 3, we can't add it again in the
result
so we will keep a copy of the initial list, and we know that from the
initial list elements will be removes as we progress. therefore
the frq from the copy list will be greater than the frequency from
the initial list only if th element was not added in the result list

number(L, CL, X)
       L - initial list
       CL - deletion list
       X - result list
The mathematical model will look like this:
number([l1,l2...ln], DL, X) = {
[] if the initial list is empty
X U [l1|frq(DL, l1)] if frq(DL, l1) == frq(L, l1)
X U number([l2,l3...ln], DL, X) otherwise
}

*/

number([],_,_).
number([H|T], CL, X):-
  F is frq([H|T], H, F),
  F2 is frq(CL, H, F2),
  F =:= F2,
  number(T, CL, RX),
  X = [[H|F]|RX].

number([H|T], CL, X):-
  F is frq([H|T], H, F),
  F2 is frq(CL, H, F2),
  F =\= F2,
  number(T, CL, X).
*/


