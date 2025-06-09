/*
File: clean.sqf
Author:

	Quiksilver

Last modified:

	10/12/2014 ArmA 1.36 by Quiksilver
	01/10/2023 LRX - pSiko

Description:

	Maintain healthy quantity of some mission objects created during scenarios, including some created by the engine.

    - Abandoned Vehicles (no crew, no owner)
	- Dead bodies
	- Dead vehicles
	- Craters
	- Weapon holders (ground garbage)
	- Mines
	- Static weapons
	- Ruins

	* Ruins can be excluded by setPos [0,0,0] on them, this script will not touch them in that case. Could be done for JIP/locality reasons, since Ruins can be fiddly with JIP.
	* Note: Please do not place any triggers at nullPos [0,0,0]. This script by default removes all triggers at nullPos.

Instructions:

	ExecVM from initServer.sqf or init.sqf in your mission directory.

	[] execVM "clean.sqf";				// If you put the file in mission directory
	[] execVM "scripts\clean.sqf";		// If you put the file in a folder, in this case called "scripts"

	(DBG) Execute in game debug console:

	GRLIB_force_cleanup = true;			// to force script execution
	GRLIB_run_cleanup = false;			// to terminate script

_________________________________________________________________________*/

if (GRLIB_cleanup_vehicles == 0) exitWith {};

// IGNORE VEHICLES
private _no_cleanup_classnames = [
	Arsenal_typename,
	GRLIB_sar_wreck,
	GRLIB_sar_fire,
	"Land_Device_assembled_F",
	"Land_Device_disassembled_F"
] + uavs_vehicles + GRLIB_vehicle_blacklist;

// HIDDEN-FROM-PLAYERS FUNCTION
private _isHidden = {
	params ["_unit", "_dist", "_list"];
	(({ _unit distance2D _x < _dist } count _list) == 0);
};

// DELETE LRX TTL UNITS
private _delete_LRX_TTL = {
	private _hidden_from = [] + GRLIB_all_fobs; 	// FOB + players + active sectors
	{
		if !(isNil {_x getVariable "PAR_Grp_ID"}) then { _hidden_from pushBack (getPosATL _x) };
	} forEach (units GRLIB_side_friendly + units GRLIB_side_civilian);
	{ _hidden_from pushBack (markerPos _x)} forEach active_sectors;

	private _units_ttl = (allMissionObjects "All") select { !(isNil {_x getVariable "GRLIB_counter_TTL"}) };
	if (count _units_ttl > 0) then {
		{
			private _ttl = _x getVariable "GRLIB_counter_TTL";
			if (!isNil "_ttl") then {
				if ([_x, GRLIB_sector_size, _hidden_from] call _isHidden && time > _ttl) then {
					_x setDamage [1, false];
					deleteVehicle _x;
					sleep 0.1;
				};
			};
		} count _units_ttl;
	};
};

// CONFIG
GRLIB_run_cleanup = true;							// To terminate script via debug console
GRLIB_cleanup_active = false;						// To detect script activity
GRLIB_force_cleanup = false;						// To force script execution via debug console
publicVariable "GRLIB_force_cleanup";

private _checkPlayerCount = true;					// dynamic sleep. Set TRUE to have sleep automatically adjust based on # of players.
private _playerThreshold = 4;						// How many players before accelerated cycle kicks in?
private _checkFrequencyDefault = GRLIB_cleanup_vehicles;	        // sleep default
private _checkFrequencyAccelerated = (_checkFrequencyDefault/2);	// sleep accelerated

private _deadMenLimit = 30;							// Bodies. Set -1 to disable.
private _deadMenLimitMax = 80;						// Bodies Max.
private _deadMenDistCheck = true;					// TRUE to delete any bodies that are far from players.
private _deadMenDist = GRLIB_sector_size;			// Distance (meters) from players that bodies are not deleted if below max.

private _weaponHolderLimit = 30;					// Weapon Holders. Set -1 to disable.
private _weaponHolderLimitMax = 80;					// Weapon Holders Max.
private _weaponHolderDistCheck = true;				// TRUE to delete any weapon holders that are far from players.
private _weaponHolderDist = GRLIB_sector_size;		// Distance (meters) from players that ground garbage is not deleted if below max.

private _vehiclesLimit = 15;						// Vehicles Set -1 to disable.
private _vehiclesLimitMax = 30;						// Vehicles max.
private _vehicleDistCheck = true;					// TRUE to delete any vehicles that are far from players.
private _vehicleDist = (GRLIB_sector_size * 2);		// Distance (meters) from players that vehicles are not deleted if below max.

private _deadVehiclesLimit = 10;					// Wrecks. Set -1 to disable.
private _deadVehiclesLimitMax = 20;					// Wrecks Max.
private _deadVehicleDistCheck = true;				// TRUE to delete any destroyed vehicles that are far from players.
private _deadVehicleDist = (GRLIB_sector_size * 2);	// Distance (meters) from players that destroyed vehicles are not deleted if below max.

private _minesLimit = 35;							// Land mines. Set -1 to disable.
private _minesDistCheck = true;						// TRUE to delete any mines that are far from ANY UNIT (not just players).
private _minesDist = (GRLIB_sector_size * 2);		// Distance (meters) from players that land mines are not deleted if below max.

