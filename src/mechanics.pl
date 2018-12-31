% -----------------------------------------------------------------
%  Game mechanics.
% -----------------------------------------------------------------

%Finishes the story.
finis_the_game :- 
	nl,
	write('GAME OVER!'), nl, exit.

%Instruction finishing game due to death of the player.
kill_player :- 
	nl,
	write('YOU ARE DEAD!'),
	!, finis_the_game.

%Instructuons handling taking damage from enemies.
takeDamage :- 
	playerHealth(1),
	kill_player.

takeDamage :- 
	playerHealth(HP1),
	HP2 is HP1-1,
	retract(playerHealth(HP1)),
	assert(playerHealth(HP2)),
	hpInfo.

%Instructions handling healing.
heal_player(N) :-
	N = 0, hpInfo.

heal_player(N) :- 
	playerHealth(HP1),
	HP2 is HP1+1,
	retract(playerHealth(HP1)),
	assert(playerHealth(HP2)),
	NewN is N-1,
	heal_player(NewN).

%Instruction printing the health of the player.
hpInfo :- 
	playerHealth(HP),
	write('You have '),
	write(HP),
	write(' HP left.'), nl, !.

%Movement instructions (Following path and checking possibility).
move(Direction) :-
	playerPos(From),
	path(From,To,Direction),
	retract(playerPos(From)),
	assert(playerPos(To)),
	posName(To), !.

move(_) :- 
	write('You can''t go there.'), fail.

%Movement commands.
north :- move(n).
south :- move(s).
east :- move(e).
west :- move(w).
up :- move(u).
down :- move(d).
n :- move(n).
s :- move(s).
e :- move(e).
w :- move(w).
u :- move(u).
d :- move(d).

%Look Command. Describes the room and lists all items in the room.
look :- 
	playerPos(Room),
	describe(Room), nl,
	listItems(Room), nl, !.

inspect :- look.

%Instruction listing all items in the room.
listItems(Room) :-
	itemPos(Item,Room),
	write('There is a '),
	write(Item),
	write(' here.'), nl, false.

listItems(_).

%Instruction listing all items in your inventory 
i :- inventory.
inventory :-
	write('INVENTORY:'), nl,
	listInventory(inventory), nl.

listInventory(Inv) :-
	itemPos(Item,Inv),
	write('- '),
	write(Item), nl, false. 

listInventory(_).


%special case for picking up the portal token:
%take the toekn and set the portal destination position to current position
take(Item) :- 
	(Item = portal_token; Item = device), 
	playerPos(Room),
	itemPos(Item,Room),
	teleportPos(LastTpPos),
	retract(teleportPos(LastTpPos)),
	assert(teleportPos(Room)),
	retract(itemPos(Item,Room)),
	assert(itemPos(Item,inventory)),
	write('Taken.'), nl, !.

%Instruction picking up an item
take(Item) :- 
	playerPos(Room),
	itemPos(Item,Room),
	retract(itemPos(Item,Room)),
	assert(itemPos(Item,inventory)),
	write('Taken.'), nl, !.

take(Item) :-
	itemPos(Item,inventory),
	write('You already have this item in your inventory.'), nl, !.

take(_) :-
	write('This item is not here.'), nl.

%Instruction dropping an item.
drop(Item) :-
	itemPos(Item,inventory),
	playerPos(Room),
	retract(itemPos(Item,inventory)),
	assert(itemPos(Item,Room)),
	write('Dropped.'), nl, !.

drop(_) :-
	write('You do not have that item in your inventory.'), nl.

%Instruction for examininf an item in players inventory.
examine(Item) :-
	itemPos(Item,inventory),
	describeItem(Item),!.

examine(_) :- 
	write('You do not have that item in your inventory.'), nl.

%Instruction for using items in players inventory.
use(Item) :-
	itemPos(Item,inventory),
	usable(Item),
	useItem(Item),!.

use(Item) :-
	itemPos(Item,inventory),
	write('This item is not usable.'), nl, !.

use(_) :-
	write('You do not have that item in your inventory.'), nl.

%Instruction for combining items in players inventory.
combine(Item1, Item2) :-
	itemPos(Item1,inventory), itemPos(Item2,inventory),
	(craftingRecipe(Item1,Item2);craftingRecipe(Item2,Item1)),
	write('Combined.'), nl, !.

combine(Item1, Item2) :-
	itemPos(Item1,inventory), itemPos(Item2,inventory),
	write('This items cannot be combined.'), nl, !.

combine(_, _) :-
	write('You do not have that item(s) in your inventory.'), nl.

%Instruction increasing the event counter
incCounter(Event) :-
	eventCount(Event, Cnt),
	Cnt2 is Cnt + 1,
	retract(eventCount(Event,Cnt)),
	assert(eventCount(Event,Cnt2)).