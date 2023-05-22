params ["_unit"];
if (isNil "_unit") exitWith {};
if (!isNil "GRLIB_speaking") exitWith {};

speak_civil_AI = {
	params ["_unit"];
	player globalChat localize "STR_SPEAKMANAGER1";
	uIsleep 2;
	private _opfor_list = (units GRLIB_side_enemy) select {alive _x && _x distance2D getPos _unit < 500};
	if (count _opfor_list > 0) then {
		_opfor = _opfor_list select 0;
		_unit globalChat (format [localize "STR_SPEAKMANAGER2", round(_unit distance2D _opfor), round(_unit getDir _opfor)]);
	} else {
		_msg = selectRandom [localize "STR_SPEAKMANAGER3",localize "STR_SPEAKMANAGER4",localize "STR_SPEAKMANAGER5", "Anerríphthô kúbos ?"];
		_unit globalChat _msg;
	};
};

speak_unit_AI = {
	params ["_unit"];
	private _leader = leader group _unit;
	player globalChat localize "STR_SPEAKMANAGER6";
	uIsleep 2;
	gamelogic globalChat format [localize "STR_SPEAKMANAGER7", round(_unit distance2D _leader), round(_unit getDir _leader)];
};

speak_leader_AI = {
	params ["_unit"];
	private _grp = group _unit;
	private _pos = getPos _unit;
	private _sector = [200, _pos] call F_getNearestSector;

	{_x setVariable ["GRLIB_can_speak", false, true]} foreach units _grp;
	gamelogic globalChat localize "STR_SPEAKMANAGER8";
	uIsleep 3;
	gamelogic globalChat localize "STR_SPEAKMANAGER9";
	uIsleep 3;
	gamelogic globalChat localize "STR_SPEAKMANAGER10";
	uIsleep 3;
	gamelogic globalChat localize "STR_SPEAKMANAGER11";
	[_sector] remoteExec ["send_para_remote_call", 2];
};

