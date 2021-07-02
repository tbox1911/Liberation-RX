// Setup Ammo Box

if (!isServer) exitWith {};
params ["_type", "_pos", "_locked"];

private _max_try = 10;
private _radius = 100;
private _spawnpos = zeropos;
while { (_spawnpos isEqualTo zeropos) && _max_try > 0 } do {
	_spawnpos = _pos findEmptyPosition [ 5, _radius, "B_Heli_Transport_01_F" ];
	if ( count _spawnpos == 0 ) then { _spawnpos = zeropos; _radius = _radius + 20 };
	_max_try = _max_try - 1;
};
if ( _spawnpos distance zeropos < 100 ) exitWith { objNull };

private _box = createVehicle [_type, _spawnpos, [], 5, "None"];
_box setDir random 360;
_box addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

if (isNil "_locked") then { _locked = false};

if (_locked) then {
	_box setVariable ["R3F_LOG_disabled", true, true];
	_box setVariable ["GRLIB_vehicle_owner", "server", true];
	//_box allowDamage false;
} else {
	_box setVariable ["R3F_LOG_disabled", false, true];
	_box setVariable ["GRLIB_vehicle_owner", "", true];
	//_box allowDamage true;
};

if (!GRLIB_mod_enabled && _type == A3W_BoxWps) then {
	private _box_refill = selectRandom ["mission_Ammo","mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers","mission_Ammo"];
	[_box, _box_refill] call fn_refillbox;
};
_box;
