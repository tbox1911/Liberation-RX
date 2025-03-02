params ["_target", "_caller", "_actionId", "_arguments"];
if (isNil "_target") exitWith {};

//only one player at time
if ((_target getVariable ["loot_in_use", false])) exitWith {};
_target setVariable ["loot_in_use", true, true];

private _load_target = loadAbs _target;
private _nearest_cargo = vehicles select {
	alive _x && _x isKindOf "AllVehicles" &&
	_x distance2D _caller <= 30 && locked _x < 2 && 
	!(_x getVariable ['R3F_LOG_disabled', false]) &&
	[_caller, _x] call is_owner &&
	(maxLoad _x - loadAbs _x) > _load_target
};

if (count _nearest_cargo > 0) then {
	private _cargo_veh = _nearest_cargo select 0;
	{ 
		{_cargo_veh addWeaponWithAttachmentsCargoGlobal [_x, 1]} forEach (weaponsItems _x);
		deleteVehicle _x;
		sleep 0.1;
	} forEach (nearestObjects [_target, ["GroundWeaponHolder", "WeaponHolderSimulated"], 4]);
	[_cargo_veh, _target] call save_loadout_cargo;
	hidebody _target;
	sleep 5;
	deleteVehicle _target;
} else {
	private _msg = localize "STR_LOADOUT_NOCARGO";
	hintSilent _msg;
	systemchat _msg;
};

_target setVariable ["loot_in_use", false, true];