// Nikos
speak_mission_delivery_1 = {
	params ["_unit"];
	if (!(_unit getVariable ["GRLIB_A3W_Mission_SD", false])) exitWith {gamelogic globalChat localize "STR_SPEAKMANAGER12"};
	private _next_indx = (GRLIB_A3W_Mission_SD find _unit) + 1;
	private _next_unit = GRLIB_A3W_Mission_SD select _next_indx;

	gamelogic globalChat localize "STR_SPEAKMANAGER13";
	uIsleep 3;
	gamelogic globalChat localize "STR_SPEAKMANAGER14";
	uIsleep 3;
	gamelogic globalChat format [localize "STR_SPEAKMANAGER15", name _next_unit];
	uIsleep 3;
	gamelogic globalChat localize "STR_SPEAKMANAGER16";

	_quest_item = player getVariable ["GRLIB_A3W_Mission_Item", objNull];
	if (isNull _quest_item) then {
		buildtype = 9;
		build_unit = ["Land_Suitcase_F",[],1,[],[],[]];
		dobuild = 1;
		waitUntil { sleep 0.5; dobuild == 0 };
		if (build_confirmed == 3) exitWith {};
		player setVariable ["GRLIB_A3W_Mission_Item", build_vehicle];
		build_vehicle addEventHandler ["Deleted", {
			player setVariable ["GRLIB_A3W_Mission_Item", nil]; 
			GRLIB_A3W_Mission_Marker = GRLIB_A3W_Mission_SD select 0;
		}];
	};
	GRLIB_A3W_Mission_Marker = _next_unit;
	uIsleep 3;
};
// Orestes
speak_mission_delivery_2 = {
	params ["_unit"];
	if (isNil "GRLIB_A3W_Mission_Marker") exitWith {gamelogic globalChat localize "STR_SPEAKMANAGER12"};
	if (!(_unit getVariable ["GRLIB_A3W_Mission_SD", false]) || _unit != GRLIB_A3W_Mission_Marker) exitWith {gamelogic globalChat "Maybe another time..."};
	private _next_indx = (GRLIB_A3W_Mission_SD find _unit) + 1;
	private _next_unit = GRLIB_A3W_Mission_SD select _next_indx;
	private _last_man = GRLIB_A3W_Mission_SD select (count GRLIB_A3W_Mission_SD) - 1;
	if (_next_unit == _last_man) then {
		gamelogic globalChat localize "STR_SPEAKMANAGER17";
		uIsleep 3;
		gamelogic globalChat localize "STR_SPEAKMANAGER18";
		uIsleep 3;
		gamelogic globalChat localize "STR_SPEAKMANAGER19";
		[getPos _next_unit, "militia"] remoteExec ["a3w_create_enemy", 2];
	} else {
		gamelogic globalChat localize "STR_SPEAKMANAGER20";
		uIsleep 3;
		gamelogic globalChat format [localize "STR_SPEAKMANAGER21", name _next_unit];
		uIsleep 3;
		gamelogic globalChat localize "STR_SPEAKMANAGER22";
	};
	GRLIB_A3W_Mission_Marker = _next_unit;
	uIsleep 3;
};
// Nikos Old
speak_mission_delivery_3 = {
	params ["_unit"];
	if (isNil "GRLIB_A3W_Mission_Marker") exitWith {gamelogic globalChat localize "STR_SPEAKMANAGER12"};
	if (!(_unit getVariable ["GRLIB_A3W_Mission_SD", false]) || _unit != GRLIB_A3W_Mission_Marker) exitWith {gamelogic globalChat "Maybe another time..."};
	private _near_case = getPosATL _unit nearEntities [["Land_Suitcase_F"], 10];
	if (count _near_case > 0) then {
		deleteVehicle (_near_case select 0);
		_unit switchMove "AmovPercMstpSnonWnonDnon_Salute";
		_unit playMoveNow "AmovPercMstpSnonWnonDnon_Salute";
		gamelogic globalChat localize "STR_SPEAKMANAGER23";
		{_x setVariable ['GRLIB_can_speak', false, true]} foreach GRLIB_A3W_Mission_SD;
		_unit setVariable ["GRLIB_A3W_Mission_SD_END", true, true];
		GRLIB_A3W_Mission_Marker = nil;
	} else {
		gamelogic globalChat localize "STR_SPEAKMANAGER24";
	};
	uIsleep 3;
};
// Marshal
speak_mission_delivery_4 = {
	params ["_unit"];
	if (!(_unit getVariable ["GRLIB_A3W_Mission_DW", false]) &&
	    !(_unit getVariable ["GRLIB_A3W_Mission_DF", false]) &&
		!(_unit getVariable ["GRLIB_A3W_Mission_DA", false]) &&
		!(_unit getVariable ["GRLIB_A3W_Mission_DN", false]) ) exitWith {gamelogic globalChat localize "STR_SPEAKMANAGER12"};

	private _txt1 = "Water";
	private _txt2 = "barrels";
	if (_unit getVariable ["GRLIB_A3W_Mission_DF", false]) then { _txt1 = "Fuel" };
	if (_unit getVariable ["GRLIB_A3W_Mission_DN", false]) then { _txt1 = "Food"; _txt2 = "pallets" };
	if (_unit getVariable ["GRLIB_A3W_Mission_DA", false]) then { _txt1 = "Ammo"; _txt2 = "small boxes" };

	_unit switchMove "AmovPercMstpSnonWnonDnon_Salute";
	_unit playMoveNow "AmovPercMstpSnonWnonDnon_Salute";
	player globalChat localize "STR_SPEAKMANAGER25";
	uIsleep 2;
	gamelogic globalChat format [localize "STR_SPEAKMANAGER26", _txt1];
	uIsleep 2;
	gamelogic globalChat format [localize "STR_SPEAKMANAGER27", _txt2, _txt1];
	uIsleep 2;
	gamelogic globalChat format [localize "STR_SPEAKMANAGER28", _txt2];
	sleep 3;
	_unit switchMove "LHD_krajPaluby";
	_unit playMoveNow "LHD_krajPaluby";
};

GRLIB_speaking = true;
[_unit, (_unit getDir player)] remoteExec ["setDir", 2];
switch (side _unit) do {
	case (GRLIB_side_civilian) : {
		switch (typeOf _unit) do {
			case "C_Nikos" : {[_unit] call speak_mission_delivery_1};
			case "C_Orestes" : {[_unit] call speak_mission_delivery_2};
			case "C_Nikos_aged" : {[_unit] call speak_mission_delivery_3};
			case "C_Marshal_F" : {[_unit] call speak_mission_delivery_4};
			default {[_unit] call speak_civil_AI};
		};
	};

	case (GRLIB_side_resistance) : {
		if (_unit == leader (group _unit)) then {
			[_unit] call speak_leader_AI;
		} else {
			[_unit] call speak_unit_AI;
		};
	};

	case (GRLIB_side_friendly) : {};

	default {};
};
uIsleep 3;
GRLIB_speaking = nil;