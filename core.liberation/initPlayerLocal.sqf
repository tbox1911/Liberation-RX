disableUserInput true;
titleText ["Loading...","BLACK FADED", 1000];

// if (GRLIB_side_friendly == EAST && side player != GRLIB_side_friendly) then {
// 	// an ugly workaround to change player spawn class from B_xxx to O_xxx
// 	// thank to pierremgi / killzone_kid

// 	_old_player = player;
// 	_r1 = (typeOf player) splitString "";
// 	_r1 set [0, "O"];
// 	_class = _r1 joinString "";
// 	_group = createGroup [GRLIB_side_friendly, true];
// 	sleep 1;
// 	//diag_log format ["DBG: %1 %2 %3", _group, _class, _spawn_pos ];
// 	_player = _group createUnit [_class, _spawn_pos, [], 0, "none"];
// 	sleep 1;

// 	//[_player] joinSilent _group;
// 	selectPlayer _player;
// 	deleteVehicle _old_player;

// 	[] call DALE_fnc_initBriefing;
//  [] call compile preprocessFileLineNumbers "GREUH\scripts\GREUH_version.sqf";
// };