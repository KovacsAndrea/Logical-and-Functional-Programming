%product of even numbers from a list
%pr(L - list, R - result, integer)
%flow model (i, o ) - the result will be computed
%flow model (i, i) - the proposed retulr will be checked
pr([], 1).
pr([H|T], R):-
    mod(H,2)=:=0,
    pr(T, RT),
    R is RT*H.
pr([H|T], R):-
    mod(H,2)=\=0,
    pr(T, RT),
    R is RT.

%sum of elements from a list
%sum(L-List, S-Result, integer)
%suma(i, o)
sum([],0).
sum([H|T], S):-
    sum(T, SH),
    S is SH + H.

%insert an element E on a position P in a list L
%ins (L - list, E - elem - integer,
%     IP - insert pos - int, CP - curr pos - int
%     RL - result list)
% flow model: (i, i, i, i, o)
%
%                                       [] if the list is empty
% ins([l1,l2,l3...ln], e, ipos, cpos) = l1 U ins([l2,l3...ln], e, ipos,cpos) if ipos != cpos
%                                       e U ins([lcpos, lcpos+1...ln)],
%
%
ins([], E, _ , 1, [E]).
ins([], _, _, _, []).
ins(L, E, IP, CP, R):-
    CP=:=IP,
    NewCP is CP+1,
    ins(L, E, IP, NewCP, RT),
    R = [E|RT].
ins([H|T], E, IP, CP, R):-
    NewCP is CP+1,
    ins(T, E, IP, NewCP, RT),
    R = [H|RT].
