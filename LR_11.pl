man(voeneg).
man(ratibor).
man(boguslav).
man(velerad).
man(duhovlad).
man(svyatoslav).
man(dobrozhir).
man(bogomil).
man(zlatomir).

woman(goluba).
woman(lubomila).
woman(bratislava).
woman(veslava).
woman(zhdana).
woman(bozhedara).
woman(broneslava).
woman(veselina).
woman(zdislava).

parent(voeneg,ratibor).
parent(voeneg,bratislava).
parent(voeneg,velerad).
parent(voeneg,zhdana).

parent(goluba,ratibor).
parent(goluba,bratislava).
parent(goluba,velerad).
parent(goluba,zhdana).

parent(ratibor,svyatoslav).
parent(ratibor,dobrozhir).
parent(lubomila,svyatoslav).
parent(lubomila,dobrozhir).

parent(boguslav,bogomil).
parent(boguslav,bozhedara).
parent(bratislava,bogomil).
parent(bratislava,bozhedara).

parent(velerad,broneslava).
parent(velerad,veselina).
parent(veslava,broneslava).
parent(veslava,veselina).

parent(duhovlad,zdislava).
parent(duhovlad,zlatomir).
parent(zhdana,zdislava).
parent(zhdana,zlatomir).

%11
father(X,Y) :- man(X), parent(X,Y).
fatherX(X) :- man(Y), parent(Y,X), write(Y),nl,fail.

%12
sister(X,Y) :- woman(X), parent(Z,X), parent(Z,Y), man(Z), not(X=Y).
sisters(X) :- parent(Z,X), parent(Z,Y), woman(Y),woman(Z), not(X=Y), write(Y), nl, fail.

%13
grand_ma(X,Y) :- woman(X), parent(X,Z), parent(Z,Y).
grand_mas(X) :- parent(Y,Z),parent(Z,X), woman(Y), write(Y), write(' grm '), write(X).

%14
grand_ma_and_son(X,Y) :- (woman(X), parent(X,Z), parent(Z,Y), man(Y), write(X), write(' grm '), write(Y)) | (man(X), parent(Y,Z), parent(Z,X), woman(Y), write(X), write(' grn s '), write(Y)).

%15
mult(X):- X>0,mult_digit(X,1),!.
mult_digit(0,1):-!.
mult_digit(X,Y):- X1 is X div 10, P is X mod 10, mult_digit(X1,Y1), Y is Y1*P.

%16
multR(X,Y):- X>0,!,mult_digit_D(X,Y,1),!.
mult_digit_D(X,Y,Z):- X > 0,!,
    X1 is X div 10, Z1 is Z*(X mod 10),
    mult_digit_D(X1,Y,Z1).
mult_digit_D(_,Y,Z):- Y is Z.


%17
couner(0,0):-!.
couner(X,Y):- X1 is X div 10, X2 is X mod 10,
    couner(X1,Y1), (X2 > 3, X2 mod 2 =:= 1 ->  Y is Y1+1; Y is Y1).

%18
countDig(X,Y):-  countDig(X,Y,0),!.
countDig(X,Y,Count):- X>0,!,
    X1 is X div 10,
    P is X mod 10,
    (P>3,P mod 2 =\= 0 -> Count1 is Count + 1; Count1 is Count),
    countDig(X1,Y,Count1).
countDig(_,Y,Z):- Y is Z.

% =/= ???? ??????-????, =:= - ??????-????

%19
fib(0,1):-!.
fib(1,1):-!.
fib(N,X):-N>1,
    N1 is N-1, N2 is N-2,
    fib(N1,X1),fib(N2,X2),
    X is X1+X2.

%20
fib_D(N,X):- fib_D(1,1,N,X,0),!.
fib_D(F1,F2,N,X,Count):- Count < N,!,
    F11 is F2,
    F21 is F1+F2,
    Count1 is Count+1,
    fib_D(F11,F21,N,X,Count1).
fib_D(_,F3,_,X,_):- X is F3.


