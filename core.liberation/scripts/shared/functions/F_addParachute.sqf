// Automatic Parachute System for LRX
private _shellSmoke = ["SmokeShell", "SmokeShellRed", "SmokeShellGreen", "SmokeShellYellow", "SmokeShellPurple", "SmokeShellBlue", "SmokeShellOrange"];
params ["_objet", "_heli"];
if (isNil "_objet") exitWith {};

waitUntil {sleep 0.2;(getPos _objet select 2) < 120 || !(alive _objet)};
if (!alive _objet) exitWith {};

private _pos = getPos _objet;
private _chute = createVehicle ["B_Parachute_02_F", _pos, [], 0, "CAN_COLLIDE"];
_chute disableCollisionWith _objet;
_chute disableCollisionWith _heli;
_objet attachTo [_chute,[0,0,0.6]];

private _stop = time + 150;
waitUntil {sleep 0.2;((getPos _objet select 2) < 100 || !(alive _objet) || time > _stop)};
private _smoke1 = (selectRandom _shellSmoke) createVehicle _pos;
_smoke1 attachTo [_objet,[0,0,0.6]];
sleep 3;
private _smoke2 = (selectRandom _shellSmoke) createVehicle _pos;
_smoke2 attachTo [_objet,[0,0,0.6]];

_objet allowDamage false;
waitUntil {sleep 0.2;((getPos _objet select 2) < 7 || !(alive _objet) || time > _stop)};
detach _objet;
detach _smoke1;
detach _smoke2;
sleep 4;
if ((vectorUp _objet) select 2 < 0.70 || (getPos _objet) select 2 < 0) then {
	_objet setpos [(getPos _objet) select 0,(getPos _objet) select 1, 0.5];
	_objet setVectorUp surfaceNormal position _objet;
	sleep 3;
};
_objet allowDamage true;
sleep 3;
deleteVehicle _chute;
if (underwater _objet) then {deleteVehicle _objet};