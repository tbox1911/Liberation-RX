speak_another_time = {
	params ["_unit"];
	_unit globalChat localize "STR_SPEAKMANAGER12";
};

speak_civil_AI = {
	params ["_unit"];

	if (_unit getVariable ["GRLIB_A3W_Mission_MR1", false]) exitWith {[_unit] call speak_mission_resitance};
	if (_unit getVariable ["GRLIB_A3W_Mission_SD1", false]) exitWith {[_unit] call speak_mission_sdelivery1};
	if (_unit getVariable ["GRLIB_A3W_Mission_SD2", false]) exitWith {[_unit] call speak_mission_sdelivery2};
	if (_unit getVariable ["GRLIB_A3W_Mission_SD3", false]) exitWith {[_unit] call speak_mission_sdelivery3};
	if (_unit getVariable ["GRLIB_A3W_Mission_SD4", false]) exitWith {[_unit] call speak_mission_sdelivery4};
	if (_unit getVariable ["GRLIB_A3W_Mission_DL1", false]) exitWith {[_unit] call speak_mission_delivery_fuel};
	if (_unit getVariable ["GRLIB_A3W_Mission_DL2", false]) exitWith {[_unit] call speak_mission_delivery_water};
	if (_unit getVariable ["GRLIB_A3W_Mission_DL3", false]) exitWith {[_unit] call speak_mission_delivery_food};
	if (_unit getVariable ["GRLIB_A3W_Mission_DL4", false]) exitWith {[_unit] call speak_mission_delivery_ammo};
	if (_unit getVariable ["GRLIB_A3W_Mission_HC1", false]) exitWith {[_unit] call speak_mission_heal_doctor};
	if (_unit getVariable ["GRLIB_A3W_Mission_HC2", false]) exitWith {[_unit] call speak_mission_heal_wounded};
	if (damage _unit > 0.2) exitWith {[_unit] call speak_heal_civ};

	player globalChat localize "STR_SPEAKMANAGER1";
	sleep 2;
	private _reputation = [player] call F_getReput;
	if (_reputation >= 25) exitWith {
		[_unit] call speak_info_unit
	};
	if (_reputation <= -25) exitWith {
		[_unit] call speak_insult_unit;
	};
	_msg = selectRandom [localize "STR_SPEAKMANAGER3",localize "STR_SPEAKMANAGER4",localize "STR_SPEAKMANAGER5", "Anerríphthô kúbos ?"];
	_unit globalChat _msg;
};

speak_info_unit = {
	params ["_unit"];
	private _greetings = [
		"Hey, I love you !",
		"You are doing a great job here !",
		"We're all glad to see you here !",
		"Good morning, God bless your army !",
		"I would like my daughter to marry you.",
		"Hey, kill them all for us !"
	];
	private _opfor_list = (units GRLIB_side_enemy) select {alive _x && _x distance2D getPos _unit < 500};
	if (count _opfor_list > 0) then {
		_opfor = _opfor_list select 0;
		_unit globalChat (format [localize "STR_SPEAKMANAGER2", round(_unit distance2D _opfor), round(_unit getDir _opfor)]);
	} else {
		_unit globalChat "I'm sorry, I have no informations.";
	};
	sleep 2;
	_unit globalChat (selectRandom _greetings);
};

speak_insult_unit = {
	params ["_unit"];
	private _insults = [
		"Hey, Fuck Off !",
		"You gonna die !",
		"We hate you !",
		"Go back home, Fuckers !",
		"You better leave this land...",
		"You're not Welcome here, Go away !"
	];
	_unit globalChat (selectRandom _insults);
};

speak_repair_vehicle = {
	_unit globalChat "Hi, Your vehicle is in a bad mood, hahaha !!";
	sleep 2;
	_unit globalChat "I can fix it for you, wait a minute...";
};

speak_join_player = {
	_unit globalChat format ["Hi, my name is %1, the enemies approaching.", name _unit];
	sleep 2;
	_unit globalChat "I'm happy to join your group to fight these asshole !";
};

speak_repair = {
	_unit globalChat "Hello, my car needs Repairs, please help me !";
};

speak_player_repair = {
	_unit globalChat "hooo, Thank you for repairing my old car !";
	if (([player] call F_getReput) >= 25) then {
		sleep 2;
		[_unit] call speak_info_unit;
	};
};

speak_refuel = {
	_unit globalChat "Hello, my car needs Fuel, please help me !";
};

