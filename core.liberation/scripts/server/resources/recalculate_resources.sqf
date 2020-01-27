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
				(side _x == GRLIB_side_friendly || ({side _x == GRLIB_side_civilian} count (crew vehicle _x) == 0)) &&
				(_x distance lhd > 250) &&
				!(_x getVariable ['R3F_LOG_disabled', false]) &&
				(alive _x)
				) then {
		  		_unit = _x;
				{
					if ( (_x select 0) == typeof _unit ) then {
						_new_manpower_used = _new_manpower_used + (_x select 1);
						_new_fuel_used = _new_fuel_used + (_x select 3);
					};
				} foreach ( light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + support_vehicles );
			};
		} foreach vehicles;

		_respawn_tents_unsorted = [ allMissionObjects "Land_TentDome_F", { alive _x &&
										_x distance2D lhd > 1000 &&
										_x distance2D ([_x] call F_getNearestFob) > GRLIB_sector_size &&
										!surfaceIsWater (getpos _x) &&
										isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull])
										}] call BIS_fnc_conditionalSelect;
		_new_manpower_used = _new_manpower_used + (support_vehicles select {(_x select 0) == "Land_TentDome_F"} select 0 select 1) * count _respawn_tents_unsorted;

		resources_infantry = _new_manpower_used;
		resources_fuel = _new_fuel_used;
};