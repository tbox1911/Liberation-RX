params [ "_truck", "_object_type" ];

private _maxload = 0;
private _offsets = [];
{
	if ( _x select 0 == typeof _truck ) then {
		_maxload = (count _x) - 2;
		for "_i" from 2 to (count _x) do { _offsets pushback (_x select _i) };
	};
} foreach box_transport_config;

private _box_offset = { if (_object_type == (_x select 0)) exitWith {_x select 1} } foreach box_transport_offset;
if (isNil "_box_offset") then {_box_offset = [0, 0, 0]};

private _truck_load = _truck getVariable ["GRLIB_ammo_truck_load", []];
private _truck_owner = _truck getVariable ["GRLIB_vehicle_owner", ""];

if ( count _truck_load < _maxload ) then {
	private _truck_offset = (_offsets select (count _truck_load)) vectorAdd _box_offset;
	private _object = createVehicle [_object_type, ([] call F_getFreePos), [], 0, "NONE"];

	// Mobile respawn
	if (_object_type == mobile_respawn) then {
		[_object, "add"] remoteExec ["addel_beacon_remote_call", 2];
	};

	// Owner
	if (!((typeOf _object) in GRLIB_vehicle_blacklist)) then {
		_object setVariable ["GRLIB_vehicle_owner", _truck_owner, true];
	};

	// Clear Cargo
	if (!(_object_type in GRLIB_Ammobox_keep)) then {
		[_object] call F_clearCargo;
	};

	// MPKilled
	_object addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

	_object attachTo [ _truck, _truck_offset ];
	_object setVariable ["R3F_LOG_disabled", true, true];
	_object allowDamage false;
	_truck_load pushback _object;
	_truck setVariable ["GRLIB_ammo_truck_load", _truck_load, true];
};
