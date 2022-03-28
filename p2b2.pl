/*
b.Define a predicate to produce a list of pairs (atom n) from an initial list of atoms.
In this initial list atom has n occurrences.Eg.:numberatom([1, 2, 1, 2, 1, 3, 1], X) => X =[[1, 4], [2, 2], [3, 1]].

First - a function that recieves a list, an element, and returns the
number of occurances of that element in a list and then deletes all
occurances of that element from the list
nrOccDelete([l1,l2...ln], E)= {
    [] if n = 0
    [l1] U nrOccDelete([l2,l3...ln], E)
    nrOccDelete([l2,l3...ln], E) if l1 != E
}
*/

/*nrOccDelete(L, E, C, RL)
     L - input list of integers
     E - the element we want to find nrOcc for and delete the occ from
     the list
     C - nr of occ
     RL - the resulted list
flow model: (i, i, o, o), (i, i, i, i)
*/
nrOccDelete([], _, 0, []).
nrOccDelete([H|T], E, C, RL):-
    H = E,
    nrOccDelete(T, E, PC, PRL),
    C is PC + 1,
    RL = PRL.
nrOccDelete([H|T], E, C, RL):-
    H \= E,
    nrOccDelete(T, E, PC, PRL),
    C is PC,
    RL = [H|PRL].

/*numberAtom(L, X)
     L - input list of numbers
     X - result list
 flow model: (i, o), (i, i)
 numberAtom ([l1,l2...ln]) = {
                [] if n = 0,
                [l1|nrOccDelete([l1,l2,...ln], l1)] U
                numberAtom[p1,p2...pn] where that's the list returned by
                nrOccDelete
}
*/
numberAtom([],[]).
numberAtom([H|T], X):-
    nrOccDelete([H|T], H, C, RL),
    numberAtom(RL, PX),
    X = [[H, C]|PX].



















