params ["_fob"];

if (isNil "GRLIB_FOB_Group") then {
	GRLIB_FOB_Group = createGroup [GRLIB_side_civilian, true];
};
if (isNull GRLIB_FOB_Group) then {
	GRLIB_FOB_Group = createGroup [GRLIB_side_civilian, true];
};

private _fobdir = getDir _fob; 
private _deskPos = (getPosATL _fob) vectorAdd ([[1, 2, 0.5], -_fobdir] call BIS_fnc_rotateVector2D); 
private _desk = "MapBoard_seismic_F" createVehicle zeropos; 
_desk allowDamage false; 
_desk setDir (_fobdir + 55);
_desk setPosATL _deskPos; 
_desk enableSimulationGlobal false; 
_desk setVariable ["R3F_LOG_disabled", true, true];
//_desk setObjectTextureGlobal [0, getMissionPath "res\splash_libe2.paa"];

private _manPos = (getposATL _fob) vectorAdd ([[1, 0, 1], -_fobdir] call BIS_fnc_rotateVector2D);  
private _man = GRLIB_FOB_Group createUnit [commander_classname, zeropos, [], 0, "NONE"];  
[_man] joinSilent GRLIB_FOB_Group;  
_man setVariable ["acex_headless_blacklist", true];
_man allowDamage false; 
_man disableCollisionWith _desk;  
_man setDir (_fobdir - 90);  
_man setPosATL _manPos;  
doStop _man;  
[_man, "AidlPercMstpSnonWnonDnon_AI"] spawn F_startAnimMP;

_fob setVariable ["GRLIB_FOB_Officer", _man];
_fob setVariable ["GRLIB_FOB_Mapboard", _desk];

publicVariable "GRLIB_FOB_Group";