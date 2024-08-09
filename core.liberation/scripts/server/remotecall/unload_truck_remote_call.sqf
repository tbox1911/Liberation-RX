if (!isServer && hasInterface) exitWith {};
params ["_truck", "_mode"];

if (isNull _truck) exitWith {};
private _all_objects = [] + (_truck getVariable ["GRLIB_ammo_truck_load", []]);
if (count _all_objects == 0) exitWith {};

if (!isNil "GRLIB_load_box") exitWith {};
GRLIB_load_box = true;

private _cargo = _all_objects;
private _offset = 0;
{
	if ( _x select 0 == typeof _truck ) exitWith { _offset = _x select 1 };
} foreach box_transport_config;

_truck enableSimulationGlobal false;
// _truck allowDamage false;

if (_mode == "one") then {
	_all_objects = [_all_objects select (count _all_objects - 1)];
} else {
	reverse _all_objects;
};

private ["_next_box", "_next_pos", "_offset", "_obstacle"];
{
	_next_box = _x;
	if (!isNull _next_box) then {
		_next_pos = _truck getPos [_offset, getdir _truck];
		_obstacle = (nearestObjects [_next_pos, ["All"], 4]) - _all_objects;
		if (count _obstacle == 0) then {
			_next_box allowDamage false;
			_next_box enableSimulationGlobal false;
			sleep 0.2;
			detach _next_box;
			waitUntil {sleep 0.05; isNull (attachedTo _x)};
			_next_box setPos zeropos;
			sleep 0.5;
			_next_box setVelocity [0,0,0];
			_next_box setPosATL (_next_pos vectorAdd [0, 0, 0.2]);
			//_next_box setdir (getdir _truck);
			_offset = _offset - 2.2;
			[format [localize "STR_BOX_UNLOADED", [typeOf _next_box] call F_getLRXName]] remoteExec ["hintSilent", owner _truck];
			_cargo = _cargo - [_next_box];
			_truck setVariable ["GRLIB_ammo_truck_load", _cargo, true];
			_next_box setVariable ["R3F_LOG_disabled", false, true];
			sleep 0.5;
			_next_box enableSimulationGlobal true;
			_next_box allowDamage true;
		} else {
			[localize "STR_BOX_CANTUNLOAD"] remoteExec ["hintSilent", owner _truck];
		};
	};
} foreach _all_objects;
sleep 2;

_truck enableSimulationGlobal true;
// _truck allowDamage true;

GRLIB_load_box = nil;
