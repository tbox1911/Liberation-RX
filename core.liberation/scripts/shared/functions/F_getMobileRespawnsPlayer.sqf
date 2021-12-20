params ["_playerId"];
private _max_respawn_reached = false;

private _respawn_trucks_unsorted = [entities [[Respawn_truck_typename, huron_typename], [], false, true], {
	_x getVariable ["GRLIB_vehicle_owner", ""] == _playerId &&
	!(_x getVariable ['R3F_LOG_disabled', true]) &&
	alive _x && _x distance2D lhd > GRLIB_sector_size &&
	!surfaceIsWater (getpos _x) &&
	((getpos _x) select 2) < 5 &&  speed _x < 5
}] call BIS_fnc_conditionalSelect;

private _respawn_tent_unsorted = [];
if (!isNil "GRLIB_mobile_respawn") then {
	_respawn_tent_unsorted = [ GRLIB_mobile_respawn, {
		_x getVariable ["GRLIB_vehicle_owner", ""] == _playerId &&
		_x distance2D lhd > GRLIB_sector_size &&
		!surfaceIsWater (getpos _x) &&
		_x distance2D ([_x] call F_getNearestFob) > GRLIB_sector_size &&
		isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull])
	}] call BIS_fnc_conditionalSelect;
};

private _player_respawn_unsorted = _respawn_trucks_unsorted + _respawn_tent_unsorted;
if (count _player_respawn_unsorted > GRLIB_max_spawn_point && getPlayerUID player == _playerId) then {
	hintSilent localize "STR_TOO_MANY_SPAWN";
	_player_respawn_unsorted = _player_respawn_unsorted select [0, GRLIB_max_spawn_point];
	_max_respawn_reached = true;
};

private _respawn_trucks_sorted = [ _player_respawn_unsorted , [] , { (getpos _x) select 0 } , 'ASCEND' ] call BIS_fnc_sortBy;

[_respawn_trucks_sorted, _max_respawn_reached];