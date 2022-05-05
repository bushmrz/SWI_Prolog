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



