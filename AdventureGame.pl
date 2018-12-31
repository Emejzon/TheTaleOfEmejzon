#!/usr/bin/env swipl
% The Tale of Emejzon (text-based adventure game)
% by Jan Chudy
% This is not a final version of the game.
% Start the game with 'start.'

%TODO map, story, weapon ammo...

% -----------------------------------------------------------------
%  Initial texts and game mechanics.
% -----------------------------------------------------------------
%Runs the intro with menu.
start :- loadMechanics, devCheats, intro.

%Exits the game.
exit :- halt.

%Prints out the game intro and menu.
intro :- 
	nl,
	write('Welcome to ''The Tale of Emejzon'' text-based adventure game.'), nl,
	write('Reading ''help.'' is advised if you''re playing this game for the first time. :)'), nl, nl,
	write('~ play   -- Start a new game.'), nl,
	write('~ load   -- Load saved game.'), nl,
	write('~ help   -- Instructions and useful commands.'), nl,
	write('~ exit   -- Exit the game.'), nl.

%Prints out instructions and game commands.
help :- 
	nl,
	write('The game should provide enough information for you to solve all puzzles (except hidden rooms and secrets)'), nl,
	write('and beat the game. If you''re stuck, try ''look.'' to look around the room (you might be'), nl,
	write('missing something) or try going back to rooms you''ve already visited (you might have unlocked'), nl,
	write('some locked doors or you have an item enabling you to proceed now).'), nl, nl,
	write('COMMANDS:'), nl,
	write('~ help      -- Show this text again.'), nl,
	write('~ save      -- Save the current state of the game.'), nl,
	write('~ look      -- Look around the room. (Prints room description)'), nl,
	write('~ north     -- Go North [short:n].'), nl,
	write('~ south     -- Go South [short:s].'), nl,
	write('~ east     -- Go East [short:e].'), nl,
	write('~ west     -- Go West [short:w].'), nl,
	write('~ up        -- Go Up [short:u].'), nl,
	write('~ down      -- Go Down [short:d].'), nl,
	write('~ take ITEM     -- Take ITEM from the room (if possible).'), nl,
	write('~ drop ITEM     -- Drop ITEM from inventory (if possible).'), nl,
	write('~ examine ITEM     -- Examine ITEM in inventory.'), nl,
	write('~ use ITEM     -- Use ITEM in inventory (if possible).'), nl,
	write('~ combine ITEM1 ITEM2     -- Combine ITEMS in inventory (if possible).'), nl,
	write('~ inventory     -- Prints all items in your inventory [short:i].'), nl,
	write('~ kill     -- Kills an enemy in the room if you have the right weapon in your inventory.'), nl.

%Starts the story and asserts all stuff.
play :-
	consult("saves/NewGame.pl"),
	write('You are slowly waking up. You feel dizzy and you are lying on your back. You have a headache and your eyes'), nl,
	write('can''t focus on anything. As you are trying to stand up, your senses are returning back to normal.'), nl,
	write('There''s something in your pocket - piece of paper or a card? Try to look around.'), nl.

load :-
	exists_file("saves/Save.pl"),
	consult("saves/Save.pl"),
	write('SAVED GAME LOADED'), nl, !.
	
load :-
	write('No saved data!'), nl, false.

devCheats :-
	exists_file("saves/DevCheats.pl"),
	consult("saves/DevCheats.pl"), true, !.
devCheats:- !.

loadMechanics :- 
	consult("src/mechanics.pl"),
	consult("src/paths.pl"),
	consult("src/locations.pl"),
	consult("src/locDescriptions.pl"),
	consult("src/itemDescriptions.pl"),
	consult("src/kills.pl"),
	consult("src/usableItems.pl"),
	consult("src/crafting.pl"), true, !.


% -----------------------------------------------------------------
%  Some helping instructions.
% -----------------------------------------------------------------
writePortalUsageMsg :-
	eventCount(portalUsed,0),
	write('You threw the small device to the ground emerging a blue portal under your feet. As you passed through'), nl,
	write('the hole you fell on the ground seing an orange portal closing above your head.'), nl.
writePortalUsageMsg :-
	eventCount(portalUsed,1),
	write('You threw device under your feet and landed on the other side of the portal.'), nl,
	write('I see you''re getting hang of it.'), nl.
writePortalUsageMsg :-
	eventCount(portalUsed,2),
	write('You used the portal and appeared somewhere else.'), nl.
writePortalUsageMsg :-
	eventCount(portalUsed,3),
	write('You teleported somewhere else.'), nl.
writePortalUsageMsg :-
	write('*Teleported*'), nl.

newLine :-
	nl.



%%%% THIS IS THE ENDING OG THE HISTORICALLY FIRST ITERATION OF THE GAME:
%% describe(cave) :-
%% 	write('There''s literally nothing inside this cave...'), nl,
%% 	finis_the_game, !.

