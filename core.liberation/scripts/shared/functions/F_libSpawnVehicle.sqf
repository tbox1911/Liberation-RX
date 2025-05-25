params [
	"_sectorpos",
	"_classname",
	["_size", 5],
	["_random_rotate", false],
	["_side", GRLIB_side_enemy],
	["_crewed", true],
	["_mission_ai", false]
];

if (isNil "_sectorpos" || isNil "_classname") exitWith { objNull };

private _vehicle = objNull;
private _spawn_pos = [];
private _airveh_alt = 300;

if (_classname isKindOf "Air") then {
	_spawn_pos = [_sectorpos] call F_getAirSpawn;
	if (count _spawn_pos > 0) then {
		if (_classname isKindOf "Plane") then { _airveh_alt = 500 };
		if (GRLIB_SOG_enabled || GRLIB_SPE_enabled) then { _airveh_alt = 350 };
		if (_side == GRLIB_side_civilian) then { _airveh_alt = 150 };
		_spawn_pos = _spawn_pos getPos [floor random 300, floor random 360];
		_spawn_pos set [2, _airveh_alt];
		_vehicle = createVehicle [_classname, _spawn_pos, [], 50, "FLY"];
		_vehicle allowDamage false;
		_vehicle setDir (_vehicle getDir _sectorpos);
		_vehicle setPosATL _spawn_pos;
		_vehicle setVelocityModelSpace [0, 80, 0];
	};
} else {
	if (_size == 0) then {
		_spawn_pos = _sectorpos;
	} else {
		_spawn_pos = [_sectorpos, _size] call F_findSafePlace;
	};

	if (count _spawn_pos == 0) exitWith {
		diag_log format ["--- LRX Error: Cannot find place to build vehicle %1 at position %2", _classname, _sectorpos];
		objNull;
	};

	private _sea_deep = (ATLtoASL (_spawn_pos) select 2);
	if (_classname isKindOf "LandVehicle") then {
		if (_sea_deep < -1.5) then {
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
			if (_classname == "") then {
				diag_log format ["--- LRX Error: Cannot find Boats classname in template %1", _side];
			};
		};
	};

	if (_classname isKindOf "Ship_F") then {
		if (_sea_deep >= -2) then {
			diag_log format ["--- LRX Error: No enough depth (%1) to build boat %2", _sea_deep, _classname];
			_classname = "";
		};
	};

	if (_classname != "") then {
		_vehicle = createVehicle [_classname, zeropos, [], 0, "NONE"];
		_vehicle allowDamage false;
		_spawn_pos set [2, 0.5];
		if (surfaceIsWater _spawn_pos) then {
			_vehicle setPosASL _spawn_pos;
		} else {
			_vehicle setPosATL _spawn_pos;
		};
	};
};

_vehicle setVariable ["GRLIB_vehicle_init", true, true];
if (_mission_ai) then { _vehicle setVariable ["GRLIB_mission_AI", true, true] };

if (_classname == "") exitWith { objNull };
if (isNull _vehicle) exitWith {
	diag_log format ["--- LRX Error: Cannot build vehicle (%1) at position %2", _classname, _sectorpos];
	objNull;
};

if (_side != GRLIB_side_civilian) then {
	diag_log format [ "Spawn Vehicle %1 Pos %2 at %3", _classname, getPosATL _vehicle, time ];
};

if (_crewed) then {	[_vehicle, _side, _mission_ai] call F_forceCrew };
_vehicle addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
[_vehicle] call F_clearCargo;
[_vehicle] call F_fixModVehicle;
[_vehicle] call F_vehicleDefense;
if (GRLIB_ACE_enabled) then { [_vehicle] call F_aceInitVehicle };

if (_vehicle isKindOf "Air") then {
	_vehicle engineOn true;
	_vehicle flyInHeight _airveh_alt;
	_vehicle flyInHeightASL [_airveh_alt, _airveh_alt, _airveh_alt];
};

if (_random_rotate) then {
	_vehicle setdir (random 360);
};

if (_side == GRLIB_side_civilian) then {
	_vehicle addEventHandler ["Fuel", {
		params ["_vehicle", "_hasFuel"];
		if (_vehicle getVariable ["GRLIB_civ_incd", 0] > 0) exitWith {};
		if (count (crew _vehicle) == 0) exitWith {};
		if (!_hasFuel) then { _vehicle setFuel 1 };
	}];
	_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_civilian }];
	_vehicle setVariable ["GRLIB_vehicle_owner", "public", true];
};

if (_side == GRLIB_side_friendly) then {
	_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];

	// LRX textures
	if (count blufor_texture_overide > 0) then {
		_texture_name = selectRandom blufor_texture_overide;
		[_vehicle, _texture_name] spawn RPT_fnc_TextureVehicle;
	};
};

if (_side == GRLIB_side_enemy) then {
	_vehicle addEventHandler ["Fuel", {
		params ["_vehicle", "_hasFuel"];
		if (count (crew _vehicle) == 0) exitWith {};
		if (!_hasFuel) then { _vehicle setFuel 1 };
	}];
	_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
	_vehicle setVariable ["GRLIB_vehicle_reward", true, true];

	// LRX textures
	if (count opfor_texture_overide > 0) then {
		_texture_name = selectRandom opfor_texture_overide;
		[_vehicle, _texture_name] spawn RPT_fnc_TextureVehicle;
	};

	// A3 textures
	if (_classname == "I_E_Truck_02_MRL_F") then {
		[_vehicle, ["Opfor",1], true ] spawn BIS_fnc_initVehicle;
	};

	// SPE GER Plane
	if (_classname == "SPEX_C47_Skytrain") then {
		[_vehicle, ["bare",1,"Hide_Door",1], true ] spawn BIS_fnc_initVehicle;
	};

	// Lock vehicles
	if !(GRLIB_permission_enemy) then {
		_vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
	};

	// Search Gunner
	if (_classname in (militia_vehicles + light_vehicles + heavy_vehicles)) then {
		[_vehicle] spawn F_getEmptyArmored;
	};
};

[_vehicle] spawn {
	params ["_vehicle"];
	sleep 1;
	if (_vehicle isKindOf "LandVehicle") then { [_vehicle] call F_vehicleUnflip };
	sleep 4;
	_vehicle setDamage 0;
	_vehicle allowDamage true;
	_vehicle setVariable ["GRLIB_vehicle_init", nil, true];
};

if (_side != GRLIB_side_civilian) then {
	diag_log format [ "Done Spawning Vehicle %1 at %2", _classname , time ];
};

_vehicle;
