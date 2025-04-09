params ["_unit"];
((!isNil 'GRLIB_active_commander' && {GRLIB_active_commander isEqualTo _unit}) || {_unit in (allPlayers select {( typeOf _x isEqualTo commander_classname )})});