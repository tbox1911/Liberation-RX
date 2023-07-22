params ["_target", "_caller", "_actionId", "_arguments"];

private _load_target = loadAbs _target;
private _nearset_cargo = vehicles select {
	alive _x && _x isKindOf "AllVehicles" &&
	_x distance2D _caller <= 20 && locked _x < 2 && 
	!(_x getVariable ['R3F_LOG_disabled', false]) &&
	[_caller, _x] call is_owner &&
	(maxLoad _x - loadAbs _x) > _load_target
};

if (count _nearset_cargo > 0) then {
	private _cargo_veh = _nearset_cargo select 0;
	[_cargo_veh, _target] call save_loadout_cargo;
	private _weapons_lst = nearestObjects [_target, ["GroundWeaponHolder", "WeaponHolderSimulated"], 3];
	{ 
		{ _cargo_veh addItemCargoGlobal [_x, 1] } forEach (getWeaponCargo _x select 0); 
		deleteVehicle _x;
	} forEach _weapons_lst;
} else {
	private _msg = localize "STR_LOADOUT_NOCARGO";
	hintSilent _msg;
	systemchat _msg;
};
