/* es. 11 */
occurs_in(X,X).	/*Se mettessi il cut genererei un solo risultato, quindi non lo metto */
occurs_in(X,Y):-occbis(X,Y).

occbis(H ,[H|_]).
occbis(X ,[_|C]):-occurs_in(X,C).

/* treemem(+T,?X) = X e' l'etichetta di un nodo dell'albero binario T */
/* empty o t(Root, Left, Right) */
treemem(t(X, _, _), X).
treemem(t(_, Left, _), X):-treemem(Left, X).
treemem(t(_,_,Right), X):- treemem(Right, X).

/* 2) Rappresentazione leaf(X), one(X,T), two(X, Left, Right) */



/* leaf(+X, ?T) = X e' l'etichetta di una FOGLIA di T */
leaf(t(X, empty, empty), X).
leaf(t(_, Left, _), X):-leaf(Left, X).
leaf(t(_,_,Right), X):-	leaf(Right, X).


/* merge di liste ordinate */
merge(X,[],X).
merge([],X,X).
merge([X|R1],[Y|R2],[X,Y|R]) :-
	X=Y, !,
	merge(R1,R2,R).
merge([X|R1],[Y|R2],[X|R]) :-
	X<Y, !,
	merge(R1,[Y|R2],R).
merge([X|R1],[Y|R2],[Y|R]) :-
	X>Y,
	merge([X|R1],R2,R).


/* Esercizio 2 */
/* fact(+X,?Y), vero se Y è il fattoriale di X */
fact(0,1).
fact(X,Y):- fact(X1,Y1), X is X1+1, Y is Y1*X.

/* ESERCIZIO 3 */
/* palindroma(X), vero se X è una lista palindroma */
palindroma([]).
palindroma([_]).
palindroma([X|Rest]):-append(H,[X],Rest),palindroma(H).

/* ESERCIZIO 4 */
/* maxlist(+L,?N) L è una lista di numeri, vero se N è il massimo elemento della lista L, fallisce se L è vuota */
maxlist([X],X).
maxlist([T|C],T):- maxlist(C,Y), T>=Y.
maxlist([T|C],N):- maxlist(C,N), N>T.


/* ESERCIZIO 5 */
/* avendo definito pari(x), definire split(+L, ?P, ?D)  se L è una lista di interi, P è la lista contenente tutti */
/* gli elementi pari di L e D tutti quelli dispari (nello stesso ordine in cui occorrono in L) */
pari(X):- 0 is X mod 2.

split([], [], []).
split([X|Rest1],[X|Rest2],D):- pari(X), !, split(Rest1, Rest2, D).
split([X|Rest1],P,[X|Rest2]):- split(Rest1, P, Rest2), !.

/* ESERCIZIO 7 */
/* prefisso(Pre,L) la lista Pre è un prefisso della lista L. */
/* Prefissi della lista [1,2,3] -> [],[1],[1,2],[1,2,3] */
prefisso([],_).
prefisso([X|R],[X|R2]):-prefisso(R,R2).

/* ESERCIZIO 8 */
/* suffisso(Suf,L) la lista Suf è un suffisso della lista L. Ad esempio [1,2,3] -> [],[3],[2,3],[1,2,3] */
suffisso([],[]).
suffisso([X|R],[X|R2]):- samelist(R,R2).
suffisso(S,[_|R]):-suffisso(S,R).

samelist([],[]).
samelist([X|R],[X|R2]):-samelist(R,R2).

/* ESERCIZIO 9 */
/* sublist(S,L) S è una sottolista di L costituita da elementi contigui in L */
/* Esempio [1,2,3] -> [],[1],[2],[3],[1,2],[2,3],[1,2,3] */
sublist([],[]).
sublist([X|Rest],[X|RestList]):- equal(Rest,RestList).
sublist(S,[_|RestList]):-sublist(S,RestList).

equal([],_).
equal([X|R],[X|R2]):-equal(R,R2).


/* ESERCIZIO 10c */
/* del_first(+X,+L,?Resto) Resto è la lista che si ottiene da L cancellando la prima occorrenza di X */
del_first(Y,[Y|Rest],Rest):- !.
del_first(X,[Y|Rest],[Y|Result]):- del_first(X, Rest, Result).


