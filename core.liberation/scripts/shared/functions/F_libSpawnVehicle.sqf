params [
	"_sectorpos",
	"_classname",
	["_size", 5],
	["_side", GRLIB_side_enemy],
	["_type", "infantry"],
	["_crewed", true],
	["_mission_ai", false]
];

if (isNil "_sectorpos" || isNil "_classname") exitWith { objNull };

private _classname_bak = _classname;
private _vehicle = objNull;
private _spawn_pos = _sectorpos;
private _airveh_alt = 300;
private _water_mode = 0;
private _sea_deep = 0;

if (_classname isKindOf "Air") then {
	_spawn_pos = [_sectorpos, _side] call F_getAirSpawn;
	if (count _spawn_pos > 0) then {
		_spawn_pos = _spawn_pos getPos [120, floor random 360];
		if (_classname isKindOf "Plane") then { _airveh_alt = 500 };
		if (GRLIB_SOG_enabled || GRLIB_SPE_enabled) then { _airveh_alt = 350 };
		if (_side == GRLIB_side_civilian) then { _airveh_alt = 150 };
		_spawn_pos set [2, _airveh_alt];
		_vehicle = createVehicle [_classname, _spawn_pos, [], 50, "FLY"];
		_vehicle setVariable ["GRLIB_vehicle_init", true, true];
		_vehicle allowDamage false;
		_vehicle setDir (_vehicle getDir _sectorpos);
		_vehicle setPosATL _spawn_pos;
		_vehicle setVelocityModelSpace [0, 80, 0];
	} else {
		diag_log format ["--- LRX Error: Cannot find Air spawn for position %2", _sectorpos];
		_vehicle = objNull;	
	};
} else {
	if (surfaceIsWater _spawn_pos && !(_classname isKindOf "Ship_F")) then {
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

	if (_classname isKindOf "Ship_F") then {
		_sea_deep = round (ATLtoASL (_spawn_pos) select 2);
		if (_sea_deep > -1.7) then {
			diag_log format ["--- LRX Error: No enough depth (%1) to build boat %2", _sea_deep, _classname];
			_classname = "";
		};
		_water_mode = 2;
	};

	if (_classname != "") then {
		if (_size != 0) then {
			_spawn_pos = [_sectorpos, _size, _water_mode] call F_findSafePlace;
		};

		if (count _spawn_pos == 0) exitWith {
			diag_log format ["--- LRX Error: Cannot find place to build vehicle %1 at position %2", _classname, _sectorpos];
		};		

		_vehicle = createVehicle [_classname, _spawn_pos, [], 5, "NONE"];
		_vehicle setVariable ["GRLIB_vehicle_init", true, true];
		_vehicle allowDamage false;
		_spawn_pos set [2, 0.5];
		if (surfaceIsWater _spawn_pos) then {
			_vehicle setPosASL _spawn_pos;
		} else {
			_vehicle setPosATL _spawn_pos;
		};
	};
};

if (_classname == "" || isNull _vehicle) exitWith {
	diag_log format ["--- LRX Error: Cannot build vehicle (%1) at position %2", _classname_bak, _sectorpos];
	objNull;
};

if (_mission_ai) then { _vehicle setVariable ["GRLIB_mission_AI", true, true] };

if (_side != GRLIB_side_civilian) then {
	diag_log format [ "Spawn Vehicle %1 Pos %2 at %3", _classname, getPosATL _vehicle, time ];
};

if (_crewed) then {	[_vehicle, _side, _mission_ai, _type] call F_forceCrew };
_vehicle addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
[_vehicle] call F_clearCargo;
[_vehicle] call F_fixModVehicle;
if (GRLIB_ACE_enabled) then { [_vehicle] call F_aceInitVehicle };

if (_vehicle isKindOf "Air") then {
	_vehicle engineOn true;
	_vehicle flyInHeight [_airveh_alt, true];
	_vehicle flyInHeightASL [_airveh_alt, _airveh_alt, _airveh_alt];
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
	// LRX textures
	if (count blufor_texture_overide > 0) then {
		_texture_name = selectRandom blufor_texture_overide;
		[_vehicle, _texture_name] spawn RPT_fnc_TextureVehicle;
	};
};

if (_side == GRLIB_side_enemy) then {
	// _vehicle addEventHandler ["Fuel", {
	// 	params ["_vehicle", "_hasFuel"];
	// 	if (count (crew _vehicle) == 0) exitWith {};
	// 	if (!_hasFuel) then { _vehicle setFuel 1 };
	// }];
	_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
	_vehicle setVariable ["GRLIB_vehicle_reward", true, true];

	[_vehicle] call F_vehicleDefense;

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
		if (_vehicle isKindOf "LandVehicle") then {
			[_vehicle] spawn F_getEmptyArmored;
		};
	};

	// Preset Inventory
	[_vehicle, opfor_vehicle_preset_inventory] call F_vehiclePreset;
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
