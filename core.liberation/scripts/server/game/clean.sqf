/*
File: clean.sqf
Author:

	Quiksilver

Last modified:

	10/12/2014 ArmA 1.36 by Quiksilver
	01/10/2021 LRX - pSiko

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
	- Orphaned MP Triggers http://feedback.arma3.com/view.php?id=19231
	- Empty Groups

	* Ruins can be excluded by setPos [0,0,0] on them, this script will not touch them in that case. Could be done for JIP/locality reasons, since Ruins can be fiddly with JIP.
	* Note: Please do not place any triggers at nullPos [0,0,0]. This script by default removes all triggers at nullPos.

Instructions:

	ExecVM from initServer.sqf or init.sqf in your mission directory.

	[] execVM "clean.sqf";				// If you put the file in mission directory
	[] execVM "scripts\clean.sqf";		// If you put the file in a folder, in this case called "scripts"
_________________________________________________________________________*/

sleep 15;

if (GRLIB_cleanup_vehicles == 0) exitWith {};

//==================== FORCE DELETE
private _force_cleanup_classnames = [
	"Blood_01_Base_F",
	"MedicalGarbage_01_Base_F",
	"Plane_Canopy_Base_F",
	"Ejection_Seat_Base_F",
	"CUP_A10_Ejection_Seat",
	"CUP_A10_Canopy",
	"rhs_k36d5_seat",
	"rhs_ka52_blade",
	"rhs_ka52_ejection_vest",
	"rhs_mi28_wing_right",
	"rhs_mi28_wing_left",
	"rhs_mi28_door_gunner",
	"rhs_mi28_door_pilot"
];

//==================== IGNORE VEHICLES

private _no_cleanup_classnames = [] + GRLIB_vehicle_blacklist;
{ _no_cleanup_classnames pushback (_x select 0) } foreach (support_vehicles + static_vehicles + opfor_recyclable);

//==================== HIDDEN-FROM-PLAYERS FUNCTION

_isHidden = {
	params ["_unit", "_dist", "_list"];
	private _c = false;
	if ( ({(( _unit distance2D _x) < _dist)} count _list) == 0 ) then { _c = true };
	_c;
};

// Get CounterStrik units
_getTTLunits = {
	[((units GRLIB_side_enemy) + vehicles), {alive _x && !(isNil {_x getVariable "GRLIB_counter_TTL"})}] call BIS_fnc_conditionalSelect;
};

//================================================================ CONFIG

deleteManagerPublic = true;								// To terminate script via debug console

private _checkPlayerCount = true;						// dynamic sleep. Set TRUE to have sleep automatically adjust based on # of players.
private _playerThreshold = 4;							// How many players before accelerated cycle kicks in?
private _checkFrequencyDefault = GRLIB_cleanup_vehicles;	        // sleep default
private _checkFrequencyAccelerated = (_checkFrequencyDefault/2);	// sleep accelerated

private _vehiclesLimit = 20;							// Vehicles Set -1 to disable.
private _vehicleDistCheck = true;						// TRUE to delete any vehicles that are far from players.
private _vehicleDist = (GRLIB_sector_size * 2);			// Distance (meters) from players that vehicles are not deleted if below max.

private _deadMenLimit = 30;								// Bodies. Set -1 to disable.
private _deadMenDistCheck = true;						// TRUE to delete any bodies that are far from players.
private _deadMenDist = (GRLIB_sector_size * 2);			// Distance (meters) from players that bodies are not deleted if below max.

private _deadVehiclesLimit = 20;						// Wrecks. Set -1 to disable.
private _deadVehicleDistCheck = true;					// TRUE to delete any destroyed vehicles that are far from players.
private _deadVehicleDist = (GRLIB_sector_size * 2);		// Distance (meters) from players that destroyed vehicles are not deleted if below max.

private _craterLimit = -1;								// Craters. Set -1 to disable.
private _craterDistCheck = true;						// TRUE to delete any craters that are far from players.
private _craterDist = (GRLIB_sector_size * 2);			// Distance (meters) from players that craters are not deleted if below max.

private _weaponHolderLimit = 30;						// Weapon Holders. Set -1 to disable.
private _weaponHolderDistCheck = true;					// TRUE to delete any weapon holders that are far from players.
private _weaponHolderDist = (GRLIB_sector_size * 2);	// Distance (meters) from players that ground garbage is not deleted if below max.

private _minesLimit = 30;								// Land mines. Set -1 to disable.
private _minesDistCheck = true;							// TRUE to delete any mines that are far from ANY UNIT (not just players).
private _minesDist = (GRLIB_sector_size * 2);			// Distance (meters) from players that land mines are not deleted if below max.

