% -----------------------------------------------------------------
%  All killing possibilities.
%  Kill: kill :- @playerPos(X), @isAlive(Y) @itemPos(Z,inventory), write(M).
%  Where:
%		- @ -> represents an optional Instruction
%       - X -> name of player's position
%		- Y -> name of the monster in the room
%		- Z -> name of the weapon that can be used to kill Y
%		- M -> message printed on the screen
% -----------------------------------------------------------------
kill :-
	playerPos(home),
	isAlive(fly),
	itemPos(swatter,inventory),
	write('You swing the swatter with ease. Fly dissolves midair as the swatter "whooshes" through the air.'), nl,
	write('The swatter sure is magical.'), nl,
	retract(isAlive(fly)), !.

kill :-
	playerPos(home),
	isAlive(fly),
	write('You''re trying to kill the fly with your hands, though the fly is fast. Fly wins this time...'), nl, !.

kill :-
	playerPos(adytum),
	isAlive(turret),
	itemPos(the_stick_of_truth, inventory),
	itemPos(lamp, inventory), used(matches),
	write('You threw The Stick of Truth at the robot. It falls on its side revealing its gatling guns. "~OOOooowww~"'), nl,
	write('It opens fire uncontrollably for a few seconds. "~Shutting down...~" Its red eye turns off'), nl,
	write('and the robot deactivates.'), nl,
	retract(itemPos(the_stick_of_truth,inventory)), assert(itemPos(the_stick_of_truth,adytum)),
	retract(isAlive(turret)), !.
	
kill :-
	playerPos(village_north),
	(itemPos(the_stick_of_truth,inventory);itemPos(stick,inventory)),
	write('Hmmm... Kill Claptrap? You monster! And are you going to throw a stick at him or what?'), nl, !.

kill :-
	playerPos(village_north),
	write('You wouldn''t kill Claptrap, would you?!'), nl, !.

%default
kill :-
	write('What are you trying to kill? Boredom..?'), nl, !.