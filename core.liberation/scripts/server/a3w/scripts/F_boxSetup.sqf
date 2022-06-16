// Setup Ammo Box

if (!isServer) exitWith {};
params ["_type", "_pos", "_locked"];

private _spawnpos = [];
private _radius = 50;
private _max_try = 10;

while { count _spawnpos == 0 && _max_try > 0 } do {
	_spawnpos = [2, _pos, _radius, 30, true] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol;
	_radius = _radius + 20;
	_max_try = _max_try -1;
	sleep 1;
};

if ( count _spawnpos == 0 ) exitWith { diag_log format ["--- LRX Error: No place to build box %1 at position %2", _type, _pos]; objNull };
_spawnpos set [2, 0.5];

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
if (GRLIB_ACE_enabled) then {
 if (_type in GRLIB_movableObjects) then {
	 	//Set the size of cargo
		if ( _type in (GRLIB_cargoSize select 0)) then {
			_cargoSize = ((GRLIB_cargoSize select 1) select ((GRLIB_cargoSize select 0) find _type));
			if (_cargoSize <= GRLIB_maxLiftWeight) then {
				[_box, true, [0, 3, 1], 0] call ace_dragging_fnc_setCarryable;
			};
			[_box, _cargoSize] call ace_cargo_fnc_setSize;
		};	
		// Set object movable with ACE. [_object, _enabled, [_offsetSide,_offsetForward,_offsetUp],_rotation] call ace_dragging_fnc_setCarryable;		
		[_box, true, [0, 3, 0], 0] call ace_dragging_fnc_setDraggable;
	};
};


if (["A3_", GRLIB_mod_west, true] call F_startsWith && _type == A3W_BoxWps) then {
	private _box_refill = selectRandom ["mission_Ammo","mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers","mission_Ammo"];
	[_box, _box_refill] call fn_refillbox;
};
_box;