speak_player_refuel = {
	_unit globalChat "hooo, Thank you for giving me fuel !";
	if (([player] call F_getReput) >= 25) then {
		sleep 2;
		[_unit] call speak_info_unit;
	};
};

speak_reammo_player = {
	_unit globalChat "Hey! do you need ammo for your Weapons ?";
	sleep 2;
	_unit globalChat "Look in this crate, it's all we have.";
};

speak_heal_player = {
	_unit globalChat "Hey, You're wounded !";
	sleep 2;
	_unit globalChat "Please let's me help you...";
};

speak_heal_civ = {
	params ["_unit"];
	_unit globalChat "Hey, I'm wounded, please help me ...";
	sleep 10;
	if (damage _unit < 0.2) then {
		_unit globalChat "Thank you very much !!";
		[player, 5] remoteExec ["F_addReput", 2];
	};
};

// Nikos
speak_mission_sdelivery1 = {
	params ["_unit"];
	private _next_unit = (GRLIB_A3W_Mission_SD select 1) select (GRLIB_A3W_Mission_SD select 0);
	if (_unit != _next_unit) exitWith {[_unit] call speak_another_time};

	private _near_case = getPosATL _unit nearEntities [a3w_sd_item, 10];
	if (count _near_case == 0) exitWith {[_unit] call speak_another_time};

	_unit globalChat localize "STR_SPEAKMANAGER13";
	sleep 3;
	_unit globalChat format [localize "STR_SPEAKMANAGER14", [a3w_sd_item] call F_getLRXName];
	sleep 3;
	_unit globalChat format [localize "STR_SPEAKMANAGER15", name _next_unit];
	sleep 3;
	_unit globalChat localize "STR_SPEAKMANAGER16";

	GRLIB_A3W_Mission_SD set [0, 1];
	publicVariable "GRLIB_A3W_Mission_SD";

	_next_unit = (GRLIB_A3W_Mission_SD select 1) select (GRLIB_A3W_Mission_SD select 0);
	if (getMarkerColor "GRLIB_A3W_Mission_SD_Marker" == "") then {
		_marker = createMarkerLocal ["GRLIB_A3W_Mission_SD_Marker", getPosATL _next_unit];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_pickup";
		_marker setMarkerColorLocal "ColorPink";
		_marker setMarkerTextlocal (name _next_unit);
	};
};

// Orestes
speak_mission_sdelivery2 = {
	params ["_unit"];
	private _next_unit = (GRLIB_A3W_Mission_SD select 1) select (GRLIB_A3W_Mission_SD select 0);
	if (_unit != _next_unit) exitWith {[_unit] call speak_another_time};

	GRLIB_A3W_Mission_SD set [0, 2];
	publicVariable "GRLIB_A3W_Mission_SD";

	_next_unit = (GRLIB_A3W_Mission_SD select 1) select (GRLIB_A3W_Mission_SD select 0);
	"GRLIB_A3W_Mission_SD_Marker" setMarkerPosLocal (getPosATL _next_unit);
	"GRLIB_A3W_Mission_SD_Marker" setMarkerTextlocal (name _next_unit);
	_unit globalChat localize "STR_SPEAKMANAGER20";
	sleep 3;
	_unit globalChat format [localize "STR_SPEAKMANAGER21", name _next_unit];
	sleep 3;
	_unit globalChat localize "STR_SPEAKMANAGER22";
};

// Orestes
speak_mission_sdelivery3 = {
	params ["_unit"];
	private _next_unit = (GRLIB_A3W_Mission_SD select 1) select (GRLIB_A3W_Mission_SD select 0);
	if (_unit != _next_unit) exitWith {[_unit] call speak_another_time};

	GRLIB_A3W_Mission_SD set [0, 3];
	publicVariable "GRLIB_A3W_Mission_SD";

	_next_unit = (GRLIB_A3W_Mission_SD select 1) select (GRLIB_A3W_Mission_SD select 0);
	"GRLIB_A3W_Mission_SD_Marker" setMarkerPosLocal (getPosATL _next_unit);
	"GRLIB_A3W_Mission_SD_Marker" setMarkerTextlocal (name _next_unit);
	_unit globalChat localize "STR_SPEAKMANAGER17";
	sleep 3;
	_unit globalChat localize "STR_SPEAKMANAGER18";
	sleep 3;
	_unit globalChat localize "STR_SPEAKMANAGER19";
	[getPos _next_unit, "militia"] remoteExec ["a3w_create_enemy", 2];
};

