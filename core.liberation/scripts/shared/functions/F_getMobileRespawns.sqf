params [["_uid",""]];
if (GRLIB_allow_redeploy == 0) exitWith {[]};
if (isNil "GRLIB_mobile_respawn") exitWith {[]};

private _mobile_respawn_list = [];
if (!isNil "GRLIB_mobile_respawn") then {
	_mobile_respawn_list = GRLIB_mobile_respawn select {
		(alive _x) && !(isObjectHidden _x) &&
		!(_x getVariable ['R3F_LOG_disabled', false]) &&
		!([_x, "LHD", GRLIB_fob_range] call F_check_near) &&
		!surfaceIsWater (getpos _x) && ((getPosATL _x) select 2) < 5 && speed vehicle _x < 5
	};
};

private _personal_mobile_respawn = [];
if (_uid != "") then {
	_personal_mobile_respawn = _mobile_respawn_list select { _x getVariable ["GRLIB_vehicle_owner", ""] == _uid };

	if (count _personal_mobile_respawn > GRLIB_max_spawn_point && PAR_Grp_ID == _uid) then {
		hintSilent localize "STR_TOO_MANY_SPAWN";
		_mobile_respawn_list = _personal_mobile_respawn select [0, GRLIB_max_spawn_point];
		GRLIB_max_respawn_reached = true;
	} else {
		_mobile_respawn_list = _personal_mobile_respawn;
		GRLIB_max_respawn_reached = false;
	};
};

_mobile_respawn_list;