// Setup Ammo Box

if (!isServer) exitWith {};
params ["_type", "_pos", "_locked"];

_pos set [2, 0.5];
private _box = createVehicle [_type, _pos, [], 15, "None"];
_box allowDamage false;
_box addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
_box setPos (getPos _box);
if (isNil "_locked") then { _locked = false};
if (_locked) then {
	_box setVariable ["R3F_LOG_disabled", true, true];
	_box setVariable ["GRLIB_vehicle_owner", "server", true];
	[_box] call F_aceLockVehicle;
} else {
	_box setVariable ["R3F_LOG_disabled", false, true];
	_box setVariable ["GRLIB_vehicle_owner", "", true];	
	[_box] call F_aceInitVehicle;
};

if (["A3_", GRLIB_mod_west, true] call F_startsWith && _type == basic_weapon_typename) then {
	private _box_refill = selectRandom ["mission_Ammo","mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers","mission_Ammo"];
	[_box, _box_refill] call fn_refillbox;
};

_box spawn { sleep 3; _this allowDamage true };
_box;
