if (!isServer && hasInterface) exitWith {};
params [ "_truck_to_unload" ];
private [ "_next_box", "_next_pos", "_offset", "_all_objects" ];

_offset = 0;
{
	if ( _x select 0 == typeof _truck_to_unload ) then { _offset = _x select 1; };
} foreach box_transport_config;

_truck_to_unload allowDamage false;
_truck_to_unload enableSimulationGlobal false;
_all_objects = _truck_to_unload getVariable ["GRLIB_ammo_truck_load", []];

{
	_next_box = _x;
	if (!isNull _next_box) then {
		_truck_to_unload disableCollisionWith _next_box;
		_next_box allowDamage false;
		sleep 0.2;
		detach _next_box;
		_next_pos = [getPosATL _truck_to_unload, _offset, getdir _truck_to_unload] call BIS_fnc_relPos;
		_next_box setPosATL (_next_pos vectorAdd [0, 0, 0.2]);
		_next_box setdir (getdir _truck_to_unload);
		_next_box setVelocity [ 0,0,0 ];
		_offset = _offset - 2.2;
		[format [localize "STR_BOX_UNLOADED", getText (configOf _next_box >> "displayName")]] remoteExec ["hintSilent", owner _truck_to_unload];
		sleep 0.5;

		_next_box enableSimulationGlobal true;
		_truck_to_unload enableCollisionWith _next_box;
		sleep 0.5;
		_next_box allowDamage true;
		_next_box setVariable ["R3F_LOG_disabled", false, true];
	};
} foreach _all_objects;

_truck_to_unload enableSimulationGlobal true;
_truck_to_unload allowDamage true;
_truck_to_unload setVariable ["GRLIB_ammo_truck_load", [], true];
