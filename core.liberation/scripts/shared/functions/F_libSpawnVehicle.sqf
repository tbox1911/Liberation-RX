params [
	"_sectorpos",
	"_classname",
	["_size", 3],
	["_random_rotate", false],
	["_side", GRLIB_side_enemy],
	["_crewed", true]
];

if (isNil "_sectorpos" || isNil "_classname") exitWith {objNull};

private _vehicle = objNull;
private _spawnpos = [];
private _airveh_alt = 300;

if ( _classname isKindOf "Air" ) then {
	private _spawn_sectors = ([sectors_airspawn, [_sectorpos], { (markerpos _x) distance2D _input0 }, "ASCEND"] call BIS_fnc_sortBy);
	{
		_spawnpos = markerPos _x;
		if (_spawnpos distance2D _sectorpos > GRLIB_spawn_min) exitWith {};
	} foreach _spawn_sectors;

	if ( _side == GRLIB_side_civilian ) then { _airveh_alt = 150 };
	_spawnpos = _spawnpos getPos [(floor random 300), random 360];
	_spawnpos set [2, (_airveh_alt + ([[-50,0,180], 0] call F_getRND))];
	_vehicle = createVehicle [_classname, _spawnpos, [], 50, "FLY"];
	_vehicle allowDamage false;
	_vehicle setDir (_vehicle getDir _sectorpos);
	_vehicle setPos _spawnpos;
	_vehicle setVelocityModelSpace [0, 80, 0];
} else {
	if ( _size == 0 ) then {
		_spawnpos = _sectorpos;
	} else {
		_spawnpos = [_sectorpos, _size, 1] call F_findSafePlace;
	};

	if ( count _spawnpos == 0 ) exitWith {
		diag_log format ["--- LRX Error: Cannot find place to build vehicle %1 at position %2", _classname, _sectorpos];
		objNull;
	};

	if (_classname isKindOf "LandVehicle") then {
		_spawnpos set [2, 0.5];
		if (surfaceIsWater _spawnpos && !(_classname isKindOf "Ship")) then {
			_classname = "";
			if (count opfor_boats >= 1 && _side == GRLIB_side_enemy) then {
				_classname = selectRandom opfor_boats;
			};
			if (count boats_west >= 1 && _side == GRLIB_side_friendly) then {
				_classname = selectRandom boats_west;
			};
			if (count civilian_boats >= 1 && _side == GRLIB_side_civilian) then {
				_classname = selectRandom civilian_boats;
			};
		};
	};

	if (_classname != "") then {
		_vehicle = createVehicle [_classname, zeropos, [], 0, "NONE"];
		_vehicle allowDamage false;
		_vehicle setPos _spawnpos;
	};
};
sleep 1;

if ( isNull _vehicle ) exitWith {
	diag_log format ["--- LRX Error: Cannot build vehicle (%1) at position %2", _classname, _sectorpos];
	objNull;
};

if (_side != GRLIB_side_civilian) then {
	diag_log format [ "Spawn Vehicle %1 Pos %2 at %3", _classname, getPosATL _vehicle, time ];
};

[_vehicle] call F_fixModVehicle;
if (GRLIB_ACE_enabled) then { [_vehicle] call F_aceInitVehicle };

if ( _vehicle isKindOf "Air" ) then {
	if (GRLIB_SOG_enabled) then { _airveh_alt = 50 };
	_vehicle engineOn true;
	_vehicle flyInHeight _airveh_alt;
	_vehicle flyInHeightASL [_airveh_alt, 100, 300];
};

if ( _random_rotate ) then {
	_vehicle setdir (random 360);
};

if ( _side == GRLIB_side_civilian ) then {
	_vehicle addEventHandler ["Fuel", {
		params ["_vehicle", "_hasFuel"];
		if (_vehicle getVariable ["GRLIB_civ_incd", 0] > 0) exitWith {};
		if (count (crew _vehicle) == 0) exitWith {};
		if (!_hasFuel) then { _vehicle setFuel 1 };
	}];
	_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_civilian }];
	[_vehicle, "lock", "public"] call F_vehicleLock;
};

if ( _side == GRLIB_side_friendly ) then {
	_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];

	// LRX textures
	if (count blufor_texture_overide > 0) then {
		_texture_name = selectRandom blufor_texture_overide;
		[_vehicle, _texture_name] spawn RPT_fnc_TextureVehicle;
	};
};

if ( _side == GRLIB_side_enemy ) then {
	_vehicle addEventHandler ["Fuel", {
		params ["_vehicle", "_hasFuel"];
		if (count (crew _vehicle) == 0) exitWith {};
		if (!_hasFuel) then { _vehicle setFuel 1 };
	}];	
	_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];

	// LRX textures
	if (count opfor_texture_overide > 0) then {
		_texture_name = selectRandom opfor_texture_overide;
		[_vehicle, _texture_name] spawn RPT_fnc_TextureVehicle;
	};

	// A3 textures
	if ( _classname in ["I_E_Truck_02_MRL_F"] ) then {
		[_vehicle, ["Opfor",1], true ] spawn BIS_fnc_initVehicle;
	};

	// Lock vehicles
	if !(GRLIB_permission_enemy) then {
		[_vehicle, "lock", "server"] call F_vehicleLock;
	};
};

if ( _vehicle isKindOf "LandVehicle" ) then { [_vehicle] call F_vehicleUnflip };
sleep 2;
_vehicle setDamage 0;
_vehicle allowDamage true;
_vehicle addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
_vehicle allowCrewInImmobile [true, false];
_vehicle setUnloadInCombat [true, false];

[_vehicle] call F_clearCargo;
if (_crewed) then {	[_vehicle, _side] call F_forceCrew };

if (_side != GRLIB_side_civilian) then {
	diag_log format [ "Done Spawning Vehicle %1 at %2", _classname , time ];
};

_vehicle;
