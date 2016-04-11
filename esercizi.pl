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
palindroma([X]).
palindroma([X|Rest]):-append(H,[X],Rest),palindroma(H).

/* ESERCIZIO 4 */
/* maxlist(+L,?N) L è una lista di numeri, vero se N è il massimo elemento della lista L, fallisce se L è vuota */
maxlist([X],X).
maxlist([X|Rest],X):- is_max(Rest, X).
maxlist([X|Rest],N):- N>=X, maxlist(Rest, N).

is_max([], Element).
is_max([X|Tail], Element):-Element>=X, is_max(Tail, Element).


/* ESERCIZIO 5 */
/* avendo definito pari(x), definire split(+L, ?P, ?D)  se L è una lista di interi, P è la lista contenente tutti */
/* gli elementi pari di L e D tutti quelli dispari (nello stesso ordine in cui occorrono in L) */
pari(X):- 0 is X mod 2.

split([], [], []).
split([X|Rest1],[X|Rest2],D):- pari(X), !, split(Rest1, Rest2, D).
split([X|Rest1],P,[X|Rest2]):- split(Rest1, P, Rest2), !.










