params ["_vehicle", "_object", ["_create", true]];

private _object_class = _object;
if (typeName _object == "OBJECT") then {
	_object_class = typeOf _object;
};

private _transport_vehicles = box_transport_config;
if (_object_class in box_transport_big_loadable) then {
	_transport_vehicles = box_transport_big_config;
};

private _config = [];
private _maxload = 0;
{
	if (_x select 0 == typeof _vehicle) exitWith {
		_config = _x;
		_maxload = (count _x) - 2;
	};
} foreach _transport_vehicles;
if (_maxload == 0) exitWith { objNull };

private _vehicle_load = _vehicle getVariable ["GRLIB_ammo_vehicle_load", []];
if (count _vehicle_load >= _maxload) exitWith { objNull };

private _offsets = [];
for "_i" from 2 to (2+_maxload) do { _offsets pushback (_config select _i) };

private _box_offset = [0, 0, 0];
{
	if (_object_class == (_x select 0)) exitWith { _box_offset = (_x select 1) };
} foreach (box_transport_offset + box_transport_big_offset);

_vehicle allowDamage false;

private _vehicle_offset = (_offsets select (count _vehicle_load)) vectorAdd _box_offset;
if (_create) then {
	_spawn_pos = [(markerPos "ghost_spot"), 5, 0] call F_findSafePlace;
	_object = createVehicle [_object_class, _spawn_pos, [], 0, "NONE"];
	if (GRLIB_ACE_enabled) then {
		[_object] call F_aceInitVehicle;
		[_object, _vehicle, true] call ace_cargo_fnc_loadItem;
	};
	[_object, _vehicle] call init_object_direct;
	if (_object isKindOf "LandVehicle") then { sleep 1.5 };
};
_object allowDamage false;
[_object, _vehicle] remoteExec ["disableCollisionWith", 0];

_object attachTo [_vehicle, _vehicle_offset];
if (_object isKindOf "Cargo_base_F") then {
	[_object, 270] remoteExec ["setDir", 0];
};
_object setVariable ["R3F_LOG_disabled", true, true];
_vehicle_load pushback _object;
_vehicle setVariable ["GRLIB_ammo_vehicle_load", _vehicle_load, true];
sleep 0.1;
_vehicle allowDamage true;

_object;
