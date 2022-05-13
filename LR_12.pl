%1 
%Найти сумму простых делителей числа.
isDiv(Num,Div):- Num mod Div =:= 0,!.
isDiv(Num,Div):-Num >= Div*Div,
    NextDiv = Div + 1,
    isDiv(Num,NextDiv).
prime(1):-!.
prime(2):-!.
prime(Num):- Num>0, not(isDiv(Num,2)).

%up
sumSDiv(X,Y):- sumSDiv(X,X,Y).
sumSDiv(0,_,0):-!.
sumSDiv(X,Y,S):- Y mod X =:= 0 -> X1 is X-1,
    sumSDiv(X1,Y,S1),(prime(X) -> S is S1+X; S is S1);
    Y mod X =\=0 -> X1 is X-1, sumSDiv(X1,Y,S1), S is S1.

%down
sumSDiv_d(X,Y):-X>0,!,sumSDiv_d(X,X,Y,0),!.
sumSDiv_d(X,Y,S,Z):- X>0,!,
    (   Y mod X  =:= 0, prime(X) -> Z1 is Z+X, X1 is X-1,
        sumSDiv_d(X1,Y,S,Z1);
    Z1 is Z, X1 is X-1, sumSDiv_d(X1,Y,S,Z1)).
sumSDiv_d(_,_,S,Z):- S is Z.

%2
% Найти произведение таких делителей числа,
%сумма цифр которых меньше, чем сумма цифр исходного числа.

sumDig(X,S):-sumDig(X,S,0),!.
sumDig(X,Y,S):- X>0,!, Z is X mod 10, S1 is S+Z, X1 is X div 10,
    sumDig(X1,Y,S1).
sumDig(_,Y,S):- Y is S.

multDiv(X,Y):- sumDig(X,H), X1 is H, multDiv(X,X,Y,X1),!.
multDiv(1,_,1,_):-!.
multDiv(X,Y,S,SD):- Y mod X =:= 0 -> X1 is X-1,
    multDiv(X1,Y,S1,SD),sumDig(X,H),(H<SD -> S is S1*X; S is S1);
    Y mod X =\=0 -> X1 is X-1, multDiv(X1,Y,S1,SD), S is S1.
