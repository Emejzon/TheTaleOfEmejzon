% -----------------------------------------------------------------
%  All room descriptions.
%  Room description: describe(X) :- write(D). Where:
%       - X -> name of the room
%       - D -> text description of the room
% -----------------------------------------------------------------
describe(home) :-
	isAlive(fly),
	write('You are in a dark room. There is a television on the north side lightning the room a bit. Only flickering'), nl,
	write('statics. Maybe no input? There''s a door on the east side of the room and a window on the south.'), nl,
	write('Oh and there''s a damn fly flying around your face.'), nl.
describe(home) :-
	write('You are in a dark room. There is a television on the north side lightning the room a bit. Only flickering'), nl,
	write('statics. Maybe no input? There''s a door on the east side of the room and a window on the south.'), nl.

describe(beginning) :-
	isOpen(larkinge),
	write('You are at the Larkinge portal. The portal is to the South from you. A path leads North to the near forest.'), nl.

describe(beginning) :-
	assert(described(beginning)),
	write('You are at the town entrance. There is a giant wooden gate South of you with a sign on it... "Larkinge".'), nl,
	write('Should be the name of the town. A path leads North to the near forest.'), nl.

describe(old_tree) :-
	write('You are in the forest clearing. There are trees all around you. A path leads from South to North.'), nl,
	write('There is a big old tree here. It looks climbable.'), nl.

describe(up_tree) :-
	isOpen(to_xwing), itemPos(stick, up_tree),
	write('You are on the old tree and you can see around you. There is Larkinge to the South and a small village'), nl,
	write('to the North. Smoke comes from the forest to the East. There is a wierd looking stick stuck in the branches.'), nl,
	write('You should be able to reach it.'), nl.

describe(up_tree) :-
	isOpen(to_xwing),
	write('You are on the old tree and you can see around you. There is Larkinge to the South and a small village'), nl,
	write('to the North. Smoke comes from the forest to the East.'), nl.

describe(up_tree) :-
	itemPos(stick,up_tree),
	write('You are on the old tree. There is a wierd looking stick stuck in the branches. You should be able to reach it.'), nl,
	write('But what a view! You can see all around you. There is a town to the South... Larkinge! Of course! A smaller'), nl,
	write('village lies North of you. But... what is that? There''s smoke rising from the forest to the East. I can see'), nl,
	write('there something. Is that...? Oh, no way! It can''t be! This can''t be true.'), nl,
	assert(isOpen(to_xwing)).

describe(up_tree) :-
	write('You are on the old tree and you can see all around you. There is a town to the South... Larkinge! Of course!'), nl,
	write('A smaller village lies North of you. But... what is that? There''s smoke rising from the forest to the East.'), nl,
	write('I can see something there. Is that...? Oh, no way! It can''t be! This can''t be true.'), nl,
	assert(isOpen(to_xwing)).

describe(to_xwing) :-
	write('Nothing but forest. Don''t get lost! There should be the Old Tree to the West and the smoking place'), nl,
	write('to the East.'), nl.

describe(rabbit_hole) :-
	itemPos(egg,rabbit_hole),
	write('You are in a little forest clearing. There is a small colorful egg in the middle. It feels more like Summer,'), nl,
	write('why is it here?'), nl.

describe(rabbit_hole) :-
	write('Just a little forest clearing, not much to see. The Easter bunny lives here... Don''t ask how I know that.'), nl.

describe(x_wing) :-
	described(x_wing),
	write('There is a wrecked X-Wing in the middle of forest. It must have been wrecked in a fight.'), nl,
	write('Can anyone explain, please?'), nl.

describe(x_wing) :-
	write('There is a wreck in the forest. The trees are demolished. What do we have here? Incom Corporation,'), nl,
	write('four KX9 laser cannons from Taim & Bak, Two Krupx MG7 proton torpedo launchers, S-foils locked in attack'), nl,
	write('position. I hate to say it, but it''s a destroyed T-65B X-wing starfighter. There might be something useful'), nl,
	write('in the cockpit. It is locked though.'), nl,
	assert(described(x_wing)).

