params ["_object", "_vehicle"];

private _object_class = typeOf _object;

// Clear Cargo
if (!(_object_class in GRLIB_Ammobox_keep)) then {
    [_object] call F_clearCargo;
};

// Mobile respawn
if (_object_class == mobile_respawn) then {
    [_object, "add"] remoteExec ["addel_beacon_remote_call", 2];
};

// UAVs
if ([_object, uavs] call F_itemIsInClass) then {
    [_object] call F_forceCrew;
    _object setVariable ["GRLIB_vehicle_manned", true, true];
};

// MPKilled
_object addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

// Set Owner
if (!(_object_class in GRLIB_vehicle_blacklist)) then {
    private _vehicle_owner = _vehicle getVariable ["GRLIB_vehicle_owner", ""];
    _object setVariable ["GRLIB_vehicle_owner", _vehicle_owner, true];
};
