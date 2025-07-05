if (!isServer && hasInterface) exitWith {};
params ["_owner", "_classname", "_veh_pos", "_veh_dir", "_veh_vup"];

private _vehicle = objNull;

// Ground FOB
if (_classname in [FOB_typename, FOB_outpost]) then {
	_vehicle = createVehicle [_classname, zeropos, [], 0, "CAN_COLLIDE"];
	_vehicle allowDamage false;
	_vehicle enableSimulationGlobal true;
	_vehicle hideObjectGlobal false;
	_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
	_vehicle setPosATL _veh_pos;
	if (GRLIB_fob_type == 2) then { deleteVehicle GRLIB_vehicle_huron };
};

// Naval FOB
if (_classname in ["Land_Destroyer_01_base_F", "Land_Carrier_01_base_F"]) then {
	_vehicle = createVehicle [_classname, zeropos, [], 0, "CAN_COLLIDE"];
	_vehicle allowDamage false;
	_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
	_vehicle setPosATL _veh_pos;
	[_vehicle] call BIS_fnc_carrier01Init;
	[_vehicle] call BIS_fnc_Carrier01PosUpdate;
};

// Offshore FOB
if (_classname in ["fob_water1"]) then {
	_veh_pos set [2, 0];
	//_fob_dir = 0;
	private _objects_to_build = ([] call compile preprocessFileLineNumbers format ["scripts\fob_templates\%1.sqf", _classname]);
	private ["_nextclass", "_nextobject", "_nextpos", "_nextdir"];
	{
		_nextclass = (_x select 0);
		_nextpos = (_x select 1);
		_nextdir = (_x select 2);
		_nextpos = _veh_pos vectorAdd ([_nextpos, 0] call BIS_fnc_rotateVector2D);
		_nextobject = createVehicle [_nextclass, zeropos, [], 0, "CAN_COLLIDE"];
		_nextobject allowDamage false;
		_nextobject setDir _nextdir;
		_nextobject setPosASL _nextpos;
	} foreach _objects_to_build;
	sleep 1;

	private _curalt = 0;
	private _maxalt = 50;
	private _maxpos = (_veh_pos vectorAdd [0,0,_maxalt]);
	while { (lineIntersects [_veh_pos, _maxpos, _vehicle]) && _curalt <= _maxalt } do {
		_curalt = _curalt + 0.5;
		_veh_pos set [2, _curalt];
	};
	_vehicle = createVehicle [FOB_typename, zeropos, [], 0, "CAN_COLLIDE"];
	_vehicle allowDamage false;
	_vehicle enableSimulationGlobal true;
	_vehicle hideObjectGlobal false;
	_vehicle setVectorDirAndUp [[0,1,0], [0,0,1]];
	_vehicle setPosASL _veh_pos;
};

if (isNull _vehicle) exitWith { diag_log format ["--- LRX Error: Cannot create FOB %1 at %2", _classname, _veh_pos] };
sleep 1;

[_vehicle, getPlayerUID _owner] call fob_init;

sleep 1;
private _fob_pos = getPosATL _vehicle;
if (_classname in ["Land_Destroyer_01_base_F", "Land_Carrier_01_base_F"]) then {
	_fob_pos = getPosATL (nearestObjects [_fob_pos, [FOB_sign], 200] select 0);
};
GRLIB_all_fobs = GRLIB_all_fobs + [_fob_pos];
if (_classname == FOB_outpost) then { GRLIB_all_outposts pushBack _fob_pos };

publicVariable "GRLIB_all_fobs";
publicVariable "GRLIB_all_outposts";

[_fob_pos, 0] remoteExec ["remote_call_fob", 0];
stats_fobs_built = stats_fobs_built + 1;