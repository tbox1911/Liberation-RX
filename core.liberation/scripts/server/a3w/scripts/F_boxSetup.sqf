// Setup Ammo Box

if (!isServer) exitWith {};
params ["_type", "_pos", "_locked"];
private _box_refill = ["mission_Ammo","mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers","mission_Ammo"];
private _box = createVehicle [_type, _pos, [], 5, "None"];
_box setDir random 360;
_box addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

if (isNil "_locked") then { _locked = false};

if (_locked) then {
	_box setVariable ["R3F_LOG_disabled", true, true];
	_box setVariable ["GRLIB_vehicle_owner", "server", true];
	//_box allowDamage false;
} else {
	_box setVariable ["R3F_LOG_disabled", false, true];
	//_box allowDamage true;
};

if (!GRLIB_OPTRE_enabled && _type == A3W_BoxWps) then {
	[_box, selectRandom _box_refill] call fn_refillbox;
};
_box;
