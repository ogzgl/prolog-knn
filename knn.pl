:- use_module(library(dcg/basics),
              [blank//0, white//0, integer//1, number//1, string_without//2]).

load_iris_file(Filename) :-
    phrase_from_file(iris_file, Filename).

calc_dist_helper(A,150,DR):-
    iris(A,X1,Y1,T1,U1,Spec1), 
    iris(150,X2,Y2,T2,U2,Spec2), 
    DIST  is ((X1-X2)^2+ (Y1-Y2)^2+ (T1-T2)^2+(U1-U2)^2)^(1/2),
    append_to_list(DR,DIST).
calc_dist_helper(A,C,DR):-
    iris(A,X1,Y1,T1,U1,Spec1), 
    iris(C,X2,Y2,T2,U2,Spec2),
    DIST  is ((X1-X2)^2+ (Y1-Y2)^2+ (T1-T2)^2+(U1-U2)^2)^(1/2),
    append_to_list(DR,DIST),
    P is C+1,
    calc_dist_helper(A,P,DR).

calc_dist(150,DR,DM) :- 
    calc_dist_helper(150,1,DR),
    append_to_list(DM,DR).

calc_dist(X,DR,DM) :-
    calc_dist_helper(X,1,DR),
    append_to_list(DM,DR).

current_iris(150,DM) :- 
    calc_dist(150,[*|_],DM).
current_iris(X, DM):-
    calc_dist(X,[*|_],DM),
    Y is X+1,
    current_iris(Y,DM).

runit(K):-   
    load_iris_file('iris.txt'),
    DM = [[*]|_],
    KDM = [[*]|_],
    current_iris(1,DM),
    delete(DM,[*],X),
    Y = X,
    write(Y),
    take_mins_remover(K,Y,KDM,[*|_],1).

take_mins_remover(K,[H|T],KDM,TMP,150):-
    print("Nearest distances are given below:"),nl,
    writer(KDM).
take_mins_remover(K,[H|T],KDM,TMP,C):-
    delete(H,*,A),
    B = A,
    take_mins_recur(K,B,KDM,TMP,K),
    D is C+1,
    take_mins_remover(K,T,KDM,[*|_],D).

writer([]):- nl.
writer([H|T]):-
    write(H),nl,
    writer(T).

take_mins_recur(K,[H|T],KDM,TMP,0):- 
    append_to_list(KDM,TMP).
take_mins_recur(K,[H|T],KDM,TMP,R):-
    min_list([H|T],X),
    append_to_list(TMP,X),
    delete([H|T],X,A),
    V is R-1,
    take_mins_recur(K,A,KDM,TMP,V).

append_to_list(List,Item) :-
    List = [Start|[To_add|Rest]],
    nonvar(Start),
    (var(To_add),To_add=Item;append_to_list([To_add|Rest],Item)).

iris_file -->
    iris_line(Iris),
    { assertz(Iris) },
    !,
    iris_file.
iris_file --> [].

iris_line(iris(Order, Sepal_length, Sepal_width, Petal_length, Petal_width, Species)) -->
    [0'"], integer(Order), [0'"], white,
    number(Sepal_length), white,
    number(Sepal_width), white,
    number(Petal_length), white,
    number(Petal_width), white,
    [0'"], string_without("\"", Species_codes), [0'"], blank,
    { atom_codes(Species, Species_codes) }.