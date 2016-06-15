% Author: Georgia Papaneofytou
% Date: 29-Dec-11

:-dynamic location/2.
:-dynamic time_needed/2.
:-dynamic flashlight/1.

:-nb_setval(start, 0).
:-nb_setval(tc, 0).

tourist(1).
tourist(2).
tourist(3).
tourist(4).
tourist(5).
tourist(6).
tourist(7).

side(left).
side(right).

%check if the value given for tourist is acceptable
app_tour(X):- tourist(X);
              (nl, write('ERROR: The value given for tourist is not acceptable'), nl, !, fail).

%check if the value for side is acceptable
app_side(Y):- side(Y);
              (nl, write('ERROR: The value given for side is not acceptable'), nl, !, fail).

%check if the value for time is acceptable
app_time(Z):- number(Z) -> true; (nl, write('ERROR: The value given for time is not acceptable'), nl, !, fail).

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
update_time(X, T):-  retractall(time_needed(X, _)), assert(time_needed(X, T)).
update_flash(Z):- retractall(flashlight(right)), retractall(flashlight(left)), assert(flashlight(Z)).

%Print status
status:- write('*************\tStatus\t*************'), nl,
         write('Person\t\t\tPosition'), nl,
         location(X,Y),write(X),write('\t\t\t'),write(Y), nl, fail;
         flashlight(Z), nl, write('flashlight\t\t'),write(Z), nl,
         write('*************************************'), nl.

%Clean memory and quit
quit:-   retract(location(_,_)), fail.

move_1(X, Y):- nb_getval(start, V), V=:=1 -> (
               (app_tour(X)->
               (app_side(Y)->
               (check_side(X, Y)->
               (flash_side(X)->
               (check_num(X, 2)->
               calc_time(X, 0, 0), update_loc(X, Y), update_flash(Y), write('Done'), nl; fail); fail); fail); fail); fail),
               status, !, win;
               status);check.


move_2(X1, X2, Y):-       nb_getval(start, V), V=:=1 -> (
                          ((app_tour(X1), app_tour(X2))->
                          (app_side(Y)->
                          (check_side(X1, Y)->
                          (check_ts(X1, X2, 0)->
                          (flash_side(X1)->
                          (check_num(X1, 3)->
                          (calc_time(X1, X2, 0), update_loc(X1, Y), update_loc(X2, Y), update_flash(Y)); fail); fail); fail); fail); fail); fail),
                          status, !, win;
                          status);check.

move_3(X1, X2, X3, Y):-   nb_getval(start, V), V=:=1 -> (
                          ((app_tour(X1), app_tour(X2), app_tour(X3))->
                          (app_side(Y)->
                          (check_side(X1, Y)->
                          (check_ts(X1, X2, X3)->
                          (flash_side(X1)->
                          (check_num(X1, 4)->
                          (calc_time(X1, X2, X3), update_loc(X1, Y), update_loc(X2, Y), update_loc(X3, Y), update_flash(Y)); fail); fail); fail); fail); fail); fail),
                          status, !, win;
                          status);check.

%Initial message to the user
:- write('**************************************************************************'), nl,
   write('How To Play:'), nl,
   write('Tourists: 1-7'), nl,
   write('Sides: left, right'), nl,
   write('First you must put every tourist and the flashlight at the side that you want.'), nl,
   write('Then give the time every tourist needs to cross the bridge and start playing.'), nl,
   write('You can insert the information by using the following functions:'), nl,
   write('***ins_loc(X, Y):\tPut X:tourist to Y:side'), nl,
   write('***ins_flash(Y):\tPut flashlight at Y side'), nl,
   write('***ins_time(X, T):\tX:tourist needs T:time to cross the bridge'), nl,
   write('You can move the tourists to the other side using the following functions:'), nl,
   write('***move_1(X, Y):\tMove X:tourist to Y:side'), nl,
   write('***move_2(X1, X2, Y):\tMove X1, X2:tourists to Y:side'), nl,
   write('***move_3(X1, X2, X3, Y):\tMove X1, X2, X3:tourists to Y:side'), nl,
   write('You can see where everybody is by using the function status.'), nl,
   write('Use quit. to quit the program'), nl.

%Check if all the data have been entered
check1:- (location(1, _),
             location(2, _),
             location(3, _),
             location(4, _),
             location(5, _),
             location(6, _),
             location(7, _),
             (flashlight(Y), app_side(Y)),
             time_needed(1, _),
             time_needed(2, _),
             time_needed(3, _),
             time_needed(4, _),
             time_needed(5, _),
             time_needed(6, _),
             time_needed(7, _));
             (nl, write('ERROR: You didn''t enter all the needed information'), nl, !, fail).

%there mustn't be any tourist alone at any side
%and we do not accept the situation where everybody is at the same side from the beginning
check2:- (findall(C1, location(C1, right), L1), length(L1, N1)),
              (findall(C2, location(C2, left), L2), length(L2, N2)),
              (N1 > 1, N2 > 1) -> true;
              (nl, write('ERROR: No tourist must be alone and not everybody \
              can be at the same side from the beginning!
              Please update the positions with the ins_loc(X,Y) function'), nl, !, fail).

check:- check1 -> (check2 -> (nb_setval(start, 1));fail);fail.

%insert info
ins_loc(X, Y):-  (app_tour(X), app_side(Y)) -> (update_loc(X, Y);fail).
ins_time(X, T):-  (app_tour(X), app_time(T)) -> (update_time(X, T);fail).
ins_flash(Z):- (app_side(Z)) -> (update_flash(Z);fail).