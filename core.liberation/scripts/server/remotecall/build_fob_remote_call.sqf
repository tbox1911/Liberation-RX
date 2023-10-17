if (!isServer && hasInterface) exitWith {};
params ["_classname", "_pos", "_veh_dir", "_veh_vup", "_veh_pos", "_owner"];

private _vehicle = _classname createVehicle _pos;
if (isNull _vehicle) exitWith {};

_vehicle allowDamage false;
_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
_vehicle setPosWorld _veh_pos;

if (_classname == FOB_carrier) then {
	_vehicle setposASL _pos;
	[_vehicle] call BIS_fnc_Carrier01PosUpdate;
	waitUntil { sleep 1; _vehicle = nearestObjects [_pos, [FOB_carrier_center], 120] select 0; !isNil "_vehicle" };
};

[_vehicle, _owner] call fob_init;
private _fob_pos = getPosATL _vehicle;
GRLIB_all_fobs pushback _fob_pos;

if (typeOf _vehicle == FOB_outpost) then { GRLIB_all_outposts pushBack _fob_pos };

publicVariable "GRLIB_all_fobs";
publicVariable "GRLIB_all_outposts";

[ _fob_pos, 0 ] remoteExec ["remote_call_fob", 0];
sleep 1;
stats_fobs_built = stats_fobs_built + 1;