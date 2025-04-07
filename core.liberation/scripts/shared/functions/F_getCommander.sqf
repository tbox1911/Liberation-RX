params ["_unit"];
// Fix error and add lazy evaluation for better performance
(GRLIB_active_commander isEqualTo _unit || {_unit in (allPlayers select {( typeOf _x isEqualTo commander_classname )})});