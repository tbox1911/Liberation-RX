params ["_unit"];
if (isNil "_unit") exitWith {};
if (!isNil "GRLIB_speaking") exitWith {};

speak_civil_AI = {
	params ["_unit"];
	player globalChat "Hello, you see somes enemies around here ?";
	uIsleep 2;
	private _opfor_list = allUnits select {alive _x && _x distance2D getPos _unit < 500 && side _x == GRLIB_side_enemy};
	if (count _opfor_list > 0) then {
		_opfor = _opfor_list select 0;
		_unit globalChat (format ["Hi, Yes, I see someone at %1 meters, Azimut %2, Hurry up!", round(_unit distance2D _opfor), round(_unit getDir _opfor)]);
	} else {
		_msg = ["Hi, Sorry No.","I dont care, Go away !","Hello, I have no fucking idea of who are your enemies...", "Anerríphthô kúbos ?"] call BIS_fnc_selectRandom;
		_unit globalChat _msg;
	};
};

speak_unit_AI = {
	params ["_unit"];
	private _leader = leader group _unit;
	player globalChat "Hello, Where is your leader ?";
	uIsleep 2;
	gamelogic globalChat (format ["Hi, he's at %1 meters, Azimut %2, Hurry up!", round(_unit distance2D _leader), round(_unit getDir _leader)]);
};

speak_leader_AI = {
	params ["_unit"];
	private ["_grp", "_pos", "_sector"];
	_grp = group _unit;
	_pos = getPos _unit;
	_sector = (sectors_allSectors select {_x select [0,8] == "capture_" && (getMarkerPos _x) distance2D _pos < (GRLIB_sector_size/2)}) select 0;
	if (isNil "_sector") exitWith {};

	{_x setVariable ["GRLIB_can_speak", false, true]} foreach units _grp;
	gamelogic globalChat "Hello, I Need to speak with you, listen to me.";
	uIsleep 3;
	gamelogic globalChat "We have informations, Opfor will attack this place soon.";
	uIsleep 3;
	gamelogic globalChat "Big Air assault is expected, help us to defend the city...";
	uIsleep 3;
	gamelogic globalChat "...the Resistance must survive!";
	[_sector] remoteExec ["send_para_remote_call", 2];
};

// Nikos
speak_mission_delivery_1 = {
	params ["_unit"];
	if (!(_unit getVariable ["GRLIB_A3W_Mission_SD", false])) exitWith {gamelogic globalChat "Maybe another time..."};
	_next_indx = (GRLIB_A3W_Mission_SD find _unit) + 1;
	_next_unit = GRLIB_A3W_Mission_SD select _next_indx;

	gamelogic globalChat "Hello, I Need to speak with you, listen to me.";
	uIsleep 3;
	gamelogic globalChat "You have to deliver this precious information to my father.";
	uIsleep 3;
	gamelogic globalChat format ["Go to see my friend %1 for more infos.", name _next_unit];
	uIsleep 3;
	gamelogic globalChat "Look at the marker on your Map.";

	if ( isNull (player getVariable ["GRLIB_A3W_Mission_Marker", objNull])) then {
		_pos = player modelToWorld [0,1,1];
		_can = createVehicle ["Land_Suitcase_F", _pos, [], 0, "CAN_COLLIDE"];
		[_can] spawn R3F_LOG_FNCT_objet_deplacer;
	};
	player setVariable ["GRLIB_A3W_Mission_Marker", _next_unit];
	uIsleep 3;
};
// Orestes
speak_mission_delivery_2 = {
	params ["_unit"];
	_target = player getVariable ["GRLIB_A3W_Mission_Marker", objNull];
	if (!(_unit getVariable ["GRLIB_A3W_Mission_SD", false]) || _unit != _target) exitWith {gamelogic globalChat "Maybe another time..."};
	_next_indx = (GRLIB_A3W_Mission_SD find _unit) + 1;
	_next_unit = GRLIB_A3W_Mission_SD select _next_indx;
	_last_man = GRLIB_A3W_Mission_SD select (count GRLIB_A3W_Mission_SD) - 1;

	if (_next_unit == _last_man) then {
		gamelogic globalChat "Yes, I know him !";
		uIsleep 3;
		gamelogic globalChat "he's hidding in a small house, enemy forces try to catch him!";
		uIsleep 3;
		gamelogic globalChat "Look at the marker on your Map, Hurry hup!";
	} else {
		gamelogic globalChat "Oh, I dont knows,";
		uIsleep 3;
		gamelogic globalChat format ["Go to see my friend %1 for more infos.", name _next_unit];
		uIsleep 3;
		gamelogic globalChat "Look at the marker on your Map.";
	};
	player setVariable ["GRLIB_A3W_Mission_Marker", _next_unit];
	uIsleep 3;
};
// Nikos Old
speak_mission_delivery_3 = {
	params ["_unit"];
	_target = player getVariable ["GRLIB_A3W_Mission_Marker", objNull];
	if (!(_unit getVariable ["GRLIB_A3W_Mission_SD", false]) || _unit != _target) exitWith {gamelogic globalChat "Maybe another time..."};

	_near_case = nearestObjects [_unit, ["Land_Suitcase_F"], 10];
	if (count _near_case > 0) then {
		deleteVehicle (_near_case select 0);
		{_x setVariable ['GRLIB_can_speak', false, true]} foreach GRLIB_A3W_Mission_SD;
		_unit setVariable ["GRLIB_A3W_Mission_SD_END", true, true];
		player setVariable ["GRLIB_A3W_Mission_Marker", nil];
		gamelogic globalChat "Thank you very much, Please take your reward.";
	} else {
		gamelogic globalChat "Sorry, I wait for something special...";
	};
	uIsleep 3;
};

GRLIB_speaking = true;
switch (side _unit) do {
	_unit setDir (_unit getDir player);
	case (GRLIB_side_civilian) : {
		switch (typeOf _unit) do {
			case "C_Nikos" : {[_unit] call speak_mission_delivery_1};
			case "C_Orestes" : {[_unit] call speak_mission_delivery_2};
			case "C_Nikos_aged" : {[_unit] call speak_mission_delivery_3};
			default [_unit] call speak_civil_AI;
		};
	};

	case (GRLIB_side_friendly) : {
		if (_unit == leader (group _unit)) then {
			[_unit] call speak_leader_AI;
		} else {
			[_unit] call speak_unit_AI;
		};
	};

	case (GRLIB_side_resistance) : {};

	default {};
};
sleep 1;
GRLIB_speaking = nil;