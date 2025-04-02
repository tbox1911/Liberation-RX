params ["_vehicle", "_objects"];
if (count _objects == 0) exitWith {};

private _object_created = [];
private _object = objNull;

private _lock = locked _vehicle;
_vehicle lock 0;

{
	_object = createVehicle [_x, ([] call F_getFreePos), [], 0, "NONE"];
	_object addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	if (GRLIB_ACE_enabled) then {
		[_object] call F_aceInitVehicle;
		[_object, _vehicle, true] call ace_cargo_fnc_loadItem;
	} else {
		_object attachTo [R3F_LOG_PUBVAR_point_attache, ([] call F_getFreePos)];
		_object setVariable ["R3F_LOG_est_transporte_par", _vehicle, true];
	};
	[_object, _vehicle] call init_object_direct;
	_object_created pushback _object;
} forEach _objects;

_vehicle setVariable ["R3F_LOG_objets_charges", _object_created, true];
_vehicle lock _lock;
//diag_log (_vehicle getVariable ["ace_cargo_loaded", []]);