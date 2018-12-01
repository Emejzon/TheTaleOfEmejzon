#!/usr/bin/env swipl
% The Tale of Emejzon (text-based adventure game)
% by Jan Chudy
% This is not a final version of the game.
% Start the game with 'start.'

%TODO map, story, weapon ammo...

%IDEAS:
% The women in the picture are Lux and her Mother. Gerald (the Vladimir's son) was Lux's father


% -----------------------------------------------------------------
%  Initial texts and game mechanics.
% -----------------------------------------------------------------
 :- dynamic playerPos/1, itemPos/2, playerHealth/1, isAlive/1, used/1, described/1, isOpen/1, eventCount/2, teleportPos/1.
 :- retractall(playerPos(_)), retractall(itemPos(_, _)), retractall(playerHealth(_)), retractall(isAlive(_)), retractall(used(_)),
 	retractall(described(_)), retractall(isOpen(_)), retractall(eventCount(_, _)), retractall(teleportPos(_)).

%teleport for testing [TODO]: DELETE THIS
teletubbies(X) :-
	playerPos(Y),
	retract(playerPos(Y)),
	assert(playerPos(X)).

%Runs the intro with menu.
start :- intro.

%Exits the game.
exit :- halt.

%Prints out the game intro and menu.
intro :- 
	nl,
	write('Welcome to ''The Tale of Emejzon'' text-based adventure game.'), nl,
	write('Reading ''help.'' is advised if you''re playing this game for the first time. :)'), nl, nl,
	write('~ play.   -- Start the game.'), nl,
	write('~ help.   -- Instructions and useful commands.'), nl,
	write('~ exit.   -- Exit the game.'), nl.

%Prints out instructions and game commands.
help :- 
	nl,
	write('The game should provide enough information for you to solve all puzzles (except hidden rooms and secrets)'), nl,
	write('and beat the game. If you''re stuck, try ''look.'' to look around the room (you might be'), nl,
	write('missing something) or try going back to rooms you''ve already visited (you might have unlocked'), nl,
	write('some closed doors or you have an item enabling you to proceed now).'), nl, nl,
	write('COMMANDS:'), nl,
	write('~ help.      -- Show this text again.'), nl,
	write('~ look.     -- Look around the room. (Prints room description)'), nl,
	write('~ n.     -- Go North.'), nl,
	write('~ s.     -- Go South.'), nl,
	write('~ e.     -- Go East.'), nl,
	write('~ w.     -- Go West.'), nl,
	write('~ u.     -- Go Up.'), nl,
	write('~ d.     -- Go Down.'), nl,
	write('~ take(ITEM).     -- Take ITEM from the room (if possible).'), nl,
	write('~ drop(ITEM).     -- Drop ITEM from inventory (if possible).'), nl,
	write('~ examine(ITEM).     -- Examine ITEM in inventory.'), nl,
	write('~ use(ITEM).     -- Use ITEM in inventory (if possible).'), nl,
	write('~ combine(ITEM,ITEM).     -- Combine ITEMS in inventory (if possible).'), nl,
	write('~ inventory.     -- Prints all items in your inventory.'), nl,
	write('~ kill.     -- Kills an enemy in the room if you have the right weapon in your inventory.'), nl.

%Starts the story and asserts all stuff.
play :-
	write('You are slowly waking up. You feel dizzy and you are lying on your back. You have a headache and your eyes can''t focus on anything. As you are trying to stand up, your senses are coming back to normal. There''s something in your pocket - piece of paper or a card? Try to look around.'), nl.

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



% -----------------------------------------------------------------
%  All paths between rooms/places and items needed to enter.
%  Path description: path(X,Y,Z). where:
%       - X -> name of the room the path leads from
%       - Y -> name of the room the path leads to
%       - Z -> direction of path (n,s,e,w,u,d)
%  Item needed to enter: path(X,Y,Z) :- itemPos(ITEM,inventory). 
%       - Item needs to be in players inventory (look at itemPos)
%  Withouth item: path(X,Y,Z) :- write(MSG), false.
%       - Item is not in inventory. Move is forbidden. 
% -----------------------------------------------------------------
path(home, _, e) :- write('You walked to the door. It has no door knob. Interesting...'), nl, !, false.
path(home, _, s) :- write('You looked outside the window and you see... black. Not that it''s dark, it''s just black. No idea what''s going on.'), nl, !, false.
path(home, beginning, n) :- used(remote), 
	write('You approached the television. The sound... some kind of brown noise, but not stable. It doesn''t sound like anything familiar. Do I hear voices there?! You put your ear on the screen, but it''s not solid. The screen is somehow slimy, as if it was made of jelly. Severe pain struck your head. You feel like the screen is pulling you in. Bright light fills the room and you can''t see anything so you closes your eyes in order to protect them. The noise is unbearable now and you hear people scream in agony. You''re about to loose your consciousness.'), nl,nl,
	write('Suddenly it stops. The pain is gone. You can hear... breeze and birds? You smell fresh air and feel warm sun on your face. It''s daytime, apparently. You''re trying to open your eyes but they need to adapt to the light. Where are we?'), nl,
	write('You are standing on a path leading to the near forest.  Behind you is a giant gate. It must be a town or something. A well protected town considering the giant wall around it. Wait a minute... Which towns have walls around them these days? Looks like you''ve just left the town. What is going on? Oh and by the way... You look like a aristocratic pilgrim in that clothes. Do something about it.'), nl, nl,
	retract(itemPos(swatter, _)).
path(home, beginning, n) :- itemPos(remote,inventory), write('You approached the television. It might need some input. It doesn''t look like it''s connected to anything. What does the remote do then?'), nl, !, false.
path(home, beginning, n) :- write('You approached the television. It might need some input. It doesn''t look like it''s connected to anything.'), nl, !, false.

path(beginning, old_tree, n).

path(old_tree, beginning, s).
path(old_tree, village_entrance, n) :- described(claptrap).
path(old_tree, village_entrance, n) :- write('You have left the shadows of the forest and you are approaching a smaller village. It''s not that far from the forest. It''s surounded by palisade, but it has no gate. There are some houses and a church apparently. And... something is heading your way. It is deffinitaly not a person. It''s a shorter... thingy..? It''s some kind of a yellow box on a weheel... with hands? Is that a robot?! Hope you have a weapon or something.'), nl, 
	write('It''s indeed a robot! As it is getting closer, you can recognize an antena and some kind of... mechanical eye in the center of the wierd looking one-wheeled box.'), nl, nl,
	write('"Hello! Allow me to introduce myself - I am a CL4P-TP steward bot, but my friends call me Claptrap! Or they would, if any of them were still alive. Or had existed in the first place! Oh you must be the mighty Emejzon! Or at least you look like the King has described him on his ECHO Recorder. They have this odd ECHO Recorders with text in them, how silly is that? Anyways, he sure awaits you! Now come, follow me to my kingdom. I will be your wise leader, and you shall be my fearsome minion!"'), nl, nl,
	write('...and he''s buzzing back to the village. That was wierd. But I guess there''s nowhere else to go.'), nl, assert(described(claptrap)).
path(old_tree, up_tree, u).
path(old_tree, to_xwing, e) :- isOpen(to_xwing).

path(up_tree, old_tree, d).

path(to_xwing, old_tree, w).
path(to_xwing, rabbit_hole, n).
path(to_xwing, x_wing, e).

path(rabbit_hole, to_xwing, s).

path(x_wing, to_xwing, w).

path(village_entrance, old_tree, s).
path(village_entrance, village_well, n).

path(village_well, woodcutter_house, e).
path(village_well, in_well, d) :- used(rope).
path(village_well, in_well, d) :- eventCount(wellEnter,0), write('Are you sure?'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,1), write('I mean... It looks pretty deep and dark.'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,2), write('I think you don''t want to jump in there.'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,3), write('I KNOW you don''t want to jump in there.'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,4), write('Have you considered that this might not be the right way?'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,5), write('You will die if you jump down the well... trust me.'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,6), write('You can''t say I didn''t try to stop you... Are you 100% sure you want this?'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,7), write('Well then... You jumped down the well and died of horrible death. Happy now?'), nl, kill_player.
path(village_well, parsons_house, w) :- itemPos(golden_key,inventory).
path(village_well, parsons_house, w) :- write('The door is locked.'), nl, !, false.
path(village_well, village_north, n).
path(village_well, village_entrance, s).

path(church, village_north, e).
path(church, adytum, w) :- isAlive(turret), used(matches), itemPos(lamp, inventory), itemPos(the_stick_of_truth, inventory), write('You''ve entered a dark room, the only thing that''s lightning the room is your lamp. There is a miniature tripod robot with a red eye which emits a laser beam poiting straight in front of the robot. "~Activated!~" The laser beam aims at you as the sides of the robot''s body opens horizontally revealing two gatling guns. "~Hello. Prometheus was punished by the gods for giving the gift of knowledge to man. He was cast into the bowels of the earth and packed by birds. Remember that.~" ... "~Good night.~" The beam returns to its previous position and the robot hides its guns.'), nl.
path(church, adytum, w) :- isAlive(turret), used(matches), itemPos(lamp, inventory), write('You''ve entered a dark room, the only thing that''s lightning the room is your lamp. There is a miniature tripod robot with a red eye which emits a laser beam poiting straight in front of the robot. "~Activated!~" The laser beam aims at you as the sides of the robot''s body opens horizontally revealing two gatling guns. "~Target acquired!~" The robot opens fire.'), nl, takeDamage, !, false. 
path(church, adytum, w) :- isAlive(turret), write('You''ve entered a dark room. There is a red laser beam penetrating the darkness. "~Activated!~" The laser beam aims at you with mechanical sound reverberating around the room. "~Are you still there?~" ... "~Hibernating...~" The beam returns to its previous position.'), nl. 
path(church, adytum, w).
path(church, _, n) :- write('You approached the bookshelf. It is full of books. Did they use the church as a library as well? Let''s see what titles do we have here:'), nl, write('- The Art of Computer Programming'), nl, write('- The C Programming Language'), nl, write('- Introduction to Algorithms'), nl, write('- Learn You a Haskell for Great Good!'), nl, write('- Learning Python'), nl, write('- The C++ Programming Language'), nl, write('- Object-Oriented Programming in C++'), nl, write('- Coding Gor Dummies'), nl, write('...no idea what to say.'), nl, !, false.

path(adytum, church, e).

path(in_well, village_well, u).

path(parsons_house, village_well, e).

path(village_north, village_well, s).
path(village_north, old_house1, e).
path(village_north, church, w).
path(village_north, _, n) :- described(blockade), itemPos(matches,claptrap), itemPos(lamp,inventory), write('"Hey, minion! Looks like you''ve found a lamp. Here you could use this matches which I totally didn''t steal from the parson''s house."'), nl, retract(itemPos(matches,claptrap)), assert(itemPos(matches,village_north)), !, false.
path(village_north, _, n) :- described(blockade), write('"Hey minion! If you see any bandits, make sure you kill them."'), nl, !, false.
path(village_north, _, n) :- itemPos(matches,claptrap), itemPos(lamp,inventory), write('"Minion! I''m sorry but you can''t go through here. I had to block the entrance because of the bandit raids from the castle during nights! Those bandits really have it for us Claptraps. Using us as a target practice is not part of our programming! Oh and it looks like you''ve found a lamp. Here you could use this matches which I totally didn''t steal from the parson''s house."'), nl, assert(described(blockade)), retract(itemPos(matches,claptrap)), assert(itemPos(matches,village_north)), !, false.
path(village_north, _, n) :- write('"Minion! I''m sorry but you can''t go through here. I had to block the entrance because of the bandit raids from the castle during nights! Those bandits really have it for us Claptraps. Using us as a target practice is not part of our programming!"'), nl, assert(described(blockade)), !, false.

path(old_house1, old_house2, u).
path(old_house1, village_north, w).

path(old_house2, old_house1, d).

path(woodcutter_house, village_well, w).

path(in_well, well_center, n).
path(well_center, in_well, s).
path(well_center, well_north, n).
path(well_center, well_east, e).
path(well_center, well_west, w) :- isAlive(zombie), itemPos(crowbar,inventory), write('A zombie! Smash it with the crowbar! SMASH SMASH SMEEAAAASH!!! Congrats, you killed the zombie.'), nl, write('Look the zombie dropped some meat!'), nl, retract(isAlive(zombie)), assert(itemPos(rotten_flesh,well_west)).
path(well_center, well_west, w) :- isAlive(zombie), write('A Zombie! You don''t have anything to kill it with. It deals damage to you and you''ve left the room.'), nl, takeDamage, !, false.
path(well_center, well_west, w).
path(well_north, well_center, s).
path(well_east, well_center, w).
path(well_west, well_center, e).
path(beginning, larkinge, s) :- itemPos(lightsaber,inventory), write('You burned the gate with the lightsaber. Now you can Enter! Unfortunately, the story ends here. YOU WON, Traveler!'), nl, !, finis_the_game.
path(beginning, larkinge, s) :- write('The gate needs to be opened from inside. You knocked on it but nothing happens.'), nl, !, false.

% -----------------------------------------------------------------
%  All room descriptions.
%  Room description: 
%	posName(X) :- write(N). 
%	describe(X) :- write(D). 
%	Where:
%       - X -> name of the room
%		- N -> Printable name of the room
%       - D -> text description of the room
% -----------------------------------------------------------------
posName(home) :- write('[Dark Room]'),nl.
posName(beginning) :- described(beginning), write('[Larkinge Gate]'),nl.
posName(beginning) :- write('[Town Gate]'),nl.
posName(old_tree) :- write('[Old Tree]'), nl.
posName(up_tree) :- write('[On the Old Tree]'), nl.
posName(to_xwing) :- write('[Forest]'), nl.
posName(x_wing) :- write('[Crash Site]'), nl.
posName(rabbit_hole) :- write('[Easter Egg]'), nl.
posName(village_entrance) :- described(village_entrance), write('[Sanctuary - South Entrance]'), nl.
posName(village_entrance) :- write('[Village - South Entrance]'), nl.
posName(village_well) :- described(village_entrance), write('[Sanctuary - Public Well]'), nl.
posName(village_well) :- write('[Village - Public Well]'), nl.
posName(village_north) :- described(village_entrance), write('[Sanctuary - North Entrance]'), nl.
posName(village_north) :- write('[Village - North Entrance]'), nl.
posName(parsons_house) :- write('[Parson''s House]'), nl.
posName(old_house1) :- write('[Old House]'), nl.
posName(old_house2) :- write('[Old House - 2nd Floor]'), nl.
posName(church) :- write('[Church]'), nl.
posName(adytum) :- write('[Church - Adytum]'), nl.
posName(woodcutter_house) :- write('[Woodcutter''s House]'), nl.
posName(in_well) :- write('[Inside the Well]'), nl.
posName(well_center) :- write('[Tunnel Crossing]'), nl.
posName(well_north) :- write('[North Tunnel]'), nl.
posName(well_east) :- write('[East Tunnel]'), nl.
posName(well_west) :- write('[West Tunnel]'), nl.


describe(home) :-
	isAlive(fly),
	write('You are in a dark room. There is a television on the north side lightning the room a bit. Only flickering statics. Maybe no input? There''s a door on the east side of the room and a window on the south. Oh and there''s a damn fly flying around your face.'), nl.
describe(home) :-
	write('You are in a dark room. There is a television on the north side lightning the room a bit. Only flickering statics. Maybe no input? There''s a door on the east side of the room and a window on the south.'), nl.

describe(beginning) :-
	assert(described(beginning)),
	write('You are at the town entrance. There is a giant gate South of you with a sign on it... "Larkinge". Should be the name of the town. A path leads North to the near forest.'), nl.

describe(old_tree) :-
	write('You are in the forest clearing. There are trees all around you. A path leads from South to North. There is a big old tree here. It looks climbable.'), nl.

describe(up_tree) :-
	isOpen(to_xwing), itemPos(stick, up_tree),
	write('You are on the old tree and you can see around you. There is Larkinge to the South and a small village to the North. Smoke comes from the forest to the East. There is a wierd looking stick stuck in the branches. You should be able to reach it.'), nl.

describe(up_tree) :-
	isOpen(to_xwing),
	write('You are on the old tree and you can see around you. There is Larkinge to the South and a small village to the North. Smoke comes from the forest to the East.'), nl.

describe(up_tree) :-
	itemPos(stick,up_tree),
	write('You are on the old tree. There is a wierd looking stick stuck in the branches. You should be able to reach it. But what a view! You can see all around you. There is a town to the South... Larkinge! Of course! A smaller village lies North of you. But... what is that? There''s smoke rising from the forest to the East. I can see there something. Is that...? Oh, no way! It can''t be! This can''t be true.'), nl,
	assert(isOpen(to_xwing)).

describe(up_tree) :-
	write('You are on the old tree and you can see all around you. There is a town to the South... Larkinge! Of course! A smaller village lies North of you. But... what is that? There''s smoke rising from the forest to the East. I can see something there. Is that...? Oh, no way! It can''t be! This can''t be true.'), nl,
	assert(isOpen(to_xwing)).

describe(to_xwing) :-
	write('Nothing but forest. Don''t get lost! There should be the Old Tree to the West and the smoking place to the East.'), nl.

describe(rabbit_hole) :-
	itemPos(egg,rabbit_hole),
	write('You are in a little forest clearing. There is a small colorful egg in the middle. It feels more like Summer, why is it here?'), nl.

describe(rabbit_hole) :-
	write('Just a little forest clearing, not much to see. The Easter bunny lives here... Don''t ask how I know that.'), nl.

describe(x_wing) :-
	described(x_wing),
	write('There is a wrecked X-Wing in the middle of forest. It must have been wrecked in a fight. Can anyone explain, please?'), nl.

describe(x_wing) :-
	write('There is a wreck in the forest. The trees are demolished. What do we have here? Incom Corporation, four KX9 laser cannons from Taim & Bak, Two Krupx MG7 proton torpedo launchers, S-foils locked in attack position. I hate to say it, but it''s a destroyed T-65B X-wing starfighter. There might be something useful in the cockpit. It is locked though.'), nl,
	assert(described(x_wing)).

describe(village_entrance) :-
	described(village_entrance),
	write('You are in front of the Village. The entrance is streight to the north and the path to the forest leads south. Village is surrounded by palisade. There was an original sign on the palisade, which is now covered with a wooden plank. There''s a sloppily written word with a white paint: "Sanctuary".'), nl.

describe(village_entrance) :-
	write('You are in front of the village. The entrance is streight to the north and the path to the forest leads south. Village is surrounded by palisade. There was an original sign on the palisade, which is now covered with a wooden plank. There''s a sloppily written word with a white paint: "Sanctuary".'), assert(described(village_entrance)), nl.

describe(village_well) :-
	write('Looks like a significant place at the village. A small square with a public well in the middle. The well has a little wooden roof. Path to the north that leads further to the village. There are also two houses here. One on the East - looks like a woodcutter''s house. Second one is on the West side of the sqare - small house with a cross above the door, must be the parson''s house. Exit is to the South.'), nl.

describe(parsons_house) :-
	itemPos(rope,parsons_house),
	write('A small room with a... dead body hanging on a rope. The person has a black habit, must be the parson. Did he kill himself? How was he locked from the outside? Nevertheless, the rope could come in handy.'), nl.
	% [TODO]: when you drop the rope in parsons house, the parson is hanging again... should be fixed in the future.

describe(parsons_house) :-
	write('A small room with the parson''s dead body on the floor.'), nl.

describe(woodcutter_house) :-
	write('It''s a humble home for a humble man... A lot of wooden furniture. Home-crafted I''d say. A lot of saws and axes around as well as joinery tools.'), nl.

describe(village_north) :-
	write('There is another village''s entrance from the north side. The entrance is blocked with wood and rocks though. Claptrap is standing next to the blockade. There is the Church on the west. It is wooden and it looks very old. It might be the first structure at the village. There is a sign above the door: "Only the one with truth in his heart shall enter". Was it in the Bible somewhere? It does''n seem like a verse. There is a two-floored house to the east of you. A big family or someone rich lived there apparently.'), nl.

describe(old_house1) :-
	write('First floor of the old house. There is a bigger table with wooden chairs in the middle of the room. Some dishes are still on the table. There are also some wooden benches by the wall. They had a clay fireplace here. A staircase leads to the second floor.'), nl.

describe(old_house2) :-
	write('There are four small beds on this floor. A big bear fur lais on the floor between the beds. There are also some old wardrobes and shelves. The staircase leads back down to the first floor.'), nl.

describe(church) :-
	write('Pretty church interior. Only one row of benches with a wooden altair at the front. There are two candle stands, some books and other stuff on the altair. A large wooden cross raises behind the altair on the west wall. The exit is on the east. A small door is behind the altair next to the cross - should be the adytum. There is a larger bookshelf by the north wall as well.'), nl.

describe(adytum) :-
	isAlive(turret), itemPos(lamp,inventory), used(matches),
	write('There is a little platform at the back of the room. Some kind of panel with a white surface is right above the platform. There is the strange robot standing in front of the platform pointing its laser straight agead. The door leading to the church is to the east of you.'), nl.

describe(adytum) :-
	itemPos(lamp,inventory), used(matches),
	write('There is a little platform at the back of the room. Some kind of panel with a white surface is right above the platform. There is the deactivated robot laing in front of the platform. The door leading to the church is to the east of you.'), nl.

describe(adytum) :-
	write('I can''t see anything. It''s too dark. There are door behind me to the east.'), nl.

describe(in_well) :-
	write('The light from outside shines from above you. There is a tunnel in front of you leading north.'), nl.
describe(well_center) :-
	write('A crossing of four tunnels. Each on one cardinal. The village''s well should be to the south of you.'), nl.
describe(well_north) :-
	write('End of the tunnel. You came from the South.'), nl.
describe(well_east) :-
	write('End of the tunnel. You came from the West.'), nl.
describe(well_west) :-
	write('End of the tunnel. You came from the East.'), nl.

describe(_) :- write('There is nothing special about this place. Which is odd... That might be wrong. Consider contacting the creator of this game.'), nl.


%%%% THIS IS THE ENDING OG THE HISTORICALLY FIRST ITERATION OF THE GAME:
%% describe(cave) :-
%% 	write('There''s literally nothing inside this cave...'), nl,
%% 	finis_the_game, !.


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
%  All item descriptions.
%  Item description: describeItem(X) :- write(D). Where:
%       - X -> name of the item
%       - D -> text description of the item
% -----------------------------------------------------------------
describeItem(swatter) :-
	write('There''s something odd about this swatter. It''s light as a feather, though it''s made of steel and cow leather.'), nl.

describeItem(photo) :-
	write('There are two women in the photo. The one on the right is older than the other woman. Maybe daughter with mother? The young one is pretty though. Who are they? Why is this photo in my pocket? There''s something written on the back of the photo... "Help".'), nl.

describeItem(old_letter) :-
	write('Old letter written on some kind of old paper. Definitely not a right place for such an item. It''s pretty devastated. Also... it has blood stains on it?! It reads:'), nl, nl, nl,
	write('"Dear Sir Emejzon'), nl, nl,
	write('It has been a long time since we last met. I am still very grateful for what you have done for me and people of my kingdom. Yet, I have to write you in an unfortunate circumstances. Dark times fell upon this lands. The darkness penetrated the walls of my castle and casted everything in a blanket of missery. We fought and won the battle. Many of my men died that day, as well as my only son, Gerald, who stood braverly by my side. I have never seen anything like this. It is not an army we fought, but a sorcery itself. Kingdom is weakend and the enemy has cursed us. We cannot hold any longer. You are my only hope, Sir Emejzon. Come to my kingdom and save my people.'), nl,nl,
	write('Vladimir, King of Hevia'),nl,
	write('December 11, 1205"'),nl,nl,nl,
	write('... December 1205, King Vladimir, Hevia, battle, darkness, Sir Emejzon... How is this thing here? Did I write this? Who''s Emejzon and Vladimir?'),nl.

describeItem(remote) :- 
	eventCount(remoteExamine,0),
	write('This remote looks... normal? It looks like a remote, why do you examine everything?!'),nl,
	incCounter(remoteExamine).
describeItem(remote) :- 
	eventCount(remoteExamine,1),
	write('It''s a remote. It shouldn''t be that hard to remember this fact.'),nl,
	incCounter(remoteExamine).
describeItem(remote) :- 
	eventCount(remoteExamine,2),
	write('I TOLD YOU IT IS A NORMAL REMOTE!'),nl,
	incCounter(remoteExamine).
describeItem(remote) :- 
	eventCount(remoteExamine,6),
	write('I warn you... Stop that!'),nl,
	incCounter(remoteExamine).
describeItem(remote) :- 
	eventCount(remoteExamine,9),
	write('Last warning... YOU DO IT ONE MORE TIME...!!'),nl,
	incCounter(remoteExamine).
describeItem(remote) :- 
	eventCount(remoteExamine,10),
	write('That''s it... gimme that thing! Good luck playing the game now.'),nl,
	retract(itemPos(remote,inventory)).
describeItem(remote) :- 
	write('I don''t have time for this... it''s a remote.'),nl,
	incCounter(remoteExamine).

describeItem(stick) :-
	write('This stick... It looks like a regular stick, but it has a familiar shape. Moreover there''s something strange going on with this stick. It can''t be just a regular stick. Hmm... there is only one stick that looks like a regular stick, though is not a regular stick. Could it really be...?'), nl,
	retract(itemPos(stick,inventory)), assert(itemPos(the_stick_of_truth,inventory)).

describeItem(the_stick_of_truth) :-
	write('THE STICK OF TRUTH. But what does it do here?'), nl.

describeItem(egg) :-
	write('What a pretty little egg. So colorful and... it has some text on it as well. "This is the only easter egg in this game." *poof*.'), nl,
	retract(itemPos(egg,inventory)).

describeItem(crowbar) :-
	write('Heavy metal crowbar. It has a lambda symbol and number three on it. What could it mean?'), nl.

describeItem(lightsaber) :-
	write('This lightsaber has a green synthetic lightsaber crystal in it. I wonder who owned it. It''s fully functional.'), nl.

describeItem(golden_key) :- 
	write('Nice golden key. And as you know - Every key fits to some lock.'), nl.

describeItem(rope) :-
	write('Regular rope. Can be used to tie some things together or... you know... hang a parson.'), nl.

describeItem(oil) :-
	write('Oil for an oil lamp.'), nl.

describeItem(lamp) :- 
	used(matches), write('Fully functional and burning lamp. May it light your way.'), nl.
describeItem(lamp) :- 
	used(oil), write('Old lamp filled with oil. It needs only a spark to light up. (Just as my life does. #deep)'), nl.
describeItem(lamp) :-
	write('An old oil lamp. Only if we had some fuel for it...'), nl.

describeItem(potion) :-
	write('Some kind of potion in a little glass bottle. It has blue color, is that Mana?'), nl.

describeItem(book) :-
	write('Old book with original hard cover. "Aperture Science Quantum Tunneling Connector" written in 1952 by Cave Johnson.'), nl.

describeItem(page) :-
	write('Looks like a death note from the parson. It reads: '), nl, nl,
	write('"Everyone has been killed. I am the last one alive at the village. Strange things are happening - all these creatures and monsters. Hevia is lost in darkness. It is time to end this. May the Lord forgive me for my sin."'), nl.

describeItem(device) :- describeItem(portal_token).

describeItem(portal_token) :-
	write('A little round-shaped device of metal material. It has a glass chamber in the centre with some kind of blue mist concentrated in one point at the glass chamber. There is a text on the metal perimeter of the device: "ASQTC Prototype"'), nl.

describeItem(rotten_flesh) :-
	write('This sure is not a delicious rib-eye steak. I wouldn''t eat this.'), nl.

describeItem(_) :- write('There is nothing special about this item.'),nl.

% -----------------------------------------------------------------
%  All monsters that are alive.
%  Alive monsters: isAlive(X). Where:
%       - X -> name of the monster
% -----------------------------------------------------------------
isAlive(fly).
isAlive(turret).
isAlive(zombie).

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
	write('You swing the swatter with ease. Fly dissolves midair as the swatter "whooshes" through the air. The swatter sure is magical.'), nl,
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
	write('You threw The Stick of Truth at the robot. It falls on its side revealing its gatling guns. "~OOOooowww~" It opens fire uncontrollably for a few seconds. "~Shutting down...~" Its red eye turns of and the robot deactivates.'), nl,
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


% -----------------------------------------------------------------
%  All usable items and theirs effects.
%  Usable item: usable(X) :- SomeEfect, write(M). Where:
%       - X -> name of the item.
%		- M -> message printed on the screen
% -----------------------------------------------------------------
usable(potion).
usable(remote).
usable(the_stick_of_truth).
usable(crowbar).
usable(rope).
usable(book).
usable(device).
usable(portal_token).
usable(rotten_flesh).
usable(rib_eye_steak).

useItem(potion) :-
	write('You drank the potion. It tastes like fresh strawberries.'), nl,
	heal_player(2),
	retract(itemPos(potion,inventory)).

useItem(remote) :-
	assert(used(remote)),
	write('You have clicked the power button on the remote. The television is still on though. But the way it flickers changed. Now the screen looks... glossy. And it makes a noise. It''s not statics I hear now, do you? I don''t think you''ve helped the situation.'), nl,
	retract(itemPos(remote,inventory)).

useItem(the_stick_of_truth) :-
	write('I don''t know how to use the stick... Ask Eric Cartman! Does it even do anything?'), nl.

useItem(crowbar) :-
	playerPos(x_wing),
	write('You are trying to open the cockpit with the crowbar. But after a while you break the window. You won''t believe what''s inside. I mean... it''s pretty easy to guess, but look for yourself.'), nl,
	assert(itemPos(lightsaber,x_wing)), retract(itemPos(crowbar,inventory)).

useItem(crowbar) :-
	playerPos(beginning),
	write('No, you can''t open the gate with a crowbar.'), nl.

useItem(crowbar) :-
	write('Hmm... interesting thoughts, but I can''t see it working.'), nl.

useItem(rope) :-
	playerPos(village_well),
	write('You tie the rope to the well''s wooden roof construction and threw it down the well. Now the way down looks possible.'), nl,
	assert(used(rope)), retract(itemPos(rope,inventory)).

useItem(book) :-
	described(book),
	write('I''ve already read it for you. The book is about a Portal token. Should be straight forward to use it.'), nl.
useItem(book) :-
	write('Do you want me to read it for you? No, thanks. It''s like 500 pages long, come on! Let''s just skim-read a few pages...'), nl, nl,
	write('"...''Aperture Science Quantum Tunneling Connector (ASQTC)'', developed and tested at Aperture Science computer-aided Enrichment Center..."'), nl,
	write('"...device supports travel within the same dimension, just as our previous successful project ''Aperture Science Portable Quantum Tunneling Device''..."'), nl,
	write('"...ASQTC should be more publicly affordable mean of transport than ASHPD..."'), nl,
	write('"...Caroline suggested that the name ''Aperture Science Quantum Tunneling Connector'' wouldn''t appeal to public. She uses ''Portal Token'' instead. How childish..."'), nl,
	write('"...ASQTC is connected with its only Quantum Tunnel Panel, which has to be installed by ASQTC''s user. Quantum Tunnel Panel has to be installed on a vertical surface or facing down..."'), nl,
	write('"...using ASQTC creates a temporary Quantum Tunnel which leads to Source Quantum Tunnel Panel..."'), nl,
	write('"...later version of ASQTC was developed in a way it remembers where it was picked up and the end portal appears above that place..."'), nl,
	write('"...Test Subject #042 failed to use the ASQTC. ASQTC wasn''t able to activate after tapping it with a beak..."'), nl,
	write('"...Test Subject #188 destroyed the ASCTC after accidentally stepping on the device..."'), nl,
	write('"...Test Subject #221 died getting stuck in the Quantum Tunnel after temporary tunnel deactivation..."'), nl,
	write('"...Test Subject #263 lost his legs due to device''s malfunction and explosion..."'), nl,
	write('"...Test Subject #271 died while testing. We couldn''t find his torso..."'), nl,
	write('"...ASQTC was marked as unstable and dangerous. Project was suspended..."'), nl, nl,
	write('Don''t make me to do that again...'), nl,
	assert(described(book)), itemPos(device,POSITION), retract(itemPos(device,POSITION)), assert(itemPos(portal_token,POSITION)).

useItem(device) :- useItem(portal_token).
useItem(portal_token) :- 
	playerPos(CurrentPosition), 
	write('You threw the small device to the ground under you emerging a blue portal under your feet. As you passed through the portal you fell on the ground seing an orange portal closing above your head.'), nl,
	retract(playerPos(CurrentPosition)),
	teleportPos(WhereTo),
	assert(playerPos(WhereTo)), posName(WhereTo).

useItem(rotten_flesh) :-
	write('You put the piece of meat in your mouth. The taste is sweet at first, but... the after taste... yuck!'), nl,
	takeDamage.

useItem(rib_eye_steak) :-
	write('You ate the rib eye steak. This is something to live for, isn''t it? D-E-L-I-C-I-O-U-S!'), nl,
	heal_player(2),
	retract(itemPos(rib_eye_steak,inventory)).


% -----------------------------------------------------------------
%  Player's current possition. CAN'T HAVE MORE THAN ONE VALUE! BE CAREFUL!
% -----------------------------------------------------------------
playerPos(home).


% -----------------------------------------------------------------
%  Player's current health. CAN'T HAVE MORE THAN ONE VALUE! BE CAREFUL!
% -----------------------------------------------------------------
playerHealth(1).


% -----------------------------------------------------------------
%  All crafting recipes and their effects.
%  Recipe: craftingRecipe(X,Y) :- SomeEfect. Where:
%       - X,Y -> name of the items.
% -----------------------------------------------------------------
craftingRecipe(lamp,oil) :- 
	retract(itemPos(oil,inventory)), assert(used(oil)).

craftingRecipe(lamp,matches) :- 
	used(oil), retract(itemPos(matches,inventory)),
	assert(used(matches)), assert(itemPos(device,adytum)).

craftingRecipe(rotten_flesh,potion) :-
	write('How do you even come up with these combinations?'), nl,
	retract(itemPos(potion,inventory)), retract(itemPos(rotten_flesh,inventory)),
	assert(itemPos(rib_eye_steak,inventory)).


% -----------------------------------------------------------------
%  All event counters for repetitive events.
%  Event counter: eventCount(X,Y). Where:
%       - X -> name of the event.
%		- Y -> counter.
% -----------------------------------------------------------------
eventCount(remoteExamine, 0).
eventCount(wellEnter, 0).


%added for the teleportation destination change...
teleportPos(adytum).