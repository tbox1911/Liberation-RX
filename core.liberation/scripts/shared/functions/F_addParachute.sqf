// Automatic Parachute System for LRX

params ["_vehicle", ["_source", objNull], ["_info", true]];
if (isNil "_vehicle") exitWith {};

private _shell_smoke_code = ["Withe", "Red", "Green", "Yellow", "Purple", "Blue", "Orange"];
private _shell_smoke = ["SmokeShell", "SmokeShellRed", "SmokeShellGreen", "SmokeShellYellow", "SmokeShellPurple", "SmokeShellBlue", "SmokeShellOrange"];
private _open_parachute = 240;
private _start_smoke = 80;
private _one = floor (random (count _shell_smoke_code));
private _two = floor (random (count _shell_smoke_code));

if (_info) then {
	private _text = format ["Air Drop %1 - Code %2 on %3", ([typeOf _vehicle] call F_getLRXName), (_shell_smoke_code select _one), (_shell_smoke_code select _two)];
	[gamelogic, _text] remoteExec ["globalChat", 0];
};

_vehicle allowDamage false;

private	_lst_grl = [];
private ["_object", "_offset"];
{
	_object = _x;
	_offset = _vehicle worldToModel (_object modelToWorld [0,0,0]);
	_offset = [
		round ((_offset select 0) * 100) / 100,
		round ((_offset select 1) * 100) / 100,
		round ((_offset select 2) * 100) / 100
	];
	_lst_grl pushBack [_object, _offset];
} forEach (_vehicle getVariable ["GRLIB_ammo_truck_load", []]);

waitUntil {sleep 0.1; (getPos _vehicle select 2) <= _open_parachute};
{
	_object = _x select 0;
	detach _object;
	_object hideObjectGlobal true;
} forEach _lst_grl;
sleep 0.5;

private _pos = getPos _vehicle;
private _parachute = createVehicle ["B_Parachute_02_F", _pos, [], 0, "NONE"];
_parachute disableCollisionWith _vehicle;
_parachute disableCollisionWith _source;
_parachute setVelocity (velocity _vehicle);
_vehicle attachTo [_parachute, [0,0,0.6]];

sleep 2;
{
	_object = _x select 0;
	_offset = _x select 1;
	_object attachTo [_vehicle, _offset];
	_object hideObjectGlobal false;
} forEach _lst_grl;

private _timeout = time + 150;
waitUntil {sleep 0.1;((getPos _vehicle select 2) < _start_smoke || time > _timeout)};
private _smoke1 = (_shell_smoke select _one) createVehicle _pos;
_smoke1 attachTo [_vehicle, [0,0,0.6]];
private _smoke2 = (_shell_smoke select _two) createVehicle _pos;
_smoke2 attachTo [_vehicle, [0,0,0.6]];

waitUntil {sleep 0.1; ((getPos _vehicle select 2) < 7 || time > _timeout)};
detach _smoke1;
detach _smoke2;
detach _vehicle;
sleep 3;
deleteVehicle _parachute;
sleep 1;
[_vehicle] call F_vehicleUnflip;
sleep 3;
_vehicle allowDamage true;

sleep 20;
if (underwater _vehicle && !(_vehicle isKindOf "Ship")) then {
	[_vehicle, true, true] call F_vehicleClean;
};
