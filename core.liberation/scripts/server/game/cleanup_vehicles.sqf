private [ "_nextvehicle", "_nearestfob", "_reset_ticker"];

_cleanup_classnames = [];
{
	_cleanup_classnames pushback (_x select 0);
} foreach (air_vehicles + heavy_vehicles + light_vehicles);

while { GRLIB_cleanup_vehicles > 0 } do {

	sleep 600;

	{
		_reset_ticker = true;
		_nextvehicle = _x;
		_nearestfob = [ getpos _nextvehicle ] call F_getNearestFob;
		if ( count _nearestfob == 3 ) then {
			if ( ( _nextvehicle distance _nearestfob > ( 4 * GRLIB_fob_range ) ) && ( _nextvehicle distance lhd > ( 4 * GRLIB_fob_range ) ) ) then {
				if ( typeof _nextvehicle in _cleanup_classnames ) then {
					_owner_id = _nextvehicle getVariable ["GRLIB_vehicle_owner", ""];
					if ( count ( crew _nextvehicle ) == 0 && _owner_id == "" ) then {
						_nextvehicle setVariable [ "GRLIB_empty_vehicle_ticker", ( _nextvehicle getVariable [ "GRLIB_empty_vehicle_ticker", 0 ] ) + 1 ];
						_reset_ticker = false;
					};
				};
			};
		} ;

		if ( _reset_ticker ) then {
			_nextvehicle setVariable  [ "GRLIB_empty_vehicle_ticker", 0 ];
		};

		if (  _nextvehicle getVariable [ "GRLIB_empty_vehicle_ticker", 0 ] >= ( 6 * GRLIB_cleanup_vehicles ) ) then {
			if ( _nextvehicle isKindOf "AllVehicles") then {
				// Delete Cargo
				{deleteVehicle _x} forEach (_nextvehicle getVariable ["R3F_LOG_objets_charges", []]);
				{deleteVehicle _x} forEach crew _nextvehicle;
			};
			deleteVehicle _nextvehicle;
		};

		sleep 0.5;
	} foreach vehicles;
};