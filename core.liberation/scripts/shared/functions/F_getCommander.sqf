params ["_unit"];
// Fix error and add lazy evaluation for better performance
({_unit in (allPlayers select {( typeOf _x isEqualTo commander_classname )})});