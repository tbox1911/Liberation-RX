params ["_sector"];

diag_log format ["--- LRX Manage Sector %1 (queued: %2)", _sector, GRLIB_sector_spawning];
if (GRLIB_sector_spawning) then {
	waitUntil { sleep 10; !GRLIB_sector_spawning };
};

private _sector_pos = markerPos _sector;
if (([_sector_pos, (GRLIB_sector_size * 2), GRLIB_side_friendly] call F_getUnitsCount) == 0 && !GRLIB_Commander_mode) exitWith {};
if (_sector in active_sectors + blufor_sectors) exitWith {
	diag_log format ["Sector %1 already active, aborting.", _sector];
};

active_sectors pushback _sector;
publicVariable "active_sectors";
GRLIB_sector_spawning = true;
publicVariable "GRLIB_sector_spawning";
_sectorName = markerText _sector;
_sector setMarkerText format ["%1 - Loading", _sectorName];
private _spawncivs = false;
private _building_ai_max = 0;
private _building_range = 200;
private _local_capture_size = GRLIB_capture_size;
private _marker = "";
private _ied_count = 0;
private _uavs_count = 0;
private _static_count = 0;
private _vehtospawn = [];
private _grp = grpNull;
private _managed_units = [];
private _managed_vehicles = [];
private _squad1 = [];
private _infsquad1 = "militia";
private _squad2 = [];
private _infsquad2 = "militia";
private _squad3 = [];
private _infsquad3 = "infantry";
private _squad4 = [];
private _infsquad4 = "infantry";
private _squad5 = [];
private _infsquad5 = "infantry";
private _max_prisonners = 4;
private _sector_despawn_tickets = GRLIB_despawn_tickets;
private _nearRadioTower = ([_sector_pos, GRLIB_side_enemy] call F_getNearestTower != "");
private _active_players = [_sector_pos, (GRLIB_sector_size * 2)] call F_getNearbyPlayers;

if (GRLIB_Commander_mode) then {
	_active_players = (AllPlayers - (entities "HeadlessClient_F"));
	_local_capture_size = 500;
	_sector setMarkerTypeLocal "mil_objective";
	_sector setMarkerColor "ColorYellow";
};

private _count_players = count _active_players;
diag_log format ["Spawn Defend Sector %1 - player in combat %2 / readiness %3 at %4", _sector, _count_players, combat_readiness, time];

