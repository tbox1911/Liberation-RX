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

	{_x setVariable ['GRLIB_can_speak', false, true]} foreach units _grp;
	gamelogic globalChat "Hello, I Need to speak with you, listen to me.";
	uIsleep 3;
	gamelogic globalChat "We have informations, Opfor will attack this place soon.";
	uIsleep 3;
	gamelogic globalChat "Big Air assault is expected, help us to defend the city...";
	uIsleep 3;
	gamelogic globalChat "...the Resistance must survive!";
	[_sector] remoteExec ["send_para_remote_call", 2];
};

// C_Nikos
speak_mission_delivery_1 = {
	params ["_unit"];
	_next_point = "";
	//hide marker
	gamelogic globalChat "Hello, I Need to speak with you, listen to me.";
	uIsleep 3;
	gamelogic globalChat "You have to deliver this case to my father.";
	uIsleep 3;
	gamelogic globalChat "Go to see my friends to have more inforamtion.";
	uIsleep 3;
	//create marker
};
// Orestes
speak_mission_delivery_2 = {
	params ["_unit"];
	_next_point = "";
	gamelogic globalChat "Go to see my friends to have more inforamtion.";

};
// C_Nikos Old
speak_mission_delivery_3 = {
	params ["_unit"];
	//hide marker
	//delete case
	gamelogic globalChat "Thank you, take your reward.";

};


GRLIB_speaking = true;
switch (side _unit) do {
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