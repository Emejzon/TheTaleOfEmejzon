% -----------------------------------------------------------------
%  All item descriptions.
%  Item description: describeItem(X) :- write(D). Where:
%       - X -> name of the item
%       - D -> text description of the item
% -----------------------------------------------------------------
describeItem(swatter) :-
	write('There''s something odd about this swatter. It''s light as a feather, though it''s made of steel'), nl,
	write('and cow leather.'), nl.

describeItem(photo) :-
	write('There are two women in the photo. The one on the right is older than the other woman. Maybe daughter'), nl,
	write('with mother? The young one is pretty though. Who are they? Why is this photo in my pocket? There''s something'), nl,
	write('written on the back of the photo... "Help".'), nl.

describeItem(old_letter) :-
	write('Old letter written on some kind of old paper. Definitely not a right place for such an item. It''s pretty'), nl,
	write('devastated. Also... it has blood stains on it?! It reads:'), nl, nl, nl,
	write('"Dear Sir Emejzon'), nl, nl,
	write('It has been a long time since we last met. I am still very grateful for what you have done for me and people'), nl,
	write('of my kingdom. Yet, I have to write you in an unfortunate circumstances. Dark times fell upon this lands.'), nl,
	write('The darkness penetrated the walls of my castle and casted everything in a blanket of missery. We fought'), nl,
	write('and won the battle. Many of my men died that day, as well as my only son, Gerald, who stood braverly'), nl,
	write('by my side. I have never seen anything like this. It is not an army we fought, but a sorcery itself.'), nl,
	write('Kingdom is weakend and the enemy has cursed us. We cannot hold any longer. You are my only hope, Sir Emejzon.'), nl,
	write('Come to my kingdom and save my people.'), nl,nl,
	write('Vladimir, King of Hevia'),nl,
	write('December 11, 1205"'),nl,nl,nl,
	write('... December 1205, King Vladimir, Hevia, battle, darkness, Sir Emejzon... How is this thing here?'), nl,
	write('Did I write this? Who''s Emejzon and Vladimir?'),nl.

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
	write('This stick... It looks like a regular stick, but it has a familiar shape. Moreover there''s something strange'), nl,
	write('going on with this stick. It can''t be just a regular stick. Hmm... there is only one stick that looks like'), nl,
	write('a regular stick, though is not a regular stick. Could it really be...?'), nl,
	retract(itemPos(stick,inventory)), assert(itemPos(the_stick_of_truth,inventory)).

describeItem(the_stick_of_truth) :-
	write('THE STICK OF TRUTH. But what does it do here?'), nl.

describeItem(egg) :-
	write('What a pretty little egg. So colorful and... it has some text on it as well. "This is the only easter egg'), nl,
	write('in this game." *poof*.'), nl,
	retract(itemPos(egg,inventory)).

describeItem(crowbar) :-
	write('Heavy metal crowbar. It has a lambda symbol and number three on it. What could it mean?'), nl.

describeItem(lightsaber) :-
	write('This lightsaber has a green synthetic lightsaber crystal in it. I wonder who owned it.'), nl,
	write('It''s fully functional.'), nl.

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
	write('Old book with original hard cover. "Aperture Science Quantum Tunneling Connector" written in 1952'), nl,
	write('by Cave Johnson.'), nl.

describeItem(page) :-
	write('Looks like a death note from the parson. It reads: '), nl, nl,
	write('"Everyone has been killed. I am the last one alive at the village. Strange things are happening - all these'), nl,
	write('creatures and monsters. Hevia is lost in darkness. It is time to end this. May the Lord forgive me'), nl,
	write('for my sin."'), nl.

describeItem(device) :- describeItem(portal_token).

describeItem(portal_token) :-
	write('A little round-shaped device of metal material. It has a glass chamber in the centre with some kind of'), nl,
	write('blue mist concentrated in one point at the glass chamber. There is a text on the metal perimeter'), nl,
	write('of the device: "ASQTC Prototype"'), nl.

describeItem(rotten_flesh) :-
	write('This sure is not a delicious rib-eye steak. I wouldn''t eat this.'), nl.

describeItem(_) :- write('There is nothing special about this item.'),nl.