/* ESERCIZIO 10a */
/* subset(+Sub,?Set) Tutti gli elementi di Sub sono anche elementi di Set */
subset([],_):-!.
subset([X|C1],[X|C2]):-subset(C1,[X|C2]), !.
subset([X|C1],[_|C2]):-subset([X|C1],C2).

/* ESERCIZIO 10b */
/* rev(+X,?Y) Y è la lista che contiene gli stessi elementi di x ma in ordine inverso */
rev([X],[X]).
rev([X|Rest1],L):-append(H,[X],L), rev(Rest1,H).

/* ESERCIZIO 10d */
/* del(+X,+L,?Resto) Resto è la lista che si ottiene da L cancellando le occorrenze di X */
del(_,[],[]):-!.
del(X,[X|C],C2):-del(X,C,C2), !.
del(X,[Y|C],[Y|C2]):-del(X,C,C2).

/* ESERCIZIO 10e */
/* subst(+X,+Y,+L,-Nuova) Nuova è la lista che si ottiene da L sostituendo tutte */
/* le occorrenze di X con Y, se X non occorre, Nuova è uguale a L */
subst(_,_,[],[]):-!.
subst(X,Y,[X|C],[Y|C1]):-subst(X,Y,C,C1),!.
subst(A,B,[X|C1],[X|C2]):-subst(A,B,C1,C2).

/* ESERCIZIO 10f */
/* mkset(+L,-Set) Set è una lista senza ripetizioni che contiene tutti e soli */
/* gli elementi di L, senza utilizzare list_to_set/2 */
mkset([],[]).
mkset([X|Rest],[X|L]):- \+ member(X,Rest),!,mkset(Rest,L).
mkset([_|Rest],L):- mkset(Rest,L).

/* ESERCIZIO 10g */
/* union(+A,+B,-Union) Union è una lista senza ripetizioni che rappresenta l'unione di A e B */
union(A,B,Union):-union_with_rep(A,B,Result), mkset(Result,Union).
	/*Funzione di supporto che unisce due liste con repliche */
union_with_rep([],[],[]).
union_with_rep([X|R],B,[X|R2]):-union_with_rep(R,B,R2).
union_with_rep(A,[X|R],[X|R2]):-union_with_rep(A,R,R2).
union_with_rep([_|R],[_|R2],L):-union_with_rep(R,R2,L).

/* ESERCIZIO 11 b */
/* flat(+X,?Y) che riporti in Y tutti i termini che occorrono in X */
/* Esempio flat([a,[f(b),10,[c,d]]],Flat). -> Flat = [a,f(b),10,c,d]. */
flat([],[]).
flat([X|Rest],Y):- is_list(X), !, flat(X,R), flat(Rest,S), append(R,S,Y).
flat([X|Rest],Y):- flat(Rest,R), append([X],R,Y).

/* ESERCIZIO 12 */
/* cartprod(+A,+B,-Set), vero se A e B sono liste e Set una lista di coppie */
/* che rappresenta il prodotto cartesiano di A e B */
cartprod([],_,[]).
cartprod([X|R],B,Set):- getcomb(X,B,S), cartprod(R,B,Z), append(S,Z,Set).

getcomb(_,[],[]).
getcomb(X,[Y|R],[(X,Y)|R2]):-getcomb(X,R,R2).

/* ESERCIZIO 13 */
/* insert(X,L1,L2), vero se L2 si ottiene inserendo X in L1 in qualsiasi posizione */
/* almeno una delle due liste devono essere istanziate */
insert(X,[],[X]).
insert(X,[Y|R],L2):-append([X],[Y|R],L2); insert(X,R,S), append([Y],S,L2).

/* ESERCIZIO 14 */
/* permut(X,Y) vero se X e Y sono liste e Y è una permutazione di X (senza permutation/2)*/
permut([],[]).
permut([X|R],L):-permut(R,P), insert(X,P,L).

/* ESERCIZIO 15 */
/* search_subset(+IntList,+N,?Set), IntList è una lista di interi positivi */
/* N un intero positivo, vero se Set è una lista rappresentate un sottoinsieme */
/* di IntList tale che la somma degli elementi in Set è uguale a N (IntList senza ripetizioni)*/
search_subset([],0,[]).
search_subset(R,N,S):- sublist(S,R), sum(S,N).

sum([],0).
sum([X|R],N):- sum(R,S), N is X+S.
