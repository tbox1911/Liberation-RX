waitUntil { sleep 1; !isNil "blufor_sectors" };

private _search_list = [] + light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + support_vehicles + opfor_recyclable;
private _get_mp = {
	params ["_vehicle"];
	private _ret = 0;
	private _veh_class = typeOf _vehicle;
	{
		if ((_x select 0) == _veh_class) exitWith { _ret = (_x select 1) };
	} forEach _search_list;
	_ret;
};

private ["_manpower_used", "_player_respawn", "_player_vehicles"];
while {true} do {
	if (GRLIB_player_configured) then {
		_manpower_used = count ((units player) select { !(isPlayer _x) && alive _x });
		_player_respawn = [PAR_Grp_ID] call F_getMobileRespawns;
		_player_vehicles = [];
		if (GRLIB_permission_vehicles) then {
			_player_vehicles = (vehicles - _player_respawn) select {
				(alive _x) && ([player, _x, true] call is_owner) &&
				!(_x getVariable ['R3F_LOG_disabled', false]) &&
				isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull])
			};
		};
		{ _manpower_used = _manpower_used + ([_x] call _get_mp) } foreach (_player_vehicles + _player_respawn);
		resources_infantry = _manpower_used;
	};
	opfor_sectors = (sectors_allSectors - blufor_sectors);
	sleep 3;
};
