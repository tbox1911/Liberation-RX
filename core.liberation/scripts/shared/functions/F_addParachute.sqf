// Automatic Parachute System for LRX
params ["_objet", "_heli"];
if (isNil "_objet") exitWith {};

private ["_pos", "_parachute", "_smoke1", "_smoke2", "_timeout"];
private _shell_smoke = ["SmokeShell", "SmokeShellRed", "SmokeShellGreen", "SmokeShellYellow", "SmokeShellPurple", "SmokeShellBlue", "SmokeShellOrange"];
private _open_parachute = 120;
private _start_smoke = 100;

waitUntil {sleep 0.2;(getPosATL _objet select 2) < _open_parachute || !(alive _objet)};
if (!alive _objet) exitWith {};

_objet allowDamage false;
_pos = getPosATL _objet;
_parachute = createVehicle ["B_Parachute_02_F", _pos, [], 0, "CAN_COLLIDE"];
_parachute disableCollisionWith _objet;
_parachute disableCollisionWith _heli;
_objet attachTo [_parachute,[0,0,0.6]];

_timeout = time + 150;
waitUntil {sleep 0.2;((getPosATL _objet select 2) < _start_smoke || !(alive _objet) || time > _timeout)};
_smoke1 = (selectRandom _shell_smoke) createVehicle _pos;
_smoke1 attachTo [_objet,[0,0,0.6]];
_smoke2 = (selectRandom _shell_smoke) createVehicle _pos;
_smoke2 attachTo [_objet,[0,0,0.6]];

waitUntil {sleep 0.2;((getPosATL _objet select 2) < 7 || !(alive _objet) || time > _timeout)};
detach _objet;
detach _smoke1;
detach _smoke2;
sleep 4;
deleteVehicle _parachute;

if ((vectorUp _objet) select 2 < 0.70) then {
	_objet setpos [(getPosATL _objet) select 0,(getPosATL _objet) select 1, 0.5];
	_objet setVectorUp surfaceNormal position _objet;
};
sleep 3;
_objet allowDamage true;

if (underwater _objet) then {deleteVehicle _objet};
