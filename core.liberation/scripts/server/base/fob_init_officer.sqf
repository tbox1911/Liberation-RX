params ["_fob"];

private _fob_class = typeOf _fob;
private _fob_pos = getPosATL _fob;
private _fob_dir = getDir _fob;
private _fob_data = [_fob_class] call fob_init_data;
private _map_offset = (_fob_data select 1 select 0);
private _map_dir = _fob_dir + (_fob_data select 1 select 1);
private _map_pos = _fob_pos vectorAdd ([_map_offset, -_map_dir] call BIS_fnc_rotateVector2D);

private _map = createVehicle ["MapBoard_seismic_F", zeropos, [], 0, "CAN_COLLIDE"];
_map allowDamage false;
_map enableSimulationGlobal false;
_map setDir _map_dir;
_map setPosATL _map_pos;
_map setVariable ["R3F_LOG_disabled", true, true];
_map setVariable ["GRLIB_vehicle_owner", "server", true];	
//_map setObjectTextureGlobal [0, getMissionPath "res\splash_libe2.paa"];

private _lamp1 = objNull;
private _lamp2 = objNull;
if !(surfaceIsWater _fob_pos) then {
	private _lampPos = _fob_pos vectorAdd ([[-10, -7, 0], -_map_dir] call BIS_fnc_rotateVector2D);
	_lamp1 = createVehicle ["Land_LampStreet_02_amplion_F", zeropos, [], 0, "CAN_COLLIDE"];
	_lamp1 allowDamage false;
	_lamp1 setDir (_map_dir + 45);
	_lamp1 setPosATL _lampPos;
	_lamp1 setVariable ["R3F_LOG_disabled", true, true];
	_lamp1 setVariable ["GRLIB_vehicle_owner", "server", true];

	private _lampPos = _fob_pos vectorAdd ([[10, 7, 0], -_map_dir] call BIS_fnc_rotateVector2D);
	_lamp2 = createVehicle ["Land_LampStreet_02_triple_F", zeropos, [], 0, "CAN_COLLIDE"];
	_lamp2 allowDamage false;
	_lamp2 setDir (_map_dir + 45);
	_lamp2 setPosATL _lampPos;
	_lamp2 setVariable ["R3F_LOG_disabled", true, true];
	_lamp2 setVariable ["GRLIB_vehicle_owner", "server", true];	
};

private _map_dir = getDir _map;
private _manPos = (getPosATL _map) vectorAdd ([[0, -2, 0.2], -_map_dir] call BIS_fnc_rotateVector2D);
_man = createAgent [FOB_Man, zeropos, [], 0, "NONE"];
_man setCaptive true;
_man setVariable ["GRLIB_FOB_Group", true, true];
_man allowDamage false;
_man disableCollisionWith _map;
_man setDir (_map_dir + 180);
_man setPosATL _manPos;
doStop _man;
[_man, "AidlPercMstpSnonWnonDnon_AI"] spawn F_startAnimMP;

_fob setVariable ["GRLIB_FOB_Officer", _man];
_fob setVariable ["GRLIB_FOB_Objects", [_map, _lamp1, _lamp2]];
