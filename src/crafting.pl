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