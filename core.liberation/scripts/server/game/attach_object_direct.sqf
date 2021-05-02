params [ "_truck", "_object_type" ];

private _maxload = 0;
private _offsets = [];
{
	if ( _x select 0 == typeof _truck ) then {
		_maxload = (count _x) - 2;
		for [ {_i=2}, {_i < (count _x) }, {_i=_i+1} ] do { _offsets pushback (_x select _i); };
	};
} foreach box_transport_config;

private _truck_load = _truck getVariable ["GRLIB_ammo_truck_load", 0];

if (  _truck_load < _maxload ) then {
	_truck_to_load = _truck;
	_truck_offset = _offsets select _truck_load;
	private _object = _object_type createVehicle zeropos;

	// Clear Cargo
	clearWeaponCargoGlobal _object;
	clearMagazineCargoGlobal _object;
	clearItemCargoGlobal _object;
	clearBackpackCargoGlobal _object;

	// MPKilled
	_object addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

	if (typeOf _object in [waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename]) then {
		_truck_offset = _truck_offset vectorAdd [0, 0, -0.4];
	};
	_object attachTo [ _truck_to_load, _truck_offset ];
	_object setVariable ["R3F_LOG_disabled", true, true];
	_object allowDamage false;
	_truck_to_load setVariable ["GRLIB_ammo_truck_load", _truck_load + 1, true];
};
