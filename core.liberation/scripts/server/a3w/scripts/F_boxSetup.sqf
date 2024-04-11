// Setup Ammo Box

if (!isServer) exitWith {};
params ["_type", "_pos", "_locked"];

private _spawnpos = [_pos, 3, 1] call F_findSafePlace;
if ( count _spawnpos == 0 ) exitWith { diag_log format ["--- LRX Error: No place to build box %1 at position %2", _type, _pos]; objNull };
_spawnpos set [2, 0.5];

private _box = createVehicle [_type, _spawnpos, [], 5, "None"];
_box allowDamage false;
_box addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

if (isNil "_locked") then { _locked = false};
if (_locked) then {
	[_box, "lock", "server"] call F_vehicleLock;
	[_box] call F_aceLockVehicle;
} else {
	[_box, "abandon"] call F_vehicleLock;
	[_box] call F_aceInitVehicle;
};

if (["A3_", GRLIB_mod_west, true] call F_startsWith && _type == basic_weapon_typename) then {
	private _box_refill = selectRandom ["mission_Ammo","mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers","mission_Ammo"];
	[_box, _box_refill] call fn_refillbox;
};

_box spawn { sleep 3; _this allowDamage true };
_box;