private _craterLimit = -1;							// Craters. Set -1 to disable.
private _craterDistCheck = true;					// TRUE to delete any craters that are far from players.
private _craterDist = GRLIB_sector_size;			// Distance (meters) from players that craters are not deleted if below max.

private _staticsLimit = -1;							// Static weapons. Set -1 to disable.
private _staticsDistCheck = true;					// TRUE to delete any static weapon that is far from ANY UNIT (not just players).
private _staticsDist = GRLIB_sector_size;			// Distance (meters) from players that static weapons are not deleted if below max.

private _ruinsLimit = -1;							// Ruins. Set -1 to disable.
private _ruinsDistCheck = true;						// TRUE to delete any ruins that are far from players.
private _ruinsDist = GRLIB_sector_size;				// Distance (meters) from players that ruins are not deleted if below max.


// LOOP
private _list = [];
private _count = 0;
private _stats = 0;
private _sleep = _checkFrequencyDefault;

sleep 120;
while {GRLIB_run_cleanup} do {
	_stats = 0;
	_list = [];

	// SLEEP
	_sleep = _checkFrequencyDefault;
	if (_checkPlayerCount) then {
		if ((count (playableUnits + switchableUnits)) >= _playerThreshold) then {
			_sleep = _checkFrequencyAccelerated;
		};
	};
	if (GRLIB_global_stop == 1) then {
		_sleep = _checkFrequencyAccelerated/2;
		_vehiclesLimit = 15;
		_vehicleDistCheck = false;
		_deadVehiclesLimit = 10;
		_deadVehicleDistCheck = false;
	};

	waitUntil {
		if (_sleep % 300 == 0) then {
			// FORCE DELETE
			{ deleteVehicle _x } forEach (entities [GRLIB_force_cleanup_classnames, []]);

			// LRX TTL UNITS DELETE
			[] call _delete_LRX_TTL;
		};
		sleep 60;
		_sleep = _sleep - 60;
		(_sleep <= 0 || GRLIB_force_cleanup)
	};

	if (GRLIB_force_cleanup) then {
		GRLIB_force_cleanup = false;
		publicVariable "GRLIB_force_cleanup";
	};

	GRLIB_cleanup_active = true;
	diag_log format ["--- LRX Garbage Collector --- Start at: %1 - %2 fps", round(time), diag_fps];

	// FORCE DELETE
	_list = (allMissionObjects "Blood_01_Base_F");
	_list append (allMissionObjects "MedicalGarbage_01_Base_F");
	{ deleteVehicle _x } forEach _list;

	private _hidden_from = [] + GRLIB_all_fobs; 	// FOB + players + active sectors
	{
		if !(isNil {_x getVariable "PAR_Grp_ID"}) then { _hidden_from pushBack (getPosATL _x) };
	} forEach (units GRLIB_side_friendly + units GRLIB_side_civilian);
	{ _hidden_from pushBack (markerPos _x)} forEach active_sectors;

	// DEAD MEN
	if (!(_deadMenLimit == -1)) then {
		if ((count allDeadMen) > _deadMenLimit) then {
			if (_deadMenDistCheck) then {
				{
					if ([_x, _deadMenDist, _hidden_from] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
					};
				} count allDeadMen;
				sleep 0.1;
				while {(((count allDeadMen) - _deadMenLimitMax) > 0)} do {
					deleteVehicle (selectRandom allDeadMen);
					_stats = _stats + 1;
				};
			} else {
				while {(((count allDeadMen) - _deadMenLimit) > 0)} do {
					deleteVehicle (selectRandom allDeadMen);
					_stats = _stats + 1;
				};
			};
			sleep 1;
		};
	};

	// WEAPON HOLDERS
	if (!(_weaponHolderLimit == -1)) then {
		_list = (allMissionObjects "WeaponHolder");
		_list append (allMissionObjects "WeaponHolderSimulated");
		_count = count _list;
		if (_count > _weaponHolderLimit) then {
			if (_weaponHolderDistCheck) then {
				{
					if ([_x, _weaponHolderDist, _hidden_from] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
						_count = _count - 1;
					};
				} count _list;
				sleep 0.1;
				_list = _list select {!isNull _x};
				_count = count _list;
				while {((_count - _weaponHolderLimitMax) > 0)} do {
					deleteVehicle (selectRandom _list);
					_stats = _stats + 1;
					_count = _count - 1;
				};
			} else {
				while {((_count - _weaponHolderLimit) > 0)} do {
					deleteVehicle (selectRandom _list);
					_stats = _stats + 1;
					_count = _count - 1;
				};
			};
			sleep 1;
		};
	};

	// VEHICLES
	if (!(_vehiclesLimit == -1)) then {
		private _nbVehicles = vehicles select {
			alive _x &&	[_x] call is_abandoned &&
			isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull]) &&
			!(_x getVariable ['R3F_LOG_disabled', false]) &&
			!([_x, "LHD", GRLIB_sector_size] call F_check_near) &&
			!([_x, _no_cleanup_classnames] call F_itemIsInClass)
		};
		private _nbVehiclesWater = _nbVehicles select { (getPosASL _x select 2) <= -15 };
		_nbVehicles = _nbVehicles - _nbVehiclesWater;
		{ deleteVehicle _x; _stats = _stats + 1 } forEach _nbVehiclesWater;
		if ((count _nbVehicles) > _vehiclesLimit) then {
			if (_vehicleDistCheck) then {
				{
					if ([_x, _vehicleDist, _hidden_from] call _isHidden) then {
						[_x, true, true] spawn clean_vehicle;
						_stats = _stats + 1;
					};
				} count (_nbVehicles);
				sleep 0.1;
				_list = _nbVehicles select {!isNull _x};
				_count = count _list;
				while {((_count - _vehiclesLimitMax) > 0)} do {
					private _veh = selectRandom _list;
					[_veh, true, true] spawn clean_vehicle;
					_stats = _stats + 1;
					_count = _count - 1;
				};
			} else {
				while {(((count _nbVehicles) - _vehiclesLimit) > 0)} do {
					[selectRandom _nbVehicles, true, true] spawn clean_vehicle;
					_stats = _stats + 1;
				};
			};
			sleep 1;
		};
	};

	// WRECKS
	if (!(_deadVehiclesLimit == -1)) then {
		_list = (allDead - allDeadMen) select { !([_x, _no_cleanup_classnames] call F_itemIsInClass) && getObjectType _x >= 8 };
		private _list_sunken = _list select { (getPosASL _x select 2) <= -15 };
		_list = _list - _list_sunken;
		{ deleteVehicle _x; _stats = _stats + 1 } forEach _list_sunken;
		_count = count _list;
		if (_count > _deadVehiclesLimit) then {
			if (_deadVehicleDistCheck) then {
				{
					if ([_x, _deadVehicleDist, _hidden_from] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
						_count = _count - 1;
					};
				} count _list;
				sleep 0.1;
				_list = _list select {!isNull _x};
				_count = count _list;
				while {((_count - _deadMenLimitMax) > 0)} do {
					deleteVehicle (selectRandom _list);
					_stats = _stats + 1;
					_count = _count - 1;
				};
			} else {
				while {((_count - _deadVehiclesLimit) > 0)} do {
					deleteVehicle (selectRandom _list);
					_stats = _stats + 1;
					_count = _count - 1;
				};
			};
			sleep 1;
		};
	};

	// CRATERS
	if (!(_craterLimit == -1)) then {
		_list = (allMissionObjects "Crater") select { getObjectType _x >= 8 };
		_list append (allMissionObjects "CraterLong") select { getObjectType _x >= 8 };
		_count = count _list;
		if (_count > _craterLimit) then {
			if (_craterDistCheck) then {
				{
					if ([_x, _craterDist, _hidden_from] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
						_count = _count - 1;
					};
				} count _list;
			} else {
				while {((_count - _craterLimit) > 0)} do {
					deleteVehicle (selectRandom _list);
					_stats = _stats + 1;
					_count = _count - 1;
				};
			};
			sleep 1;
		};
	};

	// Object WeaponHolderSimulated can't have zero or negative mass!
	//{ if (round (getMass _x) <= 0) then { _x setMass 1 } } forEach (entities "WeaponHolderSimulated");
	//sleep 1;

	// MINES
	if (!(_minesLimit == -1)) then {
		if ((count allMines) > _minesLimit) then {
			if (_minesDistCheck) then {
				{
					if ([_x, _minesDist ,_hidden_from] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
					};
				} count allMines;
			} else {
				while {(((count allMines) - _minesLimit) > 0)} do {
					deleteVehicle (selectRandom allMines);
					_stats = _stats + 1;
				};
			};
			sleep 1;
		};
	};

	// STATIC WEAPONS
	if (!(_staticsLimit == -1)) then {
		_list = entities "StaticWeapon";
		_count = count _list;
		if (_count > _staticsLimit) then {
			if (_staticsDistCheck) then {
				{
					if ([_x, _staticsDist, _hidden_from] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
						_count = _count - 1;
					};
				} count _list;
			} else {
				while {((_count - _staticsLimit) > 0)} do {
					deleteVehicle (selectRandom _list);
					_stats = _stats + 1;
					_count = _count - 1;
				};
			};
			sleep 1;
		};
	};

	// RUINS
	if (!(_ruinsLimit == -1)) then {
		_list = allMissionObjects "Ruins";
		_count = count _list;
		if (_count > _ruinsLimit) then {
			if (_ruinsDistCheck) then {
				{
					if ([_x, _ruinsDist, _hidden_from] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
						_count = _count - 1;
					};
				} count _list;
			} else {
				while {((_count - _ruinsLimit) > 0)} do {
					deleteVehicle (selectRandom _list);
					_stats = _stats + 1;
					_count = _count - 1;
				};
			};
			sleep 1;
		};
	};

	sleep 2;
	GRLIB_cleanup_active = false;
	diag_log format ["--- LRX Garbage Collector --- End at: %1 - Delete: %2 objects - %3 fps", round(time), _stats, diag_fps];
};