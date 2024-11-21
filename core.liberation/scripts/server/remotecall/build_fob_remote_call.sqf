if (!isServer && hasInterface) exitWith {};
params ["_classname", "_veh_pos", "_veh_dir", "_veh_vup", "_owner"];
private ["_fob_pos"];
private _vehicle = objNull;

// Ground FOB
if (_classname in [FOB_typename, FOB_outpost]) then {
	_vehicle = createVehicle [_classname, ([] call F_getFreePos), [], 0, "NONE"];
	_vehicle allowDamage false;
	_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
	_vehicle setPosWorld _veh_pos;
	waitUntil {sleep 0.5; _vehicle distance2D _veh_pos < 10 };
	[_vehicle, getPlayerUID _owner] call fob_init;
	_fob_pos = getPosATL _vehicle;
	GRLIB_all_fobs = GRLIB_all_fobs + [_fob_pos];
	if (_classname == FOB_outpost) then { GRLIB_all_outposts pushBack _fob_pos };
};

// Naval FOB
if (_classname in ["Land_Destroyer_01_base_F", "Land_Carrier_01_base_F"]) then {
	_vehicle = createVehicle [_classname, ([] call F_getFreePos), [], 0, "NONE"];
	_vehicle allowDamage false;
	_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
	_vehicle setPosWorld _veh_pos;
	[_vehicle] call BIS_fnc_carrier01Init;
	[_vehicle] call BIS_fnc_Carrier01PosUpdate;
	[_vehicle, getPlayerUID _owner] call fob_init;
	_fob_pos = getPosATL (nearestObjects [_veh_pos, [FOB_sign], 200] select 0);
	GRLIB_all_fobs = GRLIB_all_fobs + [_fob_pos];
};

// Offshore FOB
if (_classname in ["fob_water1"]) then {
	_vehicle = createVehicle [FOB_typename, ([] call F_getFreePos), [], 0, "NONE"];
	_vehicle allowDamage false;
	private _fob_water_alt = 7;
	_veh_pos set [2, _fob_water_alt];
	_vehicle setVectorDirAndUp [[0,1,0], [0,0,1]];
	_vehicle setPosWorld _veh_pos;
	waitUntil {sleep 0.5; _vehicle distance2D _veh_pos < 10 };
	_fob_pos = getPosASL _vehicle;
	_fob_dir = getDir _vehicle;
	private _objects_to_build = ([] call compile preprocessFileLineNumbers format ["scripts\fob_templates\%1.sqf", _classname]);
	private ["_nextclass", "_nextobject", "_nextpos", "_nextdir"];
	{
		_nextclass = (_x select 0);
		_nextpos = (_x select 1) vectorAdd [0,0,-_fob_water_alt];
		_nextdir = (_x select 2) + _fob_dir;
		_nextpos = _fob_pos vectorAdd ([_nextpos, -_fob_dir] call BIS_fnc_rotateVector2D);
		_nextobject = _nextclass createVehicle _nextpos;
		_nextobject allowDamage false;
		_nextobject setDir _nextdir;
		_nextobject setPosASL _nextpos;
	} foreach _objects_to_build;
	if (FOB_typename == "Land_vn_bunker_big_02") then { _vehicle setVectorDir [-1,0,0] };
	[_vehicle, getPlayerUID _owner] call fob_init;
	_fob_pos = getPosATL _vehicle;
	GRLIB_all_fobs = GRLIB_all_fobs + [_fob_pos];
};

if (isNull _vehicle) exitWith {};
publicVariable "GRLIB_all_fobs";
publicVariable "GRLIB_all_outposts";

[_fob_pos, 0] remoteExec ["remote_call_fob", 0];
stats_fobs_built = stats_fobs_built + 1;