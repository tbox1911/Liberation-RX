params ["_truck", "_object", ["_create", true]];

private _config = [];
private _maxload = 0;
{
	if (_x select 0 == typeof _truck) exitWith {
		_config = _x;
		_maxload = (count _x) - 2;
	};
} foreach (box_transport_config + box_transport_big_config);
if (_maxload == 0) exitWith { false };

private _truck_load = _truck getVariable ["GRLIB_ammo_truck_load", []];

if (count _truck_load < _maxload) then {
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

	_truck allowDamage false;
	_truck enableSimulationGlobal false;
	sleep 0.1;
	private _truck_offset = (_offsets select (count _truck_load)) vectorAdd _box_offset;
	if (_create) then {
		_object = createVehicle [_object_class, ([] call F_getFreePos), [], 0, "NONE"];
	};
	_object allowDamage false;
	[_object, _truck] remoteExec ["disableCollisionWith", 0];
	sleep 0.1;

	// Mobile respawn
	if (_object_class == mobile_respawn) then {
		if (isServer) then {
			[_object, "add"] call mobile_respawn_remote_call;
		} else {
			[_object, "add"] remoteExec ["mobile_respawn_remote_call", 2];
		};
	};

	// Owner
	private _truck_owner = _truck getVariable ["GRLIB_vehicle_owner", ""];
	if (!(_object_class in GRLIB_vehicle_blacklist) && !(_truck_owner in ["", "public", "server"])) then {
		_object setVariable ["GRLIB_vehicle_owner", _truck_owner, true];
	};

	// Storage
	if (typeOf _truck == storage_medium_typename) then {
		_object setVariable ["GRLIB_vehicle_owner", "", true];
	};

	// Clear Cargo
	if (!(_object_class in GRLIB_Ammobox_keep)) then {
		[_object] call F_clearCargo;
	};

	// MPKilled
	_object addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

	_object attachTo [_truck, _truck_offset];
	if (_object isKindOf "Cargo_base_F") then {
		_object setDir 90;
	};
	_object setVariable ["R3F_LOG_disabled", true, true];
	_truck_load pushback _object;
	_truck setVariable ["GRLIB_ammo_truck_load", _truck_load, true];
	sleep 0.1;
	_truck enableSimulationGlobal true;
	_truck allowDamage true;
};

true;