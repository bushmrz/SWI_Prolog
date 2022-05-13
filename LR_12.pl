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