private _staticsLimit = -1;								// Static weapons. Set -1 to disable.
private _staticsDistCheck = true;						// TRUE to delete any static weapon that is far from ANY UNIT (not just players).
private _staticsDist = (GRLIB_sector_size * 2);			// Distance (meters) from players that static weapons are not deleted if below max.

private _ruinsLimit = 20;								// Ruins. Set -1 to disable.
private _ruinsDistCheck = true;							// TRUE to delete any ruins that are far from players.
private _ruinsDist = (GRLIB_sector_size * 2);			// Distance (meters) from players that ruins are not deleted if below max.

private _orphanedTriggers = true;						// Clean orphaned triggers in MP.
private _emptyGroups = true;							// Set FALSE to not delete empty groups.

//================================================================ LOOP

while {deleteManagerPublic} do {
	private _stats = 0;
	//================================= SLEEP
	private _sleep = _checkFrequencyDefault;
	if (_checkPlayerCount) then {
		if ((count (playableUnits + switchableUnits)) >= _playerThreshold) then {
			_sleep = _checkFrequencyAccelerated;
		};
	};
	if (GRLIB_global_stop == 1) then {
		_sleep = _checkFrequencyAccelerated/2;
		_vehiclesLimit = 10;
		_vehicleDistCheck = false;
		_deadVehiclesLimit = 10;
		_deadVehicleDistCheck = false;
	};
	sleep _sleep;

	//================================= FORCE DELETE
	{ if ([typeOf _x, _force_cleanup_classnames] call F_itemIsInClass) then { deleteVehicle _x; _stats = _stats + 1 } } forEach (allMissionObjects "All");
	sleep 1;
	//================================= LRX TTL UNITS
	private _units_ttl = [] call _getTTLunits;
	if (count _units_ttl > 0) then {
		{
			private _ttl = _x getVariable "GRLIB_counter_TTL";
			if ([_x,_deadMenDist,(playableUnits + switchableUnits)] call _isHidden && time > _ttl ) then {
				if (_x isKindOf "CAManBase") then {
					deleteVehicle _x;
				} else {
					[_x] spawn clean_vehicle;
				};
				_stats = _stats + 1;
			};
		} count _units_ttl;
	};
	sleep 1;
	//================================= DEAD MEN
	if (!(_deadMenLimit isEqualTo -1)) then {
		if ((count allDeadMen) > _deadMenLimit) then {
			if (_deadMenDistCheck) then {
				{
					if ([_x,_deadMenDist,(playableUnits + switchableUnits)] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
					};
				} count allDeadMen;
			};

			while {(((count allDeadMen) - _deadMenLimit) > 0)} do {
				_unit = selectRandom allDeadMen;
				if (!isNil "_unit") then {
					deleteVehicle _unit;
					_stats = _stats + 1;
					sleep 0.2;
				};
			};
		};
	};
	sleep 1;
	//================================= VEHICLES
	if (!(_vehiclesLimit isEqualTo -1)) then {
		private _nbVehicles = [vehicles, {
			alive _x &&
			[_x] call is_abandoned &&
			isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull]) &&
			!(_x getVariable ['R3F_LOG_disabled', true]) &&
			!([_x, "LHD", GRLIB_sector_size] call F_check_near) &&
			!([typeOf _x, _no_cleanup_classnames] call F_itemIsInClass)
		}] call BIS_fnc_conditionalSelect;

		if ((count (_nbVehicles)) > _vehiclesLimit) then {
			if (_vehicleDistCheck) then {
				{
					if ([_x,_vehicleDist,(playableUnits + switchableUnits)] call _isHidden) then {
						[_x] spawn clean_vehicle;
						_stats = _stats + 1;
					};
				} count (_nbVehicles);
			};

			while {(( (count (_nbVehicles)) - _vehiclesLimit) > 0)} do {
				_veh = selectRandom (_nbVehicles);
				[_veh] spawn clean_vehicle;
				_stats = _stats + 1;
				sleep 0.2;
			};
		};
	};
	sleep 1;
	//================================= WRECKS
	if (!(_deadVehiclesLimit isEqualTo -1)) then {
		if ((count (allDead - allDeadMen)) > _deadVehiclesLimit) then {
			if (_deadVehicleDistCheck) then {
				{
					if ([_x,_deadVehicleDist,(playableUnits + switchableUnits)] call _isHidden) then {
						[_x] spawn clean_vehicle;
						_stats = _stats + 1;
					};
				} count (allDead - allDeadMen);
			};

			while {(((count (allDead - allDeadMen)) - _deadVehiclesLimit) > 0)} do {
				_veh = selectRandom (allDead - allDeadMen);
				[_veh] spawn clean_vehicle;
				_stats = _stats + 1;
				sleep 0.2;
			};
		};
	};
	sleep 1;
	//================================= CRATERS
	if (!(_craterLimit isEqualTo -1)) then {
		if ((count (allMissionObjects "CraterLong")) > _craterLimit) then {
			if (_craterDistCheck) then {
				{
					if ([_x,_craterDist,(playableUnits + switchableUnits)] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
					};
				} count (allMissionObjects "CraterLong");
			};

			while {(((count (allMissionObjects "CraterLong")) - _craterLimit) > 0)} do {
				deleteVehicle (selectRandom (allMissionObjects "CraterLong"));
				_stats = _stats + 1;
				sleep 0.2;
			};
		};
	};
	sleep 1;
	//================================= WEAPON HOLDERS
	if (!(_weaponHolderLimit isEqualTo -1)) then {
		if ((count (allMissionObjects "WeaponHolder")) > _weaponHolderLimit) then {
			if (_weaponHolderDistCheck) then {
				{
					if ([_x,_weaponHolderDist,(playableUnits + switchableUnits)] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
					};
				} count (allMissionObjects "WeaponHolder");
			};

			while {(((count (allMissionObjects "WeaponHolder")) - _weaponHolderLimit) > 0)} do {
				deleteVehicle (selectRandom (allMissionObjects "WeaponHolder"));
				_stats = _stats + 1;
				sleep 0.2;
			};
		};
	};
	sleep 1;

	// Object WeaponHolderSimulated can't have zero or negative mass!
	{ if (round (getMass _x) <= 0) then { _x setMass 1 } } forEach (entities "WeaponHolderSimulated");
	sleep 1;
	//================================= MINES
	if (!(_minesLimit isEqualTo -1)) then {
		if ((count allMines) > _minesLimit) then {
			if (_minesDistCheck) then {
				{
					if ([_x,_minesDist,allUnits] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
					};
				} count allMines;
			};

			while {(((count allMines) - _minesLimit) > 0)} do {
				deleteVehicle (selectRandom allMines);
				_stats = _stats + 1;
				sleep 0.2;
			};
		};
	};
	sleep 1;
	//================================= STATIC WEAPONS
	if (!(_staticsLimit isEqualTo -1)) then {
		if ((count (allMissionObjects "StaticWeapon")) > _staticsLimit) then {
			if (_staticsDistCheck) then {
				{
					if ([_x,_staticsDist,allUnits] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
					};
				} count (allMissionObjects "StaticWeapon");
			};

			while {(((count (allMissionObjects "StaticWeapon")) - _staticsLimit) > 0)} do {
				deleteVehicle (selectRandom (allMissionObjects "StaticWeapon"));
				_stats = _stats + 1;
				sleep 0.2;
			};
		};
	};
	sleep 1;
	//================================= RUINS
	if (!(_ruinsLimit isEqualTo -1)) then {
		private _ruins = [];
		{
			if ((_x distance [0,0,0]) > 100) then {
				_ruins pushBack _x;
				sleep 0.1;
			};
		} count (allMissionObjects "Ruins");

		if ((count _ruins) > _ruinsLimit) then {
			if (_ruinsDistCheck) then {
				{
					if ([_x,_ruinsDist,(playableUnits + switchableUnits)] call _isHidden) then {
						deleteVehicle _x;
						_stats = _stats + 1;
					};
				} count (allMissionObjects "Ruins");
			};

			while {(((count _ruins) - _ruinsLimit) > 0)} do {
				_ruins resize (count _ruins - 1);
				deleteVehicle (selectRandom _ruins);
				_stats = _stats + 1;
				sleep 0.2;
			};
		};
	};
	sleep 1;
	//================================= ORPHANED MP TRIGGERS.
	if (_orphanedTriggers) then {
		{
			if ((_x distance [0,0,0]) < 1) then {
				deleteVehicle _x;
			};
		} count (allMissionObjects "EmptyDetector");
	};
	sleep 1;
	//================================= EMPTY GROUPS
	if (_emptyGroups) then {
		{
			if ((count units _x) isEqualTo 0) then {
				deleteGroup _x;
			};
		} count allGroups;
	};
    sleep 1;

	diag_log format ["--- LRX Garbage Collector --- Run at: %1 - Delete: %2 objects - %3 fps", round(time), _stats, diag_fps];
};