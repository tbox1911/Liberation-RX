params ["_vehicle", "_objects"];
if (count _objects == 0) exitWith {};

private _object_created = [];
private _object = objNull;

private _lock = locked _vehicle;
_vehicle lock 0;

if (GRLIB_ACE_enabled) then {
	{
		_object = createVehicle [_x, ([] call F_getFreePos), [], 0, "NONE"];
		[_object] call F_aceInitVehicle;
		[_object, _vehicle] call init_object_direct;
		[_object, _vehicle, true] call ace_cargo_fnc_loadItem;
	} forEach _objects;
} else {
	[_vehicle, _objects] call R3F_transporteur_charger_auto;
};

_vehicle lock _lock;
