params ["_uid"];
if (GRLIB_allow_redeploy == 0) exitWith {[[], true]};
private _max_respawn_reached = false;

private _respawn_trucks_unsorted = vehicles select {
	(alive _x) && !(isObjectHidden _x) &&
	(typeOf _x in respawn_vehicles) &&
	isNull (attachedTo  _x) &&
	(_x getVariable ["GRLIB_vehicle_owner", ""] == _uid) &&
	!(_x getVariable ['R3F_LOG_disabled', false]) &&
	alive _x && !([_x, "LHD", GRLIB_fob_range] call F_check_near) &&
	!surfaceIsWater (getpos _x) && ((getPosATL _x) select 2) < 5 && speed vehicle _x < 5
};

private _respawn_tent_unsorted = [];
if (!isNil "GRLIB_mobile_respawn") then {
	_respawn_tent_unsorted = GRLIB_mobile_respawn select {
		(_x getVariable ["GRLIB_vehicle_owner", ""] == _uid) &&
		!(_x getVariable ['R3F_LOG_disabled', false]) &&
		isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull]) &&
		!([_x, "LHD", GRLIB_fob_range] call F_check_near) &&
		!surfaceIsWater (getpos _x) && ((getPosATL _x) select 2) < 5 && speed vehicle _x < 5
	};
};

private _player_respawn_unsorted = _respawn_trucks_unsorted + _respawn_tent_unsorted;
if (count _player_respawn_unsorted > GRLIB_max_spawn_point && PAR_Grp_ID == _uid) then {
	hintSilent localize "STR_TOO_MANY_SPAWN";
	_player_respawn_unsorted = _player_respawn_unsorted select [0, GRLIB_max_spawn_point];
	_max_respawn_reached = true;
};

private _respawn_trucks_sorted = [_player_respawn_unsorted, [], {(getpos _x) select 0}, 'ASCEND'] call BIS_fnc_sortBy;

[_respawn_trucks_sorted, _max_respawn_reached];