// Sector type refactored using a switch statement
switch true do {
    case (_sector in sectors_bigtown): {
        _vehtospawn = [([] call F_getAdaptiveVehicle), (selectRandom militia_vehicles), (selectRandom militia_vehicles)];
        while { count _squad1 < 12 } do { _squad1 pushback (selectRandom militia_squad) };
        while { count _squad2 < 12 } do { _squad2 pushback (selectRandom militia_squad) };
        if (combat_readiness >= 33) then { _squad3 = ([] call F_getAdaptiveSquadComp) };
        if (combat_readiness >= 66) then { _squad4 = ([] call F_getAdaptiveSquadComp) };
        if (_count_players > 2) then { _squad5 = ([] call F_getAdaptiveSquadComp) };
        _vehtospawn pushback (selectRandom militia_vehicles);
        _vehtospawn pushback ([] call F_getAdaptiveVehicle);
        if (floor random 100 > (33 / GRLIB_difficulty_modifier)) then {
            _vehtospawn pushback (selectRandom militia_vehicles)
        };
        if (floor random 100 > (66 / GRLIB_difficulty_modifier)) then {
            _vehtospawn pushback ([] call F_getAdaptiveVehicle)
        };
        _spawncivs = true;
        _building_ai_max = 12;
        _building_range = 300;
        _local_capture_size = _local_capture_size * 1.4;
        _ied_count = (4 + (floor (random 5)));
    };
    case (_sector in sectors_capture): {
        while { count _squad1 < 12 } do { _squad1 pushback (selectRandom militia_squad) };
        if (combat_readiness >= 33) then {
            while { count _squad2 < 12 } do { _squad2 pushback (selectRandom militia_squad) }
        };
        if (combat_readiness >= 66) then {
            while { count _squad3 < 8 } do { _squad3 pushback (selectRandom militia_squad) };
            _infsquad3 = "militia"
        };
        if (_count_players > 2) then {
            while { count _squad4 < 8 } do { _squad4 pushback (selectRandom militia_squad) };
            _infsquad4 = "militia"
        };
        if (_count_players > 4) then {
            _squad5 = ([] call F_getAdaptiveSquadComp)
        };
        _vehtospawn pushback (selectRandom militia_vehicles);
        _vehtospawn pushback (selectRandom militia_vehicles);
        if (floor random 100 > (33 / GRLIB_difficulty_modifier)) then {
            _vehtospawn pushback (selectRandom militia_vehicles)
        };
        if (floor random 100 > (66 / GRLIB_difficulty_modifier)) then {
            _vehtospawn pushback (selectRandom militia_vehicles)
        };
        _spawncivs = true;
        _building_ai_max = 10;
        _building_range = 200;
        _ied_count = (3 + (floor random 4));
    };
    case (_sector in sectors_military): {
        _infsquad1 = "infantry";
        _squad1 = ([] call F_getAdaptiveSquadComp);
        _infsquad2 = "infantry";
        _squad2 = ([] call F_getAdaptiveSquadComp);
        if (combat_readiness >= 66) then {
            _squad3 = ([] call F_getAdaptiveSquadComp)
        };
        if (_count_players > 2) then {
            _squad4 = ([] call F_getAdaptiveSquadComp)
        };
        if (_count_players > 4) then {
            _squad5 = ([] call F_getAdaptiveSquadComp)
        };
        _vehtospawn = [([] call F_getAdaptiveVehicle), ([] call F_getAdaptiveVehicle)];
        if (floor random 100 > (33 / GRLIB_difficulty_modifier)) then {
            _vehtospawn pushback ([] call F_getAdaptiveVehicle)
        };
        if (floor random 100 > (66 / GRLIB_difficulty_modifier)) then {
            _vehtospawn pushback ([] call F_getAdaptiveVehicle)
        };
        _spawncivs = false;
        _building_ai_max = 8;
        _building_range = 150;
        _ied_count = (3 + (floor random 3));
        _uavs_count = 3;
        _static_count = 3;

		if (GRLIB_AlarmsEnabled) then {
			// Alarm!
			[_sector] spawn {
				params ["_sector"];
				private _pos = markerPos [_sector, true];
				private _sound = "A3\data_f_curator\sound\cfgsounds\air_raid.wss";
				while { _sector in active_sectors } do {
					for "_i" from 0 to (floor(random 4)) do {
						if !(_sector in blufor_sectors) then {
							playSound3D [_sound, _pos, false, AGLToASL _pos, 5, 1, 1000];
							sleep (5 + floor(random 4));
						};
					};
					sleep 60;
				};
			};
		};
        private _pilots = allPlayers select {
            (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x
        };
        if (count _pilots > 0) then {
            [getPosATL (selectRandom _pilots), GRLIB_side_enemy, 3] spawn spawn_air;
        };
        _ied_count = 4;
    };
    case (_sector in sectors_factory): {
        while { count _squad1 < 10 } do { _squad1 pushback (selectRandom militia_squad) };
        _infsquad2 = "infantry";
        _squad2 = ([] call F_getAdaptiveSquadComp);
        if (combat_readiness >= 66) then {
            _squad3 = ([] call F_getAdaptiveSquadComp)
        };
        if (_count_players > 2) then {
            _squad4 = ([] call F_getAdaptiveSquadComp)
        };
        if (_count_players > 4) then {
            _squad5 = ([] call F_getAdaptiveSquadComp)
        };
        _vehtospawn pushback (selectRandom militia_vehicles);
        _vehtospawn pushback (selectRandom militia_vehicles);
        if (floor random 100 > 33) then {
            _vehtospawn pushback (selectRandom militia_vehicles)
        };
        if (floor random 100 > 66) then {
            _vehtospawn pushback ([] call F_getAdaptiveVehicle)
        };
        _spawncivs = true;
        _building_ai_max = 6;
        _building_range = 100;
        _ied_count = (3 + (floor random 3));
        _uavs_count = 3;
    };
    case (_sector in sectors_tower): {
        _spawncivs = false;
        _infsquad1 = "infantry";
        _squad1 = ([] call F_getAdaptiveSquadComp);
        _infsquad2 = "infantry";
        _squad2 = ([] call F_getAdaptiveSquadComp);
        if (combat_readiness >= 66) then {
            _squad3 = ([] call F_getAdaptiveSquadComp)
        };
        if (_count_players > 2) then {
            _squad4 = ([] call F_getAdaptiveSquadComp)
        };
        if (_count_players > 4) then {
            _squad5 = ([] call F_getAdaptiveSquadComp)
        };
        _building_ai_max = 4;
        if (floor random 100 > 33) then {
            _vehtospawn pushback ([] call F_getAdaptiveVehicle)
        };
        [_sector_pos, 50] call createlandmines;
        _static_count = 4;
        _uavs_count = 3;
    };
    default {
        diag_log "Sector type did not match any known sector arrays.";
    };
};

_sector setMarkerText format ["%2 - Loading %1%%", 10, _sectorName];
// Extra veh based on difficulty
if ((floor GRLIB_difficulty_modifier) > 1) then {
	for "_i" from 1 to (floor (GRLIB_difficulty_modifier)) do {
		_vehtospawn pushback ([] call F_getAdaptiveVehicle);
	};
};

// Create mines
[_sector_pos, _building_range, round (_ied_count)] spawn ied_manager;
[_sector_pos, _building_range, round (_ied_count)] spawn ied_trap_manager;

// Create drones defender
if (_uavs_count > 0) then {
	[_sector_pos, _uavs_count] spawn send_drones;
};

_sector setMarkerText format ["%2 - Loading %1%%", 15, _sectorName];
// Create units
{
	private _squad = _x select 0;
	private _infsquad = _x select 1;
	private _range = _x select 2;
	if (!(_squad isEqualTo [])) then {
		_grp = [_sector, _infsquad, _squad, false] call F_spawnRegularSquad;
		[_grp, _sector_pos, _range] spawn defence_ai;
		_managed_units = _managed_units + (units _grp);
		sleep 1;
	};
	_sector setMarkerText format ["%2 - Loading %1%%", round linearConversion [0, 4, _foreachIndex, 20, 40], _sectorName];
} forEach [[_squad1, _infsquad1, 50], [_squad2, _infsquad2, 100], [_squad3, _infsquad3, 100], [_squad4, _infsquad4, 200], [_squad5, _infsquad5, 300]];

// Create vehicles
if (opforcap_max) then { _vehtospawn = [] };
if (count _vehtospawn > 0) then {
	{
		private _pos = _sector_pos getPos [(80 + floor random 80), floor random 360];
		private _vehicle = [_pos, _x, 10] call F_libSpawnVehicle;
		if (!isNull _vehicle) then {
			_managed_vehicles pushback _vehicle;
			[group (driver _vehicle), getPosATL _vehicle, (80 + floor random 160)] spawn defence_ai;
		};
		sleep 1;
		_sector setMarkerText format ["%2 - Loading %1%%", round linearConversion [0, count _vehtospawn, _foreachIndex, 40, 60], _sectorName];
	} foreach _vehtospawn;
};

// Create garrison
if (opforcap_max) then { _building_ai_max = 0 };
if (_building_ai_max > 0) then {
	_building_ai_max = (_building_ai_max * GRLIB_building_ai_ratio);
	if (_sector in sectors_bigtown) then { _building_ai_max = _building_ai_max + 12 };
	_sector setMarkerText format ["%2 - Loading %1%%", 70, _sectorName];
	_managed_units = _managed_units + ([_infsquad1, _building_ai_max, _sector_pos, _building_range, objNull, false] call F_buildingSquad);
};
_sector setMarkerText format ["%2 - Loading %1%%", 80, _sectorName];
// Create civilians
if ( _spawncivs && GRLIB_civilian_activity > 0) then {
	private _nbcivs = round ((5 + (floor random 6)) * GRLIB_civilian_activity);
	if (_sector in sectors_bigtown) then { _nbcivs = _nbcivs + 12 };
	private _rnd = [1,1,1,1,2,2,3];
	_civ = _nbcivs;
	while { _nbcivs > 0 } do {
		_max_units = (selectRandom _rnd) min _nbcivs;
		_grp = [_sector_pos, _max_units] call F_spawnCivilians;
		[_grp, _sector_pos] spawn civilian_ai;
		_managed_units = _managed_units + (units _grp);
		_nbcivs = _nbcivs - _max_units;
		_sector setMarkerText format ["%2 - Loading %1%%", round linearConversion [0, _civ, _civ - _nbcivs, 80, 99], _sectorName];
		sleep 1;
	};
};

// Create static weapons
[_sector, _static_count] spawn spawn_static;

// Radio send renforcement
if (_nearRadioTower) then {
	if (floor random 2 == 0) then {
		if (combat_readiness > 35) then {
			private _pilots = allPlayers select { (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x };
			if (count _pilots > 0) then {
				[getPosATL (selectRandom _pilots), GRLIB_side_enemy, 3] spawn spawn_air;
			} else {
				[_sector_pos] spawn send_paratroopers;
			};
		};
	};
} else {
	[gamelogic, "Enemies can't call Air support. No radio tower nearby."] remoteExec ["globalChat", 0];
};

// Upgraded AI defense - now dynamic and reactive instead of time-based
private _attackStages = [
	[75, false],
	[50, false],
	[35, false],
	[25, false]
];

private _stageAttack = {
	params ["_stage", "_pos"];
	if (combat_readiness > (70 / ((_stage/2) max 1))) then {
		private _attackFunctions = [
			{
				params ["_pos"];
				[_pos, true] spawn send_paratroopers;
			},
			{
				params ["_pos", "_stage"];
				[_pos, GRLIB_side_enemy, _stage] spawn spawn_air;
			},
			{
				params ["_pos"];
				[_pos] spawn spawn_halo_vehicle;
			},
			{
				params ["_pos", "_stage"];
				[_pos, _stage*2] spawn send_drones;
			}
		];
		[_pos, _stage] call (selectRandom (_attackFunctions call BIS_fnc_arrayShuffle));
	};
	if (_stage >= 4) then { 		// Final stage of defense
		sleep 30;
		[_pos] spawn spawn_halo_vehicle;
	};
};

if (GRLIB_Commander_mode) then {
	_marker = createMarkerLocal [("zone_capture" + _sector), _sector_pos];
	_marker setMarkerBrushLocal "DiagGrid";
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerAlphaLocal 0.7;
	_marker setMarkerSizeLocal [_local_capture_size, _local_capture_size];
	_marker setMarkerColor GRLIB_color_enemy_bright;
};

// Main loop
private _building_alive = (nearestObjects [_sector_pos, ["House"], _local_capture_size]) select {
	alive _x &&
	(tolower (typeOf _x) find "ruin" == -1) &&
	(
		(tolower (typeOf _x) find "house" != -1) ||
		(tolower (typeOf _x) find "shop" != -1) ||
		(tolower (typeOf _x) find "fuelstation" != -1)
	)
};

diag_log format ["Sector %1 wait attack to finish", _sector];

private _task = "attack" + _sectorName + str round time;
[true, _task, [format ["Attack %1", _sectorName], format ["Attack %1", _sectorName], _sector], _sector_pos, "ASSIGNED", 2, true] call BIS_fnc_taskCreate;
[_task, true] call BIS_fnc_taskSetCurrent;
_sector setMarkerText format ["%1 - Loaded", _sectorName];
sleep 5;
_sector setMarkerText format ["%1", _sectorName];
GRLIB_sector_spawning = false;
publicVariable "GRLIB_sector_spawning";

private ["_sector_ownership"];
while {true} do {
	if (!(_sector in active_sectors)) exitWith { // Aborted
		diag_log format ["Sector %1 mission aborted.", _sector];
		_sector setMarkerText _sectorName;
		[_task,"CANCELED"] call BIS_fnc_taskSetState;
		[_task] spawn {
			params ["_task"];
			sleep 30;
			[_task, true, true] call BIS_fnc_deleteTask;
		};
	};
	_sector_ownership = [_sector_pos, _local_capture_size] call F_sectorOwnership;
	if (_sector in sectors_tower) then {
		private _tower = [_sector_pos] call F_getNearestRadioTower;
		if (!isNil "_tower") then { _sector_ownership = GRLIB_side_enemy };
	};
	private _ratio = 100 - round (([_sector, _local_capture_size] call F_getForceRatio) * 100);
	_sector setMarkerText format ["%2 - %1%%", _ratio, _sectorName];
	if (_sector_ownership == GRLIB_side_friendly) exitWith { // Victory
		diag_log format ["Sector %1 mission succeeded.", _sector];
		_sector setMarkerText _sectorName;
		[_task,"SUCCEEDED"] call BIS_fnc_taskSetState;
		if (GRLIB_Commander_mode) then { deleteMarker _marker };
		if (isServer) then {
			[_sector] spawn sector_liberated_remote_call;
		} else {
			[_sector] remoteExec ["sector_liberated_remote_call", 2];
		};
		private _enemy_left = (_sector_pos nearEntities ["CAManBase", (_local_capture_size * 1.2)]) select { (side _x == GRLIB_side_enemy) && !(_x getVariable ["GRLIB_mission_AI", false]) };
		{
			if (_max_prisonners > 0) then {
				if ((floor random 100) <= GRLIB_surrender_chance) then {
					[_x] spawn prisoner_ai;
					_max_prisonners = _max_prisonners - 1;
					_managed_units = _managed_units - [_x];
				} else {
					if ((floor random 100) <= 50) then { [_x] spawn bomber_ai };
				};
				sleep 0.1;
			};
		} foreach _enemy_left;

		if (_sector in (sectors_capture + sectors_factory + sectors_bigtown)) then {
			private _building_destroyed = count (_building_alive select { !(alive _x) || (tolower (typeOf _x) find "ruin" != -1) });
			if (_building_destroyed > 0) then {
				[_sector, 4, _building_destroyed] remoteExec ["remote_call_sector", 0];
				{ [_x, -(_building_destroyed * 3)] call F_addReput } forEach ([_sector_pos, _local_capture_size] call F_getNearbyPlayers);
			};
			[_sector_pos] spawn {
				params ["_sector_pos"];
				sleep 30;
				private _civilians = (_sector_pos nearEntities ["CAManBase", GRLIB_capture_size * 1.2]) select {
					(side _x == GRLIB_side_civilian) && !(captive _x) &&
					!(isAgent teamMember _x) && (isNull objectParent _x)
				};
				if (count _civilians > 5) then {
					for "_i" from 0 to (floor random 4) do {
						private _anim = selectRandom ["Acts_Dance_01", "Acts_Dance_02"];
						private _unit = selectRandom _civilians;
						[_unit, _anim] spawn F_startAnimMP;
						_unit setVariable ["GRLIB_can_speak", false, true];
						_civilians = _civilians - [_unit];
						sleep 1;
					};
				};
			};
		};
		[_task] spawn {
			params ["_task"];
			sleep 120;
			[_task, true, true] call BIS_fnc_deleteTask;
		};
	};

	if (!GRLIB_Commander_mode) then {
		if (([_sector_pos, (GRLIB_sector_size + 300), GRLIB_side_friendly] call F_getUnitsCount) == 0) then {
			_sector_despawn_tickets = _sector_despawn_tickets - 1;
		} else {
			_sector_despawn_tickets = GRLIB_despawn_tickets;
		};
	};

	if (_sector_despawn_tickets <= 1) exitWith { // Sleep sector
		diag_log format ["Sector %1 mission failed.", _sector];
		_sector setMarkerText _sectorName;
		[_task,"FAILED"] call BIS_fnc_taskSetState;
		private _msg = format ["You failed to capture sector %1, your reputation drops by %2 points.", [_sector_pos] call F_getLocationName, -5];
		{
			[_x, -5] call F_addReput;
			[gamelogic, _msg] remoteExec ["globalChat", owner _x];
		} forEach _active_players;
	};

	_nearRadioTower = ([_sector_pos, GRLIB_side_enemy] call F_getNearestTower != "");
	if (_nearRadioTower) then { // Sector Defense
		{
			_stage = _forEachIndex + 1;
			if ((_x select 0) >= _ratio && !(_x select 1)) then {
				_x set [1, true];
				[_stage, _sector_pos] spawn _stageAttack;
				sleep 5;
			};
		} foreach _attackStages;
	};

	sleep 5;
};

_sector setMarkerText _sectorName;
// Check Victory
if ([] call F_checkVictory) then {
	if (isServer) then {
		[] spawn blufor_victory;
	} else {
		[] remoteExec ["blufor_victory", 2];
	};
};

sleep 10;

// Attack finished
if (_sector in active_sectors) then {
	active_sectors = active_sectors - [_sector];
	publicVariable "active_sectors";
};

diag_log format ["End Defend Sector %1 at %2", _sector, time];

// Cleanup
waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_sector_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
diag_log format ["Cleanup Defend Sector %1 at %2", _sector, time];
{ deleteVehicle _x; sleep 0.05 } forEach _managed_units;
{ [_x] spawn clean_vehicle; sleep 0.05 } forEach _managed_vehicles;
[_sector_pos] call clearlandmines;
