params [ "_vehicle", "_objects" ];

if (GRLIB_ACE_enabled) exitWith {};
private _vehicle_owner = _vehicle getVariable ["GRLIB_vehicle_owner", ""];
private _object_created = [];

{
	private _object = _x createVehicle zeropos;

	// Clear Cargo
	if (!(_x in GRLIB_Ammobox_keep)) then {
		clearWeaponCargoGlobal _object;
		clearMagazineCargoGlobal _object;
		clearItemCargoGlobal _object;
		clearBackpackCargoGlobal _object;
	};

	// Mobile respawn
	if (_x == mobile_respawn) then {
		[_object, "add"] remoteExec ["addel_beacon_remote_call", 2];
	};

	// MPKilled
	_object addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

	// Set Owner
	if (!(_x in GRLIB_vehicle_blacklist)) then {
		_object setVariable ["GRLIB_vehicle_owner", _vehicle_owner, true];
	};

	_object attachTo [R3F_LOG_PUBVAR_point_attache, [] call R3F_LOG_FNCT_3D_tirer_position_degagee_ciel];
	_object setVariable ["R3F_LOG_est_transporte_par", _vehicle, true];
	_object_created pushback _object;
} forEach _objects;

_vehicle setVariable ["R3F_LOG_objets_charges", _object_created, true];