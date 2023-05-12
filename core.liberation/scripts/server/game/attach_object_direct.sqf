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

if ( count _truck_load < _maxload ) then {
	_truck_to_load = _truck;
	_truck_offset = (_offsets select (count _truck_load)) vectorAdd _box_offset;
	private _object = _object_type createVehicle zeropos;

	// Clear Cargo
	if (!(_object_type in GRLIB_Ammobox_keep)) then {
		clearWeaponCargoGlobal _object;
		clearMagazineCargoGlobal _object;
		clearItemCargoGlobal _object;
		clearBackpackCargoGlobal _object;
	};

	// MPKilled
	_object addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	_object attachTo [ _truck_to_load, _truck_offset ];
	_object setVariable ["R3F_LOG_disabled", true, true];
	_object allowDamage false;
	_truck_load pushback _object;
	_truck_to_load setVariable ["GRLIB_ammo_truck_load", _truck_load, true];
};
