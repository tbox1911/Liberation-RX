// Automatic Parachute System for LRX

params ["_objet", "_heli"];
if (isNil "_objet") exitWith {};

waitUntil {sleep 0.2;(getposATL _objet select 2) < 150 || !(alive _objet)};
if (!alive _objet) exitWith {};

private _pos = getPosATL _objet;
private _chute = createVehicle ["B_Parachute_02_F", _pos, [], 0, "CAN_COLLIDE"];
_chute disableCollisionWith _objet;
_chute disableCollisionWith _heli;
_objet attachTo [_chute,[0,0,0.6]];

private _stop = time + 150;
waitUntil {sleep 0.2;((getposATL _objet select 2) < 7 || !(alive _objet) || time > _stop)};
detach _objet;
if (!alive _objet) exitWith {};

_objet allowDamage false;
_pos = getPosATL _objet;
"SmokeShellOrange" createVehicle _pos;
sleep 0.5;
"SmokeShellOrange" createVehicle _pos;
sleep 4;
_objet allowDamage true;
sleep 4;
deleteVehicle _chute;
// // force land
// _pos = getPosATL _objet;
// _pos set [2,0];
// _objet setPosATL _pos;