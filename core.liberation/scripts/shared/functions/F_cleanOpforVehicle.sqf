params [ "_veh" ];

if ( isNull _veh ) exitWith {};

if ([_veh] call is_abandoned) then {
	[_veh] call clean_vehicle;
	deleteVehicle _veh;
};