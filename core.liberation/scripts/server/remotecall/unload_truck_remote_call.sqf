if (!isServer && hasInterface) exitWith {};
params ["_truck", "_mode"];

if (isNil "_truck") exitWith {};
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

_truck allowDamage false;
_truck enableSimulationGlobal false;
sleep 1;

if (_mode == "one") then {
	_all_objects = [_all_objects select (count _all_objects - 1)];
} else {
	reverse _all_objects;
};

private _ignore_collision = [
	land_cutter_typename,
	"PowerLines_base_F",
	"PowerLines_Small_base_F",
	"PowerLines_Wires_base_F",
	"VR_Helper_base_F",
	"Helipad_base_F"
];
private ["_next_box", "_next_pos", "_next_box_dir", "_offset", "_obstacle"];
{
	_next_box = _x;
	if (!isNull _next_box) then {
		_next_pos = _truck getPos [_offset, getdir _truck];
		if (surfaceIsWater _next_pos) then {
			_next_pos set [2, ((getPosASL _truck) select 2) + 0.3];
		} else {
			_next_pos set [2, ((getPosATL _truck) select 2) + 0.3];
		};
		_obstacle = ((nearestObjects [_next_pos, ["All"], 3]) - _all_objects - [player]) select { !([_x, _ignore_collision] call F_itemIsInClass) };
		if (count _obstacle == 0) then {
			_next_box allowDamage false;
			[_next_box, _truck] remoteExec ["disableCollisionWith", 0];
			_next_box_dir = getDir _next_box;
			detach _next_box;
			_next_box setPos zeropos;
			_next_box setVelocity [0,0,0];
			sleep 0.2;
			if (surfaceIsWater _next_pos) then {
				_next_box setVectorDirAndUp [[sin _next_box_dir, cos _next_box_dir, 0], [0, 0, 1]];
				_next_box setPosASL _next_pos;
			} else {
				_next_box setVectorDirAndUp [[-cos _next_box_dir, sin _next_box_dir, 0] vectorCrossProduct surfaceNormal _next_pos, surfaceNormal _next_pos];
				_next_box setPosATL _next_pos;
			};
			sleep 0.2;
			_next_box setVelocity [0,0,0];
			_offset = _offset - 2.2;
			[format [localize "STR_BOX_UNLOADED", [typeOf _next_box] call F_getLRXName]] remoteExec ["hintSilent", owner _truck];
			_cargo = _cargo - [_next_box];
			_truck setVariable ["GRLIB_ammo_truck_load", _cargo, true];
			_next_box setVariable ["R3F_LOG_disabled", false, true];
			sleep 0.5;
			_next_box allowDamage true;
			[_next_box, _truck] remoteExec ["enableCollisionWith", 0];
		} else {
			[localize "STR_BOX_CANTUNLOAD"] remoteExec ["hintSilent", owner _truck];
		};
	};
} foreach _all_objects;
sleep 2;

_truck enableSimulationGlobal true;
_truck allowDamage true;

GRLIB_load_box = nil;
