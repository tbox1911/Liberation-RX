if (!isServer && hasInterface) exitWith {};
params [ "_truck_to_unload" ];
private [ "_next_box", "_next_pos", "_offset", "_all_objects" ];

_offset = 0;
{
	if ( _x select 0 == typeof _truck_to_unload ) then { _offset = _x select 1; };
} foreach box_transport_config;

_truck_to_unload allowDamage false;
_truck_to_unload enableSimulationGlobal false;
_all_objects = attachedObjects _truck_to_unload;
{ 
	_truck_to_unload disableCollisionWith _x;
	_x allowDamage false;
} forEach _all_objects;

sleep 0.5;
{
	_next_box = _x;
	detach _next_box;
	_next_pos = [getpos _truck_to_unload, _offset, getdir _truck_to_unload] call BIS_fnc_relPos;
	_next_box setpos (_next_pos vectorAdd [0, 0, 0.2]);
	_next_box setdir (getdir _truck_to_unload);
	_next_box setVelocity [ 0,0,0 ];
	_offset = _offset - 2.2;
	sleep 0.5;	
} foreach _all_objects;

sleep 2;
{
	_truck_to_unload enableCollisionWith _x;
	_x setDamage 0;
	_x allowDamage true;
	_x setVariable ["R3F_LOG_disabled", false, true];
} forEach _all_objects;

_truck_to_unload enableSimulationGlobal true;
_truck_to_unload allowDamage true;
