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

%5(15). Дан целочисленный массив.
%Необходимо найти количество элементов,
%расположенных после последнего максимального.

%list = [2,3,4,7,9,4,3,9,2,3,1,0] , answ: 4
%

indexM([Head|Tail],I):-indexM(Tail,I,0,1,Head).
indexM([],I,I,_,_):-!.
indexM([H|T],I,IM,INow,M):-
    (   H>=M, NewIM is INow, NewM is H;
    NewIM is IM, NewM is M),
    NewIN is INow+1,
    indexM(T,I,NewIM,NewIN,NewM).

task15:- write('List: '), nl, read(N), read_list(N,List),
    write('Количество эл-в после последнего максимального: '),
    length_list(List,Lght), indexM(List,I),
    X is Lght-I-1, write(X),!.

%6. Дан целочисленный массив.
%Необходимо найти индекс минимального элемента.

indexMin([H|T],I):-indexMin(T,I,0,1,H).
indexMin([],I,I,_,_):-!.
indexMin([H|T],I,IMin,INow,Min):-
    (   H<Min,
        Min1 is H, IMin1 is INow;
    Min1 is Min, IMin1 is IMin),
    INow1 is INow + 1,
    indexMin(T,I,IMin1,INow1,Min1).

%List: 10. [5. 3. 2. 7. 8. 2. 1. 9. -1. 12. ] Min: 9

task16:- write('List: '), nl, read(N), read_list(N,List),
    write('Min: '),
    indexM(List,I), write(I),!.



%7(17). Дан целочисленный массив.
%Необходимо разместить элементы,
%расположенные до минимального, в конце массива.
concat1([],B,B):-!.
concat1([Head|Tail],B,[Head,T]):- concat1(Tail,B,T).

moveBeforeMin([H|T],List):-indexMin([H|T],IMin),
    moveBeforeMin([H|T],List,IMin,0,[]).
moveBeforeMin(L1,List,IMin,IMin,L2):- concat1(L1,L2,List),!.
moveBeforeMin([H|T],List,IMin,INow,NowList):-
    NewI is INow+1, concat1(NowList,[H],NewList),
    moveBeforeMin(T,List,IMin,NewI,NewList).

task17:- write('List: '), read(Count),read_list(Count,List),
    moveBeforeMin(List,NewList),
    write('New List: '),write_list(NewList),
    nl, indexMin(List,I), write(I),!.

% 8(18).Дан целочисленный массив и натуральный индекс (число, меньшее
% размера массива). Необходимо определить является ли элемент по
% указанному индексу локальным минимумом.

checkMin([F,S|_],0):-F<S,!.
checkMin([F,S|T],I):-checkLocMin(F,S,T,I,1).
checkLocMin(F,S,[],I,I):-S<F,!.
checkLocMin(F,S,[T|_],I,I):-S<F,S<T,!.
checkLocMin(_,S,[Next|T],I,INow):-NewI is INow+1, checkLocMin(S,Next,T,I,NewI).

%List: 7. [5. 6. 2. 1. 4. 5. 6] Ind: 4. Is local min: false.
%List: 7. [5. 6. 2. 1. 4. 5. 6] Ind: 3. Is local min: true.
task18:- write('List: '), read(Count),read_list(Count,List),
    write('Ind: '), read(I),
        write("Is local min: "),checkMin(List,I),!.
