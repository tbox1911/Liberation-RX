params ["_vehicle", "_object", ["_create", true]];

private _config = [];
private _maxload = 0;
{
	if (_x select 0 == typeof _vehicle) exitWith {
		_config = _x;
		_maxload = (count _x) - 2;
	};
} foreach (box_transport_config + box_transport_big_config);
if (_maxload == 0) exitWith { objNull };

private _vehicle_load = _vehicle getVariable ["GRLIB_ammo_vehicle_load", []];
if (count _vehicle_load >= _maxload) exitWith { objNull };

private _offsets = [];
for "_i" from 2 to (2+_maxload) do { _offsets pushback (_config select _i) };

private _object_class = _object;
if (typeName _object == "OBJECT") then {
	_object_class = typeOf _object;
};

private _box_offset = [0, 0, 0];
{
	if (_object_class == (_x select 0)) exitWith { _box_offset = (_x select 1) };
} foreach (box_transport_offset + box_transport_big_offset);

_vehicle allowDamage false;

private _vehicle_offset = (_offsets select (count _vehicle_load)) vectorAdd _box_offset;
if (_create) then {
	_spawn_pos = [(markerPos "ghost_spot"), 5, 0] call F_findSafePlace;
	_object = createVehicle [_object_class, _spawn_pos, [], 0, "NONE"];
	if (_object isKindOf "LandVehicle") then { sleep 1.5 };
};
_object allowDamage false;
[_object, _vehicle] remoteExec ["disableCollisionWith", 0];

// Mobile respawn
if (_object_class == mobile_respawn) then {
	if (isServer) then {
		[_object, "add"] call mobile_respawn_remote_call;
	} else {
		[_object, "add"] remoteExec ["mobile_respawn_remote_call", 2];
	};
};

// Owner
private _vehicle_owner = _vehicle getVariable ["GRLIB_vehicle_owner", ""];
if (!(_object_class in GRLIB_vehicle_blacklist) && !(_vehicle_owner in ["", "public", "server"])) then {
	_object setVariable ["GRLIB_vehicle_owner", _vehicle_owner, true];
};

// Storage
if (typeOf _vehicle == storage_medium_typename) then {
	_object setVariable ["GRLIB_vehicle_owner", "", true];
};

// Clear Cargo
if (!(_object_class in GRLIB_Ammobox_keep)) then {
	[_object] call F_clearCargo;
};

// Static AI
if (_object_class in static_vehicles_AI) then {
	[_object] call F_forceCrew;
	_object setVariable ["GRLIB_vehicle_manned", true, true];
	_object setVehicleLock "LOCKED";
	_object allowCrewInImmobile [true, false];
	_object setUnloadInCombat [true, false];
	_object setAutonomous true;
};

// MPKilled
_object addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

_object attachTo [_vehicle, _vehicle_offset];
if (_object isKindOf "Cargo_base_F") then { _object setDir 270 };
_object setVariable ["R3F_LOG_disabled", true, true];
_vehicle_load pushback _object;
_vehicle setVariable ["GRLIB_ammo_vehicle_load", _vehicle_load, true];
sleep 0.1;
_vehicle allowDamage true;

_object;
