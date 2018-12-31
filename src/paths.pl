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
path(home, _, s) :-
	write('You looked outside the window and you see... black. Not that it''s dark, it''s just black.'), nl,
	write('No idea what''s going on.'), nl, !, false.
path(home, beginning, n) :- used(remote), 
	write('You approached the television. The sound... some kind of brown noise, but not stable. It doesn''t sound like'), nl,
	write('anything familiar. Do I hear voices there?! You put your ear on the screen, but it''s not solid. The screen'), nl,
	write('is somehow slimy, as if it was made of jelly. Severe pain struck your head. You feel like the screen is'), nl,
	write('pulling you in. Bright light fills the room and you can''t see anything so you closes your eyes in order'), nl,
	write('to protect them. The noise is unbearable now and you hear people scream in agony. You''re about to loose'), nl,
	write('your consciousness.'), nl,nl,
	write('Suddenly it stops. The pain is gone. You can hear... breeze and birds? You smell fresh air and feel warm sun'), nl,
	write('on your face. It''s daytime, apparently. You''re trying to open your eyes but they need to adapt to the light.'), nl,
	write('Where are we?'), nl,
	write('You are standing on a path leading to the near forest.  Behind you is a giant gate. It must be a town or'), nl,
	write('something. A well protected town considering the giant wall around it. Wait a minute... Which towns have'), nl,
	write('walls around them these days? Looks like you''ve just left the town. What is going on? Oh and by the way...'), nl,
	write('You look like a aristocratic pilgrim in that clothes. Do something about it.'), nl, nl,
	retract(itemPos(swatter, _)).
path(home, beginning, n) :- itemPos(remote,inventory),
	write('You approached the television. It might need some input. It doesn''t look like it''s connected to anything.'), nl,
	write('What does the remote do then?'), nl, !, false.
path(home, beginning, n) :- 
	write('You approached the television. It might need some input. It doesn''t look like'), nl,
	write('it''s connected to anything.'), nl, !, false.

path(beginning, old_tree, n).

path(old_tree, beginning, s).
path(old_tree, village_entrance, n) :- described(claptrap).
path(old_tree, village_entrance, n) :- 
	write('You have left the shadows of the forest and you are approaching a smaller village. It''s not that far'), nl,
	write('from the forest. It''s surounded by palisade, but it has no gate. There are some houses and a church'), nl,
	write('apparently. And... something is heading your way. It is deffinitaly not a person. It''s a shorter...'), nl,
	write('thingy..? It''s some kind of a yellow box on a weheel... with hands? Is that a robot?! Hope you have'), nl,
	write('a weapon or something.'), nl, 
	write('It''s indeed a robot! As it is getting closer, you can recognize an antena and some kind of... mechanical'), nl,
	write('eye in the center of the wierd looking one-wheeled box.'), nl, nl,
	write('"Hello! Allow me to introduce myself - I am a CL4P-TP steward bot, but my friends call me Claptrap! Or they'), nl,
	write('would, if any of them were still alive. Or had existed in the first place! Oh you must be the mighty Emejzon!'), nl,
	write('Or at least you look like the King has described him on his ECHO Recorder. They have this odd ECHO Recorders'), nl,
	write('with text in them, how silly is that? Anyways, he sure awaits you! Now come, follow me to my kingdom.'), nl,
	write('I will be your wise leader, and you shall be my fearsome minion!"'), nl, nl,
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
path(village_well, in_well, d) :- isOpen(in_well).
path(village_well, in_well, d) :- eventCount(wellEnter,0),
	write('Are you sure?'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,1),
	write('I mean... It looks pretty deep and dark.'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,2),
	write('I think you don''t want to jump in there.'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,3),
	write('I KNOW you don''t want to jump in there.'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,4),
	write('Have you considered that this might not be the right way?'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,5),
	write('You will die if you jump down the well... trust me.'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,6),
	write('You can''t say I didn''t try to stop you... Are you 100% sure you want this?'), nl, incCounter(wellEnter), !, false.
path(village_well, in_well, d) :- eventCount(wellEnter,7),
	write('Well then... You jumped down the well and died of horrible death. Happy now?'), nl, kill_player.
path(village_well, parsons_house, w) :- itemPos(golden_key,inventory).
path(village_well, parsons_house, w) :- write('The door is locked.'), nl, !, false.
path(village_well, village_north, n).
path(village_well, village_entrance, s).

path(church, village_north, e).
path(church, adytum, w) :- isAlive(turret), used(matches), itemPos(lamp, inventory), itemPos(the_stick_of_truth, inventory),
	write('You''ve entered a dark room, the only thing that''s lightning the room is your lamp. There is a miniature'), nl,
	write('tripod robot with a red eye which emits a laser beam poiting straight in front of the robot. "~Activated!~"'), nl,
	write('The laser beam aims at you as the sides of the robot''s body opens horizontally revealing two gatling guns.'), nl,
	write('"~Hello. Prometheus was punished by the gods for giving the gift of knowledge to man. He was cast into the'), nl,
	write('bowels of the earth and packed by birds. Remember that.~" ... "~Good night.~" The beam returns to its'), nl,
	write('previous position and the robot hides its guns.'), nl.
path(church, adytum, w) :- isAlive(turret), used(matches), itemPos(lamp, inventory), 
	write('You''ve entered a dark room, the only thing that''s lightning the room is your lamp. There is a miniature'), nl,
	write('tripod robot with a red eye which emits a laser beam poiting straight in front of the robot. "~Activated!~"'), nl,
	write('The laser beam aims at you as the sides of the robot''s body opens horizontally revealing two gatling guns.'), nl,
	write('"~Target acquired!~" The robot opens fire.'), nl, takeDamage, !, false. 
