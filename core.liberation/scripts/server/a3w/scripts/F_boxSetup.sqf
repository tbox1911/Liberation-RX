// Setup Ammo Box

if (!isServer) exitWith {};
params ["_type", "_pos", "_locked"];

private _spawnpos = zeropos;
private _max_try = 10;
private _radius = 30;




while { (_spawnpos isEqualTo zeropos) && _max_try > 0 } do {
	_spawnpos = [_pos, 0, _radius, 3, 1, 0.25, 0, [], [zeropos, zeropos]] call BIS_fnc_findSafePos;
	_radius = _radius + 10;
	_max_try = _max_try - 1;
};
_spawnpos set [2, 0.5];
if ( _spawnpos distance2D zeropos < 300 ) exitWith { diag_log format ["--- LRX Error: No place to build %1 from position %2", _type, _pos]; objNull };

private _box = createVehicle [_type, _spawnpos, [], 5, "None"];
_box allowDamage false;
_box setDir random 360;
_box addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
sleep 1;
_box allowDamage true;

if (isNil "_locked") then { _locked = false};

if (_locked) then {
	_box setVariable ["R3F_LOG_disabled", true, true];
	_box setVariable ["GRLIB_vehicle_owner", "server", true];
} else {
	_box setVariable ["R3F_LOG_disabled", false, true];
	_box setVariable ["GRLIB_vehicle_owner", "", true];
};

//ACE
if (GRLIB_ace_enabled) then {
 if (_type in GRLIB_movableObjects) then {
	 	//Set the size of cargo
		if ( _type in (GRLIB_cargoSize select 0)) then {
			_cargoSize = ((GRLIB_cargoSize select 1) select ((GRLIB_cargoSize select 0) find _type));
			[_box, _cargoSize] call ace_cargo_fnc_setSize;
		};	
		// Set object movable with ACE. [_object, _enabled, [_offsetSide,_offsetForward,_offsetUp],_rotation] call ace_dragging_fnc_setCarryable;		
		[_box, true, [0, 3, 1], 0] call ace_dragging_fnc_setCarryable;
	};
};


if (!GRLIB_mod_enabled && _type == A3W_BoxWps) then {
	private _box_refill = selectRandom ["mission_Ammo","mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers","mission_Ammo"];
	[_box, _box_refill] call fn_refillbox;
};
_box;
