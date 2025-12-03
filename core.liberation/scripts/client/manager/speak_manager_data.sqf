speak_another_time = {
	params ["_unit"];
	_unit globalChat localize "STR_SPEAKMANAGER12";
};

speak_squad_AI = {
	params ["_unit"];
	player globalChat format [localize "STR_CHAT_HELLO", name _unit];
	sleep 2;
	private _max_revive = ([_unit] call PAR_revive_max);
	private _cur_revive = ([_unit] call PAR_revive_cur);
	if (_cur_revive >= 0) then {
		private _msg = localize "STR_REPLY_FINE";
		if (_cur_revive <= (_max_revive * 0.6)) then { _msg = format [localize "STR_REPLY_TIRED", (_max_revive - _cur_revive)] };
		if (_cur_revive <= 3) then { _msg = format [localize "STR_REPLY_BAD_NEED_MEDIC", _cur_revive] };
		if (_cur_revive == 0) then { _msg = localize "STR_REPLY_CRITICAL" };
		_unit globalChat _msg;
	};
};

speak_civil_AI = {
	params ["_unit"];

	if (_unit getVariable ["GRLIB_A3W_Mission_MR1", false]) exitWith {[_unit] call speak_mission_resistance};
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
	if (damage _unit > 0.15 && side _unit == GRLIB_side_civilian) exitWith {[_unit] call speak_heal_civ};
	// transport
	//	if (_unit getVariable ["GRLIB_Mission_CIV01", false]) exitWith {[_unit] call speak_mission_civ01};
	// need ammo
	//	if (_unit getVariable ["GRLIB_Mission_CIV02", false]) exitWith {[_unit] call speak_mission_civ02};
	// need fuel
	//	if (_unit getVariable ["GRLIB_Mission_CIV03", false]) exitWith {[_unit] call speak_mission_civ03};

	player globalChat localize "STR_SPEAKMANAGER1";
	sleep 2;
	private _reputation = [player] call F_getReput;
	if (_reputation >= 25) exitWith { [_unit] call speak_info_unit };
	if (_reputation <= -25) exitWith { [_unit] call speak_insult_unit };
	_msg = selectRandom [localize "STR_SPEAKMANAGER3",localize "STR_SPEAKMANAGER4",localize "STR_SPEAKMANAGER5", "Anerríphthô kúbos ?"];
	_unit globalChat _msg;
};

speak_info_unit = {
	params ["_unit"];
	private _greetings = [
		localize "STR_GREETING_HELLO",
		localize "STR_GREETING_HI",
		localize "STR_GREETING_HEY",
		localize "STR_GREETING_GOODMORNING"
	];
	private _goodbye = [
		localize "STR_GOODBYE_BYE",
		localize "STR_GOODBYE_TAKECARE",
		localize "STR_GOODBYE_CIAO"
	];
	if (([player] call F_getReput) >= 50) then {
		_goodbye = [
			localize "STR_GOODBYE_HIGH_GREATJOB",
			localize "STR_GOODBYE_HIGH_GLAD",
			localize "STR_GOODBYE_HIGH_ENDLESSWAR",
			localize "STR_GOODBYE_HIGH_KILLTHEMALL"
		];
	};
	if (([player] call F_getReput) >= 75) then {
		_goodbye = [
			localize "STR_GOODBYE_ELITE_BLESS",
			localize "STR_GOODBYE_ELITE_LOVE",
			localize "STR_GOODBYE_ELITE_DAUGHTER",
			localize "STR_GOODBYE_ELITE_WINWAR"
		];
	};
	_unit globalChat (selectRandom _greetings);
	sleep 2;
	private _opfor_list = (units GRLIB_side_enemy) select {alive _x && _x distance2D getPos _unit < 500};
	if (count _opfor_list > 0) then {
		_opfor = _opfor_list select 0;
		_unit globalChat (format [localize "STR_SPEAKMANAGER2", round(_unit distance2D _opfor), round(_unit getDir _opfor)]);
	} else {
		_unit globalChat localize "STR_DIALOG_NO_INFORMATION";
	};
	sleep 2;
	_unit globalChat (selectRandom _goodbye);
};

