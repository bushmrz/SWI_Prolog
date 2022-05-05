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
child(X,Y) :- (man(X)|woman(X)),parent(Y,X).
fatherX(X) :- man(Y), parent(Y,X), write(Y),nl,fail.

%12
sister(X,Y) :- woman(X), parent(Z,X), parent(Z,Y), man(Z), not(X=Y).
sisters(X) :- parent(Z,X), parent(Z,Y), woman(Y),woman(Z), not(X=Y), write(Y), nl, fail.

%13
grand_ma(X,Y) :- woman(X), parent(X,Z), parent(Z,Y).
grand_mas(X) :- parent(Y,Z),parent(Z,X), woman(Y), write(Y), write(' grm '), write(X).

%14
grand_ma_and_son(X,Y) :- (woman(X), parent(X,Z), parent(Z,Y), man(Y), write(X), write(' grm '), write(Y)) | (man(X), parent(Y,Z), parent(Z,X), woman(Y), write(X), write(' grn s '), write(Y)).

