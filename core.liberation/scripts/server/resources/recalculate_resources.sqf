waitUntil {sleep 1; !isNil "save_is_loaded" };

please_recalculate = true;

while { true } do {
		waitUntil {sleep 1; please_recalculate };
		please_recalculate = false;

		[] call recalculate_caps;

		_new_manpower_used = 0;
		_new_fuel_used = 0;

		{
			if ( ( side group _x == GRLIB_side_friendly ) && ( !isPlayer _x ) ) then {
				if ( ( _x distance lhd > 250 ) && ( _x distance ( getmarkerpos GRLIB_respawn_marker) > 100 ) && ( alive _x ) ) then {
					_unit = _x;
					{
						if ( ( _x select 0 ) == typeof _unit ) then {
							_new_manpower_used = _new_manpower_used + (_x select 1);
							_new_fuel_used = _new_fuel_used + (_x select 3);
						};
					} foreach infantry_units;
				};
			};
		} foreach allUnits;

		{
			if (
				(side _x == GRLIB_side_friendly || !(_x getVariable ["GRLIB_vehicle_owner", ""] in ["", "server", "public"]) ) &&
				(_x distance lhd > 500) &&
				!(_x getVariable ['R3F_LOG_disabled', false]) &&
				isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull]) &&
				(alive _x)
				) then {
		  		_unit = _x;
				{
					if ( (_x select 0) == typeof _unit ) then {
						_new_manpower_used = _new_manpower_used + (_x select 1);
						_new_fuel_used = _new_fuel_used + (_x select 3);
					};
				} foreach ( light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + support_vehicles + opfor_recyclable );
			};
		} foreach vehicles + GRLIB_mobile_respawn;

		resources_infantry = _new_manpower_used;
		resources_fuel = _new_fuel_used;
};