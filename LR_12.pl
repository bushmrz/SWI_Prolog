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
    
    
%3
%Пусть d ( n ) определяется как сумма собственных делителей n
%(чисел меньше n, которые делятся равномерно на n ).
%Если d ( a ) = b и d ( b ) = a ,
%где a ≠ b , то a и b являются дружественной парой,
%и каждый из a и b называется дружным числом.
% Например, правильными делителями 220 являются
%1, 2, 4, 5, 10, 11, 20, 22, 44,55 и 110;
%следовательно, d (220) = 284 Правильными делителями 284
%являются 1, 2, 4, 71 и 142; поэтому d (284) = 220
%Найдите количество всех пар дружных чисел до 10000
%Задача должна быть решена без использования списков.

sumDel(X,S):-isDel(X,X,S,0).
isDel(_,0,_,_):-!.
isDel(X,I,S,K):- I>1, not(I is X), X mod I =:= 0, !,  I1 is I-1,
    K1 = K+I, isDel(X,I1,S,K1).
isDel(X,I,S,K):- I>1,!,I1 is I-1, isDel(X,I1,S,K).
isDel(_,_,S,K):- S is K.

countFriend(Res):-countFriend(10,10,Res,0).
countFriend(0,0,Res,Res):-!.
countFriend(X,0,Res,NowRes):-X1 is X-1,countFriend(X1,X1,Res,NowRes).
countFriend(X,Y,Res,NowRes):-Y1 is Y-1, sumDel(X,DelX),sumDel(Y,DelY),
    (X is Y ,NewRes is NowRes;(DelX is DelY, NewRes is NowRes+1;NewRes is NowRes)), countFriend(X,Y1,Res,NewRes).

%4
%Построить предикат, получающий длину списка.

length_list([],0):-!.
length_list([Head|Tail],N):-length_list(Tail,N1), N is 1+N1.

read_list(0,[]):-!.
read_list(N,[Head|Tail]):-read(Head),
    N1 is N-1, read_list(N1,Tail).

write_list([]):-!.
write_list([Head|Tail]):-write(Head),nl,write_list(Tail).


