% -----------------------------------------------------------------
%  All room printable names.
%  Room name: posName(X) :- write(N). 
%  Where:
%       - X -> name of the room
%		- N -> Printable name of the room
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
posName(larkinge) :- write('[Larkinge]'), nl.