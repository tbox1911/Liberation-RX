params ["_fob"];

if (isNil "GRLIB_FOB_Group") then {
	GRLIB_FOB_Group = createGroup [GRLIB_side_civilian, true];
};
if (isNull GRLIB_FOB_Group) then {
	GRLIB_FOB_Group = createGroup [GRLIB_side_civilian, true];
};

private _fob_class = typeOf _fob;
private _fob_pos = getPosATL _fob;
private _fob_dir = getDir _fob;
private _offset = [0,0,0];

// Default A3
if (_fob_class isKindOf "Cargo_HQ_base_F") then {
	_offset = [-2, 2, 0.6];
	_fob_dir = _fob_dir + 55;
};
if (_fob_class == "Land_Bunker_01_HQ_F") then {
	_offset = [-1.5, 2, -0.2];
	_fob_dir = _fob_dir + 0;
};
if (_fob_class isKindOf "Land_GuardHouse_02_F") then {
	_offset = [2.5, 3, 0.2]; 
	_fob_dir = _fob_dir + 0; 
};

// SoG
if (_fob_class == "Land_vn_bunker_big_02") then {
	_offset = [0, 1.5, 2];
	_fob_dir = _fob_dir + 180;
};

// SPE
if (_fob_class == "Land_SPE_H679") then {
	_offset = [0, 2, 0]; 
	_fob_dir = _fob_dir + 0
};

private _desk_pos = _fob_pos vectorAdd ([_offset, -_fob_dir] call BIS_fnc_rotateVector2D);
private _desk = createVehicle ["MapBoard_seismic_F", ([] call F_getFreePos), [], 0, "CAN_COLLIDE"];
_desk allowDamage false;
_desk enableSimulationGlobal false;
_desk setDir _fob_dir;
_desk setPosATL _desk_pos;
_desk setVariable ["R3F_LOG_disabled", true, true];
_desk setVariable ["GRLIB_vehicle_owner", "server", true];
//_desk setObjectTextureGlobal [0, getMissionPath "res\splash_libe2.paa"];

private _lamp1 = objNull;
private _lamp2 = objNull;
if !(surfaceIsWater _fob_pos) then {
	private _lampPos = _fob_pos vectorAdd ([[-10, -7, 0], -_fob_dir] call BIS_fnc_rotateVector2D);
	_lamp1 = createVehicle ["Land_LampStreet_02_amplion_F", ([] call F_getFreePos), [], 0, "CAN_COLLIDE"];
	_lamp1 allowDamage false;
	_lamp1 setDir (_fob_dir + 45);
	_lamp1 setPosATL _lampPos;
	_lamp1 setVariable ["R3F_LOG_disabled", true, true];
	_lamp1 setVariable ["GRLIB_vehicle_owner", "server", true];

	private _lampPos = _fob_pos vectorAdd ([[10, 7, 0], -_fob_dir] call BIS_fnc_rotateVector2D);
	_lamp2 = createVehicle ["Land_LampStreet_02_triple_F", ([] call F_getFreePos), [], 0, "CAN_COLLIDE"];
	_lamp2 allowDamage false;
	_lamp2 setDir (_fob_dir + 45);
	_lamp2 setPosATL _lampPos;
	_lamp2 setVariable ["R3F_LOG_disabled", true, true];
	_lamp2 setVariable ["GRLIB_vehicle_owner", "server", true];
};

private _desk_dir = getDir _desk;
private _manPos = (getPosATL _desk) vectorAdd ([[0, -2, 0.2], -_desk_dir] call BIS_fnc_rotateVector2D);
private _man = GRLIB_FOB_Group createUnit [commander_classname, ([] call F_getFreePos), [], 0, "CAN_COLLIDE"];
[_man] joinSilent GRLIB_FOB_Group;
_man setVariable ["acex_headless_blacklist", true, true];
_man setVariable ["GRLIB_vehicle_owner", "server", true];
_man allowDamage false;
_man disableCollisionWith _desk;
_man setDir (_desk_dir + 180);
_man setPosATL _manPos;
doStop _man;
[_man, "AidlPercMstpSnonWnonDnon_AI"] spawn F_startAnimMP;

_fob setVariable ["GRLIB_FOB_Officer", _man];
_fob setVariable ["GRLIB_FOB_Objects", [_desk, _lamp1, _lamp2]];

publicVariable "GRLIB_FOB_Group";