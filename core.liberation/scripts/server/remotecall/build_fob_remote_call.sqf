if (!isServer && hasInterface) exitWith {};
params ["_classname", "_veh_pos", "_veh_dir", "_veh_vup", "_owner"];
private _vehicle = objNull;

if (["fob_water", _classname] call F_startsWith) then {
	_vehicle = createVehicle [FOB_typename, ([] call F_getFreePos), [], 0, "NONE"];
	if (isNull _vehicle) exitWith {};
	_vehicle allowDamage false;
	_veh_pos set [2, FOB_carrier_center];
	_vehicle setDir 0;
	_vehicle setPosASL _veh_pos;
	//_vehicle setVectorDirAndUp [_veh_dir, [0,0,1]];

	private _fob_pos = getPosASL _vehicle;
	private _fob_dir = getDir _vehicle;
	private _objects_to_build = ([] call compile preprocessFileLineNumbers format ["scripts\fob_templates\%1.sqf", _classname]);
	private ["_nextclass", "_nextobject", "_nextpos", "_nextdir"];
	{
		_nextclass = (_x select 0);
		_nextpos = (_x select 1) vectorAdd [0,0,-FOB_carrier_center];
		_nextdir = (_x select 2) + _fob_dir;
		_nextpos = _fob_pos vectorAdd ([_nextpos, -_fob_dir] call BIS_fnc_rotateVector2D);
		_nextobject = _nextclass createVehicle _nextpos;
		_nextobject allowDamage false;
		_nextobject setDir _nextdir;
		_nextobject setPosASL _nextpos;
	} foreach _objects_to_build;
} else {
	_vehicle = createVehicle [_classname, ([] call F_getFreePos), [], 0, "NONE"];
	if (isNull _vehicle) exitWith {};
	_vehicle allowDamage false;
	_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
	_vehicle setPosWorld _veh_pos;

	if (_classname isKindOf "StaticShip") then {
		[_vehicle] call BIS_fnc_carrier01Init;
		[_vehicle] call BIS_fnc_Carrier01PosUpdate;
		waitUntil { sleep 1; !(isNil {nearestObjects [_veh_pos, [FOB_carrier_center], 120] select 0}) };
		waitUntil { sleep 1; (getPosASL _vehicle) select 2 > -2 };
	};
};

if (isNull _vehicle) exitWith {};
[_vehicle, getPlayerUID _owner] call fob_init;

private _fob_pos = getPosATL _vehicle;
GRLIB_all_fobs pushback _fob_pos;
if (typeOf _vehicle == FOB_outpost) then { GRLIB_all_outposts pushBack _fob_pos };
publicVariable "GRLIB_all_fobs";
publicVariable "GRLIB_all_outposts";

[ _fob_pos, 0 ] remoteExec ["remote_call_fob", 0];
sleep 1;
stats_fobs_built = stats_fobs_built + 1;