describe(village_entrance) :-
	described(village_entrance),
	write('You are in front of the Village. The entrance is streight to the north and the path to the forest leads'), nl,
	write('south. Village is surrounded by palisade. There was an original sign on the palisade, which is now covered'), nl,
	write('with a wooden plank. There''s a sloppily written word with a white paint: "Sanctuary".'), nl.

describe(village_entrance) :-
	write('You are in front of the village. The entrance is streight to the north and the path to the forest leads'), nl,
	write('south. Village is surrounded by palisade. There was an original sign on the palisade, which is now covered'), nl,
	write('with a wooden plank. There''s a sloppily written word with a white paint: "Sanctuary".'), assert(described(village_entrance)), nl.

describe(village_well) :-
	write('Looks like a significant place at the village. A small square with a public well in the middle.'), nl,
	write('The well has a little wooden roof. Path to the north that leads further to the village. There are also'), nl,
	write('two houses here. One on the East - looks like a woodcutter''s house. Second one is on the West side of the'), nl,
	write('sqare - small house with a cross above the door, must be the parson''s house. Exit is to the South.'), nl.

describe(parsons_house) :-
	itemPos(rope,parsons_house),
	write('A small room with a... dead body hanging on a rope. The person has a black habit, must be the parson.'), nl,
	write('Did he kill himself? How was he locked from the outside? Nevertheless, the rope could come in handy.'), nl.
	% [TODO]: when you drop the rope in parsons house, the parson is hanging again... should be fixed in the future.

describe(parsons_house) :-
	write('A small room with the parson''s dead body on the floor.'), nl.

describe(woodcutter_house) :-
	write('It''s a humble home for a humble man... A lot of wooden furniture. Home-crafted I''d say. A lot of saws'), nl,
	write('and axes around as well as joinery tools.'), nl.

describe(village_north) :-
	write('There is another village''s entrance from the north side. The entrance is blocked with wood and rocks'), nl,
	write('though. Claptrap is standing next to the blockade. There is the Church on the west. It is wooden and it looks'), nl,
	write('very old. It might be the first structure at the village. There is a sign above the door:'), nl,
	write('"Only the one with truth in his heart shall enter". Was it in the Bible somewhere? It does''n seem like'), nl,
	write('a verse. There is a two-floored house to the east of you. A big family or someone rich lived there,'), nl,
	write('apparently.'), nl.

describe(old_house1) :-
	write('First floor of the old house. There is a bigger table with wooden chairs in the middle of the room. Some'), nl,
	write('dishes are still on the table. There are also some wooden benches by the wall. They had a clay fireplace'), nl,
	write('here. A staircase leads to the second floor.'), nl.

describe(old_house2) :-
	write('There are four small beds on this floor. A big bear fur lais on the floor between the beds.'), nl,
	write('There are also some old wardrobes and shelves. The staircase leads back down to the first floor.'), nl.

describe(church) :-
	write('Pretty church interior. Only one row of benches with a wooden altair at the front. There are two candle'), nl,
	write('stands, some books and other stuff on the altair. A large wooden cross raises behind the altair on the west'), nl,
	write('wall. The exit is on the east. A small door is behind the altair next to the cross - should be the adytum.'), nl,
	write('There is a larger bookshelf by the north wall as well.'), nl.

describe(adytum) :-
	isAlive(turret), itemPos(lamp,inventory), used(matches),
	write('There is a little platform at the back of the room. Some kind of panel with a white surface is right above'), nl,
	write('the platform. There is the strange robot standing in front of the platform pointing its laser straight agead.'), nl,
	write('The door leading to the church is to the east of you.'), nl.

describe(adytum) :-
	itemPos(lamp,inventory), used(matches),
	write('There is a little platform at the back of the room. Some kind of panel with a white surface is right above'), nl,
	write('the platform. There is the deactivated robot laing in front of the platform. The door leading to the church'), nl,
	write('is to the east of you.'), nl.

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

describe(larkinge) :-
	write('A dark place full of colorful tubes and a lot of things flying around them. A very strange place.'), nl,
	write('I think there''s not much to do here.'), nl,
	write('Maybe we should wait for the developer to finish this part of the story.'), nl.

describe(_) :- 
	write('There is nothing special about this place. Which is odd... That might be wrong.'), nl,
	write('Consider contacting the creator of this game.'), nl.