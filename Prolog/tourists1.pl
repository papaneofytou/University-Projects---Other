% Author: Georgia Papaneofytou
% Date: 29-Dec-11

:-dynamic location/2.
:-dynamic flashlight/1.

:-nb_setval(tc, 0).

%orismos arxikon katastaseon
tourist(1).
tourist(2).
tourist(3).
tourist(4).
tourist(5).
tourist(6).
tourist(7).

side(left).
side(right).

location(1, left).
location(2, left).
location(3, left).
location(4, left).
location(5, left).
location(6, right).
location(7, right).

time_needed(1, 12).
time_needed(2, 9).
time_needed(3, 8).
time_needed(4, 9).
time_needed(5, 10).
time_needed(6, 11).
time_needed(7, 15).

flashlight(right).

%check if the value given for tourist is acceptable
app_tour(X):- tourist(X);
              (nl, write('ERROR: The value given for tourist is not acceptable'), nl, !, fail).

%check if the value for side is acceptable
app_side(Y):- side(Y);
              (nl, write('ERROR: The value given for side is not acceptable'), nl, !, fail).

%check if tourists that need to be moved are on the same side
check_ts(K, L, M):-     (location(K, O), location(L, P), (O = P -> ((M \== 0) -> ((location(M, Q), (O = Q -> true; fail))); true); fail));
                        (nl, write('ERROR: The tourists you chose are not on the same side!'), nl, !, fail).

%check if the tourist is not already on the side you want to move him
check_side(X, Y):-    (side(Y), location(X, P), Y \== P);
                      (nl, write('ERROR: The tourist is already at this side!'), nl, !, fail).

%check if flashlight is on the same side as the tourist you want to move
flash_side(X):-  (flashlight(A), location(X, B), A == B);
              (nl, write('ERROR: The flashlight is on the other side!'), nl, !, fail).

%check if there will be more than one tourist on the side after you do the movement
check_num(X, D):-  (location(X, T), findall(C, location(C, T), L), length(L, N), ((N =:= D-1) -> true; (N>D -> true; (nl, write('ERROR: A tourist will stay alone!'), nl, !, fail)))).

%calculate time needed for each transportation
calc_time(E, F, G):-   (time_needed(E, H), (G \== 0 -> (time_needed(F, I), time_needed(G, J), T is H+I+J); (F \== 0 -> (time_needed(F, I), T is H+I); T is H)), write('Time needed for transportation from one side to the other:\t'), write(T), nl, nb_getval(tc, OT), total_time(OT, T)).

%calculate total time so far
total_time(OT, T):-  (NT is OT+T, nb_setval(tc, NT), write('Total time so far:\t'), write(NT), nl).

%winning situations: all at one side
win:- (findall(C, location(C, right), L), length(L, N), N =:= 7),
      write('Congratulations: You won!!!'), nl,
      !, quit, fail;
      (findall(C, location(C, left), L), length(L, N), N =:= 7),
      write('Congratulations: You won!!!'), nl,
      !, quit, fail.

%Update info
update_loc(X, Y):-  retractall(location(X, _)), assert(location(X, Y)).
update_flash(Z):- retractall(flashlight(right)), retractall(flashlight(left)), assert(flashlight(Z)).

%Print status
status:- write('*************\tStatus\t*************'), nl,
         write('Person\t\t\tPosition'), nl,
         location(X,Y),write(X),write('\t\t\t'),write(Y), nl, fail;
         flashlight(Z), nl, write('flashlight\t\t'),write(Z), nl,
         write('*************************************'), nl.

%Clean memory and quit
quit:-   retract(location(_,_)), fail.

move_1(X, Y):- (app_tour(X)->
               (app_side(Y)->
               (check_side(X, Y)->
               (flash_side(X)->
               (check_num(X, 2)->
               calc_time(X, 0, 0), update_loc(X, Y), update_flash(Y), write('Done'), nl; fail); fail); fail); fail); fail),
               status, !, win;
               status.


move_2(X1, X2, Y):-       ((app_tour(X1), app_tour(X2))->
                          (app_side(Y)->
                          (check_side(X1, Y)->
                          (check_ts(X1, X2, 0)->
                          (flash_side(X1)->
                          (check_num(X1, 3)->
                          (calc_time(X1, X2, 0), update_loc(X1, Y), update_loc(X2, Y), update_flash(Y)); fail); fail); fail); fail); fail); fail),
                          status, !, win;
                          status.

move_3(X1, X2, X3, Y):-   ((app_tour(X1), app_tour(X2), app_tour(X3))->
                          (app_side(Y)->
                          (check_side(X1, Y)->
                          (check_ts(X1, X2, X3)->
                          (flash_side(X1)->
                          (check_num(X1, 4)->
                          (calc_time(X1, X2, X3), update_loc(X1, Y), update_loc(X2, Y), update_loc(X3, Y), update_flash(Y)); fail); fail); fail); fail); fail); fail),
                          status, !, win;
                          status.

%Initial message to the user
:- write('**************************************************************************'), nl,
   write('How To Play:'), nl,
   write('Tourists: 1-7'), nl,
   write('Sides: left, right'), nl,
   write('You can move the tourists to the other side using the following functions:'), nl,
   write('***move_1(X, Y):\tMove X:tourist to Y:side'), nl,
   write('***move_2(X1, X2, Y):\tMove X1, X2:tourists to Y:side'), nl,
   write('***move_3(X1, X2, X3, Y):\tMove X1, X2, X3:tourists to Y:side'), nl,
   write('You can see where everybody is by using the function status.'), nl,
   write('Use quit. to quit the program'), nl,
   write('**************************************************************************'), nl.