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
usable(lightsaber).

useItem(potion) :-
	write('You drank the potion. It tastes like fresh strawberries.'), nl,
	heal_player(2),
	retract(itemPos(potion,inventory)).

useItem(remote) :-
	assert(used(remote)),
	write('You have clicked the power button on the remote. The television is still on though. But the way it flickers'), nl,
	write('changed. Now the screen looks... glossy. And it makes a noise. It''s not statics I hear now, do you?'), nl,
	write('I don''t think you''ve helped the situation.'), nl,
	retract(itemPos(remote,inventory)).

useItem(the_stick_of_truth) :-
	write('I don''t know how to use the stick... Ask Eric Cartman! Does it even do anything?'), nl.

useItem(crowbar) :-
	playerPos(x_wing),
	write('You are trying to open the cockpit with the crowbar. But after a while you break the window.'), nl,
	write('You won''t believe what''s inside. I mean... it''s pretty easy to guess, but look for yourself.'), nl,
	assert(itemPos(lightsaber,x_wing)).

useItem(crowbar) :-
	playerPos(beginning),
	write('No, you can''t open the gate with a crowbar.'), nl.

useItem(crowbar) :-
	write('Hmm... interesting thoughts, but I can''t see it working.'), nl.

useItem(rope) :-
	playerPos(village_well),
	write('You tie the rope to the well''s wooden roof construction and threw it down the well. Now the way down '), nl,
	write('ooks possible.'), nl,
	assert(isOpen(in_well)), retract(itemPos(rope,inventory)).

useItem(rope) :-
	playerPos(old_tree),
	write('Are you trying to hang yourself? Is this game that hard?!'), nl.

useItem(book) :-
	described(book),
	write('I''ve already read it for you. The book is about a Portal token. Should be straight forward to use it.'), nl.
useItem(book) :-
	write('Do you want me to read it for you? No, thanks. It''s like 500 pages long, come on! Let''s just skim-read'), nl,
	write('a few pages...'), nl, nl,
	write('"...''Aperture Science Quantum Tunneling Connector (ASQTC)'', developed and tested'), nl,
	write('at Aperture Science computer-aided Enrichment Center..."'), nl,
	write('"...device supports travel within the same dimension, just as our previous successful project'), nl,
	write('''Aperture Science Portable Quantum Tunneling Device''..."'), nl,
	write('"...ASQTC should be more publicly affordable mean of transport than ASHPD..."'), nl,
	write('"...Caroline suggested that the name ''Aperture Science Quantum Tunneling Connector'' wouldn''t appeal'), nl,
	write('to public. She uses ''Portal Token'' instead. How childish..."'), nl,
	write('"...ASQTC is connected with its only Quantum Tunnel Panel, which has to be installed by ASQTC''s user.'), nl,
	write('Quantum Tunnel Panel has to be installed on a vertical surface or facing down..."'), nl,
	write('"...using ASQTC creates a temporary Quantum Tunnel which leads to Source Quantum Tunnel Panel..."'), nl,
	write('"...later version of ASQTC was developed in a way it remembers where it was picked up and the end portal'), nl,
	write('appears above that place..."'), nl,
	write('"...Test Subject #042 failed to use the ASQTC. ASQTC wasn''t able to activate after tapping it with a beak..."'), nl,
	write('"...Test Subject #188 destroyed the ASCTC after accidentally stepping on the device..."'), nl,
	write('"...Test Subject #221 died getting stuck in the Quantum Tunnel after temporary tunnel deactivation..."'), nl,
	write('"...Test Subject #263 lost his legs due to device''s malfunction and explosion..."'), nl,
	write('"...Test Subject #271 died while testing. We couldn''t find his torso..."'), nl,
	write('"...ASQTC was marked as unstable and dangerous. Project was suspended..."'), nl, nl,
	write('Don''t make me to do that again...'), nl,
	assert(described(book)), itemPos(device,POSITION), retract(itemPos(device,POSITION)), assert(itemPos(portal_token,POSITION)).

useItem(device) :- 
	write('I don''t think we know how to use this device. Though, every device should be usable, right?'), nl.
useItem(portal_token) :- 
	playerPos(CurrentPosition),
	writePortalUsageMsg,
	retract(playerPos(CurrentPosition)),
	teleportPos(WhereTo),
	assert(playerPos(WhereTo)), posName(WhereTo),
	incCounter(portalUsed).

useItem(rotten_flesh) :-
	write('You put the piece of meat in your mouth. The taste is sweet at first, but... the after taste... yuck!'), nl,
	takeDamage.

useItem(rib_eye_steak) :-
	write('You ate the rib eye steak. This is something to live for, isn''t it? D-E-L-I-C-I-O-U-S!'), nl,
	heal_player(2),
	retract(itemPos(rib_eye_steak,inventory)).

useItem(lightsaber) :-
	playerPos(beginning),
	write('This could work. After all, It''s a wooden gate. You''ve burned it down and now you can ente... Wait a minute.'), nl,
	write('...'), nl,
	write('There''s no town... There''s no path, no townsquare, not even a forest. There''s nothing! Just a black'), nl,
	write('nothingness instead of that wooden gate. And the sound it makes... strangely... soothging?'), nl,
	write('We should go explore! I mean.. It''s propably dangerous... but look at it! Listen to it! It''s calling us!'), nl,
	assert(isOpen(larkinge)).
useItem(lightsaber) :- 
	isOpen(larkinge),
	write('Give me that!! You are dangerous with it... You haven''t even gone through the Jedi training!'), nl,
	retract(itemPos(lightsaber,inventory)).
useItem(lightsaber) :- 
	write('Just... don''t hurt yourself, okay?! That''s not a toy. Is it really necessary?'), nl.