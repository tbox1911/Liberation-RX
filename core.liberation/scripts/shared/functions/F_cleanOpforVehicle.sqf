params [ "_veh" ];

if ( isNull _veh ) exitWith {};

if ( _veh getVariable ["GRLIB_vehicle_owner", ""] == "" ) then {
	[_veh] call clean_vehicle;
	deleteVehicle _veh;
};