// Nikos Old
speak_mission_sdelivery4 = {
	params ["_unit"];
	private _next_unit = (GRLIB_A3W_Mission_SD select 1) select (GRLIB_A3W_Mission_SD select 0);
	if (_unit != _next_unit) exitWith {[_unit] call speak_another_time};

	private _near_case = getPosATL _unit nearEntities [a3w_sd_item, 3];
	if (count _near_case > 0) then {
		(_near_case select 0) setVariable ["R3F_LOG_disabled", true, true];
		deleteMarker "GRLIB_A3W_Mission_SD_Marker";
		_unit switchMove "AmovPercMstpSnonWnonDnon_Salute";
		_unit playMoveNow "AmovPercMstpSnonWnonDnon_Salute";
		_unit globalChat localize "STR_SPEAKMANAGER23";
		GRLIB_A3W_Mission_SD set [0, -1];
		publicVariable "GRLIB_A3W_Mission_SD";
	} else {
		_unit globalChat localize "STR_SPEAKMANAGER24";
	};
};

// Resistance
speak_mission_resitance = {
	params ["_unit"];
	private _grp = group _unit;
	private _leader = leader _grp;
	if (_unit == _leader) then {
		private _res = (units GRLIB_side_friendly select { alive _x && (_x getVariable ["GRLIB_A3W_Mission_MR1", false])});
		{_x setVariable ["GRLIB_can_speak", false, true]} foreach _res;
		_unit globalChat localize "STR_SPEAKMANAGER8";
		sleep 3;
		_unit globalChat localize "STR_SPEAKMANAGER9";
		sleep 3;
		_unit globalChat localize "STR_SPEAKMANAGER10";
		sleep 3;
		_unit globalChat localize "STR_SPEAKMANAGER11";
		private _sector = [200, _unit] call F_getNearestSector;
		[markerPos _sector] remoteExec ["a3w_mr_send_para", 2];
	} else {
		player globalChat localize "STR_SPEAKMANAGER6";
		sleep 2;
		_unit globalChat format [localize "STR_SPEAKMANAGER7", round (_unit distance2D _leader), round(_unit getDir _leader)];
	};
};

// Delivery
speak_mission_delivery_fuel = {
	params ["_unit"];
	[_unit, "Fuel", "barrels"] call speak_mission_delivery;
};

speak_mission_delivery_water = {
	params ["_unit"];
	[_unit, "Water", "barrels"] call speak_mission_delivery;
};

speak_mission_delivery_food = {
	params ["_unit"];
	[_unit, "Food", "pallets"] call speak_mission_delivery;
};

speak_mission_delivery_ammo = {
	params ["_unit"];
	[_unit, "Ammo", "small boxes"] call speak_mission_delivery;
};

speak_mission_delivery = {
	params ["_unit", "_txt1", "_txt2"];
	_unit switchMove "AmovPercMstpSnonWnonDnon_Salute";
	_unit playMoveNow "AmovPercMstpSnonWnonDnon_Salute";
	player globalChat localize "STR_SPEAKMANAGER25";
	sleep 2;
	_unit globalChat format [localize "STR_SPEAKMANAGER26", _txt1];
	sleep 2;
	_unit globalChat format [localize "STR_SPEAKMANAGER27", _txt2, _txt1];
	sleep 2;
	_unit globalChat format [localize "STR_SPEAKMANAGER28", _txt2];
	sleep 3;
	_unit switchMove "LHD_krajPaluby";
	_unit playMoveNow "LHD_krajPaluby";
};

// Doctor
speak_mission_heal_doctor = {
	params ["_unit"];
	private _wnded = ({alive _x && !isNil {_x getVariable "GRLIB_A3W_Mission_HC2"}} count (units GRLIB_side_civilian));
	_unit globalChat "Hello, I'm a Doctor, we have a situation here !!";
	sleep 3;
	_unit globalChat format ["Please help us to treat %1 sick villagers.", _wnded];
	sleep 3;
	_unit globalChat "Bring them all to the nearby Medical tent.";
	sleep 3;
	_unit globalChat "Hurry up !";
};

// Wounded
speak_mission_heal_wounded = {
	params ["_unit"];
	_unit globalChat "Please help me, I'm sick I need a Doctor...";
	[_unit] call F_fixPosUnit;
	sleep 3;
	_unit globalChat "I can follow you a little, I'm weak...";
	[_unit, player, 20] remoteExec ["a3w_follow_player", 2];
	sleep 4;
	_unit globalChat "Where are the Doctors ??";
};
