params ["_fob"];

if (isNil "GRLIB_FOB_Group") then {
	GRLIB_FOB_Group = createGroup [GRLIB_side_civilian, true];
};
if (isNull GRLIB_FOB_Group) then {
	GRLIB_FOB_Group = createGroup [GRLIB_side_civilian, true];
};

private _fobdir = getDir _fob; 
private _deskPos = (getPosATL _fob) vectorAdd ([[1, 2, 0.6], -_fobdir] call BIS_fnc_rotateVector2D); 
private _desk = "MapBoard_seismic_F" createVehicle zeropos; 
_desk allowDamage false; 
_desk setDir (_fobdir + 55);
_desk setPosATL _deskPos; 
_desk enableSimulationGlobal false; 
_desk setVariable ["R3F_LOG_disabled", true, true];
_desk setVariable ["GRLIB_vehicle_owner", "server", true];
//_desk setObjectTextureGlobal [0, getMissionPath "res\splash_libe2.paa"];

private _lampPos = (getPosATL _fob) vectorAdd ([[-10, -7, 0], -_fobdir] call BIS_fnc_rotateVector2D); 
private _lamp1 = "Land_LampStreet_02_amplion_F" createVehicle zeropos;
_lamp1 allowDamage false; 
_lamp1 setDir (_fobdir + 45);
_lamp1 setPosATL _lampPos; 
_lamp1 setVariable ["R3F_LOG_disabled", true, true];
_lamp1 setVariable ["GRLIB_vehicle_owner", "server", true];

private _lampPos = (getPosATL _fob) vectorAdd ([[10, 7, 0], -_fobdir] call BIS_fnc_rotateVector2D); 
private _lamp2 = "Land_LampStreet_02_triple_F" createVehicle zeropos;
_lamp2 allowDamage false; 
_lamp2 setDir (_fobdir + 45);
_lamp2 setPosATL _lampPos; 
_lamp2 setVariable ["R3F_LOG_disabled", true, true];
_lamp2 setVariable ["GRLIB_vehicle_owner", "server", true];

private _manPos = (getposATL _fob) vectorAdd ([[1, 0, 1], -_fobdir] call BIS_fnc_rotateVector2D);  
private _man = GRLIB_FOB_Group createUnit [commander_classname, zeropos, [], 0, "NONE"];  
[_man] joinSilent GRLIB_FOB_Group;  
_man setVariable ["acex_headless_blacklist", true, true];
_man setVariable ["GRLIB_vehicle_owner", "server", true];
_man allowDamage false; 
_man disableCollisionWith _desk;  
_man setDir (_fobdir - 90);  
_man setPosATL _manPos;  
doStop _man;  
[_man, "AidlPercMstpSnonWnonDnon_AI"] spawn F_startAnimMP;

_fob setVariable ["GRLIB_FOB_Officer", _man];
_fob setVariable ["GRLIB_FOB_Objects", [_desk, _lamp1, _lamp2]];

publicVariable "GRLIB_FOB_Group";