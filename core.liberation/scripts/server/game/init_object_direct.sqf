params ["_object", "_vehicle"];

private _object_class = typeOf _object;

// Clear Cargo
if (!(_object_class in GRLIB_Ammobox_keep)) then {
	[_object] call F_clearCargo;
};

// Mobile respawn
if (_object_class == mobile_respawn) then {
	GRLIB_mobile_respawn pushback _object;
	publicVariable "GRLIB_mobile_respawn";
};

// UAVs
if (_object_class in uavs_vehicles) then {
	[_object] call F_forceCrew;
	_object setVariable ["GRLIB_vehicle_manned", true, true];
};

// MPKilled
_object addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

// Static Weapons
if (_object_class in list_static_weapons ) then {
	_object addEventHandler ["HandleDamage", { _this call damage_manager_static }];
};

// Set Owner
if (!(_object_class in GRLIB_vehicle_blacklist)) then {
	private _vehicle_owner = _vehicle getVariable ["GRLIB_vehicle_owner", ""];
	_object setVariable ["GRLIB_vehicle_owner", _vehicle_owner, true];
};
