waitUntil {sleep 1; GRLIB_player_spawned};

private ["_new_manpower_used", "_unit"];

while { true } do {

		_new_manpower_used = 0;
		{
			if ( !(isPlayer _x) && alive _x && !(_x getVariable ["GRLIB_is_prisonner", false]) ) then {
				_unit = _x;
				{
					if ( ( _x select 0 ) == typeof _unit ) then { _new_manpower_used = _new_manpower_used + (_x select 1) };
				} foreach infantry_units;				
			};
		} foreach (units group player);

		{
			if ( (alive _x) &&
				 (_x getVariable ["GRLIB_vehicle_owner", ""] == getPlayerUID player) &&
				 !(_x getVariable ['R3F_LOG_disabled', false]) &&
				 isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull])
				) then {
		  		_unit = _x;
				{
					if ( (_x select 0) == typeof _unit ) then {
						_new_manpower_used = _new_manpower_used + (_x select 1);
					};
				} foreach ( light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + support_vehicles + opfor_recyclable );
			};
		} foreach vehicles + GRLIB_mobile_respawn;

		resources_infantry = _new_manpower_used;
	sleep 2;
};