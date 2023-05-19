// Automatic Parachute System for LRX
params ["_vehicle", "_heli"];
if (isNil "_vehicle") exitWith {};

private _shell_smoke = ["SmokeShell", "SmokeShellRed", "SmokeShellGreen", "SmokeShellYellow", "SmokeShellPurple", "SmokeShellBlue", "SmokeShellOrange"];
private _open_parachute = 150;
private _start_smoke = 120;

waitUntil {sleep 0.2;(getPosATL _vehicle select 2) < _open_parachute || !(alive _vehicle)};
if (!alive _vehicle) exitWith {};

_vehicle allowDamage false;
private _pos = getPosATL _vehicle;
private _parachute = createVehicle ["B_Parachute_02_F", _pos, [], 0, "CAN_COLLIDE"];
_parachute disableCollisionWith _vehicle;
_parachute disableCollisionWith _heli;
_parachute setvelocity (velocity _vehicle);
_vehicle attachTo [_parachute,[0,0,0.6]];

private _timeout = time + 150;
waitUntil {sleep 0.2;((getPosATL _vehicle select 2) < _start_smoke || !(alive _vehicle) || time > _timeout)};
private _smoke1 = (selectRandom _shell_smoke) createVehicle _pos;
_smoke1 attachTo [_vehicle,[0,0,0.6]];
private _smoke2 = (selectRandom _shell_smoke) createVehicle _pos;
_smoke2 attachTo [_vehicle,[0,0,0.6]];

waitUntil {sleep 0.2;((getPosATL _vehicle select 2) < 7 || !(alive _vehicle) || time > _timeout)};
detach _vehicle;
detach _smoke1;
detach _smoke2;
sleep 4;
deleteVehicle _parachute;

if ((vectorUp _vehicle) select 2 < 0.70) then {
	_vehicle setpos [(getPosATL _vehicle) select 0,(getPosATL _vehicle) select 1, 0.5];
	_vehicle setVectorUp surfaceNormal position _vehicle;
};
sleep 3;
_vehicle allowDamage true;

if (underwater _vehicle) then {deleteVehicle _vehicle};