speak_insult_unit = {
	params ["_unit"];
	private _insults = [
		localize "STR_INSULT_FUCK_OFF",
		localize "STR_INSULT_YOU_DIE",
		localize "STR_INSULT_WE_HATE_YOU",
		localize "STR_INSULT_GO_HOME",
		localize "STR_INSULT_LEAVE_LAND",
		localize "STR_INSULT_NOT_WELCOME",
		localize "STR_INSULT_DISLIKE",
		localize "STR_INSULT_NO_TALK"
	];
	_unit globalChat (selectRandom _insults);
};

speak_repair_vehicle = {
    _unit globalChat localize "STR_DIALOG_REPAIR_HELLO";
    sleep 2;
    _unit globalChat localize "STR_DIALOG_REPAIR_WAIT";
};

speak_join_player = {
    _unit globalChat format [localize "STR_DIALOG_JOIN_HELLO", name _unit];
    sleep 2;
    _unit globalChat localize "STR_DIALOG_JOIN_FIGHT";
};

speak_repair = {
	_unit globalChat localize "STR_DIALOG_NEED_REPAIR";
};

speak_player_repair = {
	_unit globalChat localize "STR_DIALOG_THANK_REPAIR";
	if (([player] call F_getReput) >= 25) then {
		sleep 2;
		[_unit] call speak_info_unit; // ← 继续对话，比如提供情报
	};
};

speak_refuel = {
	_unit globalChat localize "STR_DIALOG_NEED_FUEL";
};

speak_player_refuel = {
	_unit globalChat localize "STR_DIALOG_THANK_REFUEL";
	if (([player] call F_getReput) >= 25) then {
		sleep 2;
		[_unit] call speak_info_unit;
	};
};

speak_reammo_player = {
	_unit globalChat localize "STR_DIALOG_OFFER_AMMO_1";
	sleep 2;
	_unit globalChat localize "STR_DIALOG_OFFER_AMMO_2";
};

speak_heal_player = {
	_unit globalChat localize "STR_DIALOG_OFFER_HEAL_1";
	sleep 2;
	_unit globalChat localize "STR_DIALOG_OFFER_HEAL_2";
};

speak_heal_civ = {
	params ["_unit"];
	_unit globalChat localize "STR_DIALOG_REQUEST_HEAL";
	private _timer = time + 45;
	private _damage = damage _unit;
	waitUntil {
		sleep 5;
		(time > _timer || (damage _unit < _damage))
	};
	if (time > _timer) exitWith {};
	_unit globalChat localize "STR_DIALOG_THANK_YOU";
	[player, 3] remoteExec ["F_addReput", 2];
	_unit setDamage 0;
};

// Nikos
speak_mission_sdelivery1 = {
	params ["_unit"];
	if (isNil "GRLIB_A3W_Mission_SD") exitWith {[_unit] call speak_another_time};
	private _suitcase = GRLIB_A3W_Mission_SD select 2;
	private _suitcase_far = (_unit distance2D _suitcase > 20);
	if (_suitcase_far) exitWith {[_unit] call speak_another_time};
	private _next_unit = (GRLIB_A3W_Mission_SD select 1) select (GRLIB_A3W_Mission_SD select 0);
	if (_unit != _next_unit && _suitcase_far) exitWith {[_unit] call speak_another_time};
	_suitcase setVariable ["R3F_LOG_disabled", false, true];
	_unit globalChat localize "STR_SPEAKMANAGER13";
	sleep 3;
	_unit globalChat format [localize "STR_SPEAKMANAGER14", [a3w_sd_item] call F_getLRXName];
	sleep 3;
	_unit globalChat format [localize "STR_SPEAKMANAGER15", name _next_unit];
	sleep 3;
	_unit globalChat localize "STR_SPEAKMANAGER16";
	GRLIB_A3W_Mission_SD set [0, 1];
	publicVariable "GRLIB_A3W_Mission_SD";
};

// Orestes
speak_mission_sdelivery2 = {
	params ["_unit"];
	if (isNil "GRLIB_A3W_Mission_SD") exitWith {[_unit] call speak_another_time};
	private _suitcase = GRLIB_A3W_Mission_SD select 2;
	private _suitcase_far = (_unit distance2D _suitcase > 20);
	if (_suitcase_far) exitWith {[_unit] call speak_another_time};
	private _next_unit = (GRLIB_A3W_Mission_SD select 1) select (GRLIB_A3W_Mission_SD select 0);
	if (_unit != _next_unit && _suitcase_far) exitWith {[_unit] call speak_another_time};
	_unit globalChat localize "STR_SPEAKMANAGER20";
	sleep 3;
	_unit globalChat format [localize "STR_SPEAKMANAGER21", name _next_unit];
	sleep 3;
	_unit globalChat localize "STR_SPEAKMANAGER22";
	GRLIB_A3W_Mission_SD set [0, 2];
	publicVariable "GRLIB_A3W_Mission_SD";
};