path(church, adytum, w) :- isAlive(turret),
	write('You''ve entered a dark room. There is a red laser beam penetrating the darkness. "~Activated!~"'), nl,
	write('The laser beam aims at you with mechanical sound reverberating around the room.'), nl,
	write('"~Are you still there?~" ... "~Hibernating...~" The beam returns to its previous position.'), nl. 
path(church, adytum, w).
path(church, _, n) :- 
	write('You approached the bookshelf. It is full of books. Did they use the church as a library as well?'), nl,
	write('Let''s see what titles do we have here:'), nl,
	write('- The Art of Computer Programming'), nl,
	write('- The C Programming Language'), nl,
	write('- Introduction to Algorithms'), nl,
	write('- Learn You a Haskell for Great Good!'), nl,
	write('- Learning Python'), nl,
	write('- The C++ Programming Language'), nl,
	write('- Object-Oriented Programming in C++'), nl,
	write('- Coding Gor Dummies'), nl,
	write('...no idea what to say.'), nl, !, false.

path(adytum, church, e).

path(in_well, village_well, u).

path(parsons_house, village_well, e).

path(village_north, village_well, s).
path(village_north, old_house1, e).
path(village_north, church, w).
path(village_north, _, n) :- described(blockade), itemPos(matches,claptrap), itemPos(lamp,inventory),
	write('"Hey, minion! Looks like you''ve found a lamp. Here you could use this matches which I totally didn''t steal'), nl,
	write('from the parson''s house."'), nl, retract(itemPos(matches,claptrap)), assert(itemPos(matches,village_north)), !, false.
path(village_north, _, n) :- described(blockade),
	write('"Hey minion! If you see any bandits, make sure you kill them."'), nl, !, false.
path(village_north, _, n) :- itemPos(matches,claptrap), itemPos(lamp,inventory),
	write('"Minion! I''m sorry but you can''t go through here. I had to block the entrance because of the bandit raids'), nl,
	write('from the castle during nights! Those bandits really have it for us Claptraps. Using us as a target'), nl,
	write('practice is not part of our programming! Oh and it looks like you''ve found a lamp. Here you could use these'), nl,
	write('matches which I totally didn''t steal from the parson''s house."'), nl,
	assert(described(blockade)), retract(itemPos(matches,claptrap)), assert(itemPos(matches,village_north)), !, false.
path(village_north, _, n) :- 
	write('"Minion! I''m sorry but you can''t go through here. I had to block the entrance because of the bandit raids'), nl,
	write('from the castle during nights! Those bandits really have it for us Claptraps. Using us as a target practice'), nl,
	write('is not part of our programming!"'), nl, assert(described(blockade)), !, false.

path(old_house1, old_house2, u).
path(old_house1, village_north, w).

path(old_house2, old_house1, d).

path(woodcutter_house, village_well, w).

path(in_well, well_center, n).

path(well_center, in_well, s).
path(well_center, well_north, n).
path(well_center, well_east, e).
path(well_center, well_west, w) :- isAlive(zombie), itemPos(crowbar,inventory),
	write('A zombie! Smash it with the crowbar! SMASH SMASH SMEEAAAASH!!! Congrats, you killed the zombie.'), nl,
	write('Look the zombie dropped some meat!'), nl, retract(isAlive(zombie)), assert(itemPos(rotten_flesh,well_west)).
path(well_center, well_west, w) :- isAlive(zombie), 
	write('A Zombie! You don''t have anything to kill it with. It deals damage to you and you''ve left the room.'), nl, takeDamage, !, false.
path(well_center, well_west, w).

path(well_north, well_center, s).

path(well_east, well_center, w).

path(well_west, well_center, e).

path(beginning, larkinge, s) :- isOpen(larkinge), described(larkinge).
path(beginning, larkinge, s) :- isOpen(larkinge),
	write('On second thought, let''s be reasonable for a moment. What if it''s a trap? An instant death? Do you really'), nl,
	write('want to go near that... that dark-dimension-portal thing? Sounds like a bad idea to me.'), nl,
	write('But I guess I shouldn''t be discouraging you, ...adventurer! ON WE GO!!! Just... be precautious, please.'), nl,nl,
	write('You slowly approached the nothingness in front of you. The closer you are, the more it''s pulling you in.'), nl,
	write('The force you are experiencing is like gravity. You feel like falling into this hole of darkness and suddenly'), nl,
	write('you can''t see the wall. You can''t see the path leading towards the forest. You can''t see anything.'), nl,
	write('You can''t feel anything. No force is affecting your body. Do you still have a body?'), nl, nl,
	write('You''ve opend your eyes and a bright light struck your sight. Your vision is slowly adapting'), nl,
	write('to the brightness. Where are we? What is this place? It looks like... I mean...'), nl,
	write('It''s not a big truck. It''s a series of tubes.'), nl,
	write('There are some things buzzing through the tubes and other things flying around them. Everything seems'), nl,
	write('to be black and dark except the tubes and all the items moving quickly, which are colorfull and bright.'), nl,
	write('You are standing there in this chaos. And... you have your body! You can''t feel it, but it''s there.'), nl,
	write('You are standing on some kind of dark tiles. More precisly a perfect grid of fine white lines on a black'), nl,
	write('nothingness. Can you move?'), nl, nl,
	assert(described(larkinge)). 
path(beginning, larkinge, s) :- write('The gate needs to be opened from inside. You knocked on it but nothing happens.'), nl, !, false.

path(larkinge, beginning, n).
% [TODO]: TO BE CONTINUED