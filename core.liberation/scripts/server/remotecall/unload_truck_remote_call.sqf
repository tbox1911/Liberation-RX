if (!isServer && hasInterface) exitWith {};
params ["_truck"];

if (isNull _truck) exitWith {};
if (!isNil "GRLIB_load_box") exitWith {};
GRLIB_load_box = true;

private _offset = 0;
{
	if ( _x select 0 == typeof _truck ) exitWith { _offset = _x select 1 };
} foreach box_transport_config;

_truck enableSimulationGlobal false;
_truck allowDamage false;

private _all_objects = _truck getVariable ["GRLIB_ammo_truck_load", []];
{
	[_x, _truck] remoteExec ["disableCollisionWith", 0];
	_x allowDamage false;
} foreach _all_objects;
sleep 1;

private [ "_next_box", "_next_pos" ];
{
	_next_box = _x;
	if (!isNull _next_box) then {
		detach _next_box;
		waitUntil {sleep 0.1; isNull (attachedTo _x)};
		_next_box setVelocity [ 0,0,0 ];
		_next_pos = _truck getPos [_offset, getdir _truck];
		_next_box setPosATL (_next_pos vectorAdd [0, 0, 0.2]);
		//_next_box setdir (getdir _truck);
		//_next_box enableSimulationGlobal true;
		_next_box setVelocity [0,0,0];
		_offset = _offset - 2.2;
		[format [localize "STR_BOX_UNLOADED", [typeOf _next_box] call F_getLRXName]] remoteExec ["hintSilent", owner _truck];
		sleep 0.5;
	};
} foreach _all_objects;
sleep 2;

{
	[_x, _truck] remoteExec ["enableCollisionWith", 0];
	_x allowDamage true;
	_x setVariable ["R3F_LOG_disabled", false, true];
} foreach _all_objects;
sleep 1;

_truck enableSimulationGlobal true;
_truck allowDamage true;
_truck setVariable ["GRLIB_ammo_truck_load", [], true];

GRLIB_load_box = nil;
