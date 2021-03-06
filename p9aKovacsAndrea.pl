%9.	a. Insert an element on the position n in a list.
% ins (L - list,
%       E - elem - integer,
%       IP - insert position - int,
%       CP - curent position - int
%       RL - result list)
% flow model: (i, i, i, i, o)
%
%
% ins([l0,l1,l2...ln-1], E, IP, CP, []) ={
%    [E] if the list is empty and CP == 0
%    [E] if we are inserting an element on the position n <=> CP = n and
%                                                             IP = n
%    [] if the list is empty and CP != 0 or CP !=n or IP !=n
%    (the two conditions above are not met)
%    l1 U ins ([l2,l3...ln], E, IP, CP, []) if CP != IP
%    e U ins ([lip,lip+1...ln] E, IP, CP, []) if CP == IP
%    }
% insMain([],10, 0, R).
% insMain([],10, 1, R).
% insMain([], 10, 2, R).
% insMain([1], 10, 2, R).
% insMain([1], 10, 1, R).
% insMain([1, 2], 10, 3, R).
% insMain([1, 2], 10, 3, R).
% insMain([2,3,4,5,6,7], 9, 3, R).
/*
 len(L, R)
 L - list
 R - result
 flow: (i, i), (i, o)
 len([l1,l2...ln]) = {
      0 if n = 0
      1 + len ([l2,l3...ln]) otherwise
 }
 */
len([], 0).
len([_|T], R):-
    len(T, RT),
    R is 1 + RT.

ins([], E, 0 , _, [E], _).
ins([], E, IP , CP, [E], LEN):-

    IP = LEN,
    CP = LEN.
ins([], _, _, _, [], _).
ins(L, E, IP, CP, R, LEN):-
    CP = IP,
    NewCP is CP+1,
    ins(L, E, IP, NewCP, RT, LEN),
    R = [E|RT].
ins([H|T], E, IP, CP, R, LEN):-
    NewCP is CP+1,
    ins(T, E, IP, NewCP, RT, LEN),
    R = [H|RT].

%insMain flow model (i,i,i,o), (i,i,i,i)
insMain(L1, E, IP, R):-
    len(L1, LEN),
    ins(L1, E, IP, 0, R1, LEN),
    R = R1.