// Orestes
speak_mission_sdelivery3 = {
	params ["_unit"];
	if (isNil "GRLIB_A3W_Mission_SD") exitWith {[_unit] call speak_another_time};
	private _suitcase = GRLIB_A3W_Mission_SD select 2;
	private _suitcase_far = (_unit distance2D _suitcase > 20);
	if (_suitcase_far) exitWith {[_unit] call speak_another_time};
	private _next_unit = (GRLIB_A3W_Mission_SD select 1) select (GRLIB_A3W_Mission_SD select 0);
	if (_unit != _next_unit && _suitcase_far) exitWith {[_unit] call speak_another_time};
	_unit globalChat localize "STR_SPEAKMANAGER17";
	sleep 3;
	_unit globalChat localize "STR_SPEAKMANAGER18";
	sleep 3;
	_unit globalChat localize "STR_SPEAKMANAGER19";
	GRLIB_A3W_Mission_SD set [0, 3];
	publicVariable "GRLIB_A3W_Mission_SD";
};

// Nikos Old
speak_mission_sdelivery4 = {
	params ["_unit"];
	if (isNil "GRLIB_A3W_Mission_SD") exitWith {[_unit] call speak_another_time};
	private _suitcase = GRLIB_A3W_Mission_SD select 2;
	private _suitcase_far = (_unit distance2D _suitcase > 20);
	if (_suitcase_far) exitWith {[_unit] call speak_another_time};
	private _next_unit = (GRLIB_A3W_Mission_SD select 1) select (GRLIB_A3W_Mission_SD select 0);
	if (_unit != _next_unit && _suitcase_far) exitWith {[_unit] call speak_another_time};
	if (_unit distance2D _suitcase <= 3) then {
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
speak_mission_resistance = {
	params ["_unit"];
	private _leader = leader group _unit;
	if (_unit == _leader) then {
		{ _x setVariable ["GRLIB_can_speak", false, true] } foreach GRLIB_A3W_Mission_MR_BLUFOR;
		_unit globalChat localize "STR_SPEAKMANAGER8";
		sleep 3;
		_unit globalChat localize "STR_SPEAKMANAGER9";
		sleep 3;
		_unit globalChat localize "STR_SPEAKMANAGER10";
		sleep 3;
		_unit globalChat localize "STR_SPEAKMANAGER11";
		GRLIB_A3W_Mission_MR_START = true;
		publicVariable "GRLIB_A3W_Mission_MR_START";
	} else {
		player globalChat localize "STR_SPEAKMANAGER6";
		sleep 2;
		_unit globalChat format [localize "STR_SPEAKMANAGER7", round (_unit distance2D _leader), round (_unit getDir _leader)];
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
	if (_wnded == 0) exitWith { _unit globalChat localize "STR_DIALOG_DOCTOR_REQUEST_FINISH" };
	_unit globalChat localize "STR_DIALOG_DOCTOR_INTRO";
	sleep 3;
	_unit globalChat format [localize "STR_DIALOG_DOCTOR_REQUEST_COUNT", _wnded];
	sleep 3;
	_unit globalChat localize "STR_DIALOG_DOCTOR_INSTRUCT";
	sleep 3;
	_unit globalChat localize "STR_DIALOG_DOCTOR_HURRY";
};

// Wounded
speak_mission_heal_wounded = {
	params ["_unit"];
	_unit globalChat localize "STR_DIALOG_HEAL_REQUEST";
	[_unit] call F_fixPosUnit;
	_unit globalChat localize "STR_DIALOG_HEAL_WEAK_FOLLOW";
	[_unit, player, 20] remoteExec ["a3w_follow_player", 2];
	sleep 4;
	_unit globalChat localize "STR_DIALOG_HEAL_LOOKING_DOCTOR";
};

// Civilian Transport
speak_mission_civ01 = {
};

// Civilian need ammo
speak_mission_civ02 = {
};

// Civilian need fuel
speak_mission_civ03 = {
};