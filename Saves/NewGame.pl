% -----------------------------------------------------------------
%  Initial texts and game mechanics.
% -----------------------------------------------------------------
:- dynamic playerPos/1, itemPos/2, playerHealth/1, isAlive/1, used/1, described/1, isOpen/1, eventCount/2, teleportPos/1.
:- retractall(playerPos(_)), retractall(itemPos(_, _)), retractall(playerHealth(_)), retractall(isAlive(_)), retractall(used(_)),
    retractall(described(_)), retractall(isOpen(_)), retractall(eventCount(_, _)), retractall(teleportPos(_)).

% -----------------------------------------------------------------
%  All items positions.
%  Item position: itemPos(X,Y). Where:
%       - X -> name of the item
%       - Y -> name of the item position
% -----------------------------------------------------------------
itemPos(photo, inventory).
itemPos(swatter, home).
itemPos(old_letter, home).
itemPos(remote, home).
itemPos(stick, up_tree).
itemPos(egg, rabbit_hole).
itemPos(book, church).
itemPos(golden_key, church).
itemPos(rope, parsons_house).
itemPos(page, parsons_house).
itemPos(oil, woodcutter_house).
itemPos(lamp, old_house2).
itemPos(potion, old_house1).
itemPos(matches, claptrap).
itemPos(crowbar,well_east).


% -----------------------------------------------------------------
%  All monsters that are alive.
%  Alive monsters: isAlive(X). Where:
%       - X -> name of the monster
% -----------------------------------------------------------------
isAlive(fly).
isAlive(turret).
isAlive(zombie).


% -----------------------------------------------------------------
%  All event counters for repetitive events.
%  Event counter: eventCount(X,Y). Where:
%       - X -> name of the event.
%		- Y -> counter.
% -----------------------------------------------------------------
eventCount(remoteExamine, 0).
eventCount(wellEnter, 0).
eventCount(portalUsed, 0).


% -----------------------------------------------------------------
%  Player's current possition. CAN'T HAVE MORE THAN ONE VALUE! BE CAREFUL!
% -----------------------------------------------------------------
playerPos(home).


% -----------------------------------------------------------------
%  Player's current health. CAN'T HAVE MORE THAN ONE VALUE! BE CAREFUL!
% -----------------------------------------------------------------
playerHealth(1).


% -----------------------------------------------------------------
%  Teleportation destination. CAN'T HAVE MORE THAN ONE VALUE! BE CAREFUL!
% -----------------------------------------------------------------
teleportPos(adytum).