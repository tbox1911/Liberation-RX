if (GRLIB_allow_redeploy == 0) exitWith {[]};
if (isNil "GRLIB_mobile_respawn") exitWith {[]};

private _mobile_respawn_list = GRLIB_mobile_respawn select {
	(alive _x) && !(isObjectHidden _x) &&
	!(_x getVariable ['R3F_LOG_disabled', false]) &&
	!(([_x, "LHD", GRLIB_fob_range] call F_check_near) && typeOf _x == mobile_respawn) &&
	!surfaceIsWater (getpos _x) && ((getPosATL _x) select 2) < 5 && speed vehicle _x < 5
};

// Server
private _server_mobile_respawn = _mobile_respawn_list select { _x getVariable ["GRLIB_vehicle_owner", ""] == "lrx" };

// Players
private _player_mobile_respawn = [];
{
	_uid = getPlayerUID _x;
	_p1 = _mobile_respawn_list select { _x getVariable ["GRLIB_vehicle_owner", ""] == _uid };
	_p1 = _p1 select [0, GRLIB_max_spawn_point];
	if (count _p1 > 0) then { _player_mobile_respawn append _p1 };
} foreach (AllPlayers - (entities "HeadlessClient_F"));

(_server_mobile_respawn + _player_mobile_respawn);
