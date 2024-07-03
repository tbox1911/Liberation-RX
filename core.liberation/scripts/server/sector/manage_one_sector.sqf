params [ "_sector" ];
active_sectors pushback _sector;
publicVariable "active_sectors";

private _sector_pos = markerPos _sector;
private _stopit = false;
private _spawncivs = false;
private _building_ai_max = 0;
private _building_range = 200;
private _local_capture_size = GRLIB_capture_size;
private _ied_count = 0;
private _static_count = 0;
private _vehtospawn = [];
private _vehicle = objNull;
private _grp = grpNull;
private _managed_units = [];
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
private _max_prisonners = 5;
private _sector_despawn_tickets = GRLIB_despawn_tickets;

private _active_players = count ([_sector_pos, (GRLIB_sector_size * 2)] call F_getNearbyPlayers);
diag_log format ["Spawn Defend Sector %1 - player in combat %2 / readiness %3 at %4", _sector, _active_players, combat_readiness, time];

if ( (!(_sector in blufor_sectors)) && (([_sector_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount) > 0)) then {

	if ( _sector in sectors_bigtown ) then {
		_vehtospawn = [([] call F_getAdaptiveVehicle), (selectRandom militia_vehicles), (selectRandom militia_vehicles)];
		while { count _squad1 < 10 } do { _squad1 pushback (selectRandom militia_squad) };
		while { count _squad2 < 8 } do { _squad2 pushback (selectRandom militia_squad) };
		if (combat_readiness >= 60) then { _squad3 = ([] call F_getAdaptiveSquadComp) };
		if (_active_players > 2) then { _squad4 = ([] call F_getAdaptiveSquadComp) };
		if (_active_players > 4) then { _squad5 = ([] call F_getAdaptiveSquadComp) };
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles) };
		if(floor(random 100) > (50 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles) };
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback ([] call F_getAdaptiveVehicle) };
		_spawncivs = true;
		_building_ai_max = 12;
		_building_range = 300;
		_local_capture_size = _local_capture_size * 1.4;
		_ied_count = (4 + (floor (random 5)));
	};

	if ( _sector in sectors_capture ) then {
		while { count _squad1 < 12 } do { _squad1 pushback (selectRandom militia_squad) };
		if (combat_readiness >= 50) then { while { count _squad2 < 8 } do { _squad2 pushback (selectRandom militia_squad)} };
		if (combat_readiness >= 70) then { while { count _squad3 < 8 } do { _squad3 pushback (selectRandom militia_squad)}; _infsquad3 = "militia" };
		if (_active_players > 2) then { while { count _squad4 < 8 } do { _squad4 pushback (selectRandom militia_squad)}; _infsquad4 = "militia"};
		if (_active_players > 4) then { _squad5 = ([] call F_getAdaptiveSquadComp) };
		_vehtospawn pushback (selectRandom militia_vehicles);
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		_spawncivs = true;
		_building_ai_max = 6;
		_building_range = 200;
		_ied_count = (3 + (floor (random 4)));
	};

	if ( _sector in sectors_military ) then {
		_infsquad1 = "infantry";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_infsquad2 = "infantry";
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if (combat_readiness >= 70) then { _squad3 = ([] call F_getAdaptiveSquadComp) };
		if (_active_players > 2) then { _squad4 = ([] call F_getAdaptiveSquadComp) };
		if (_active_players > 4) then { _squad5 = ([] call F_getAdaptiveSquadComp) };
		_vehtospawn = [([] call F_getAdaptiveVehicle), ([] call F_getAdaptiveVehicle)];
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback ([] call F_getAdaptiveVehicle) };
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback ([] call F_getAdaptiveVehicle) };
		_spawncivs = false;
		_building_ai_max = 6;
		_building_range = 150;
		_ied_count = (3 + (floor (random 3)));
		_static_count = 3;
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
		_ied_count = 4;
	};

	if ( _sector in sectors_factory ) then {
		while { count _squad1 < 10 } do { _squad1 pushback (selectRandom militia_squad) };
		_infsquad2 = "infantry";
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if (combat_readiness >= 70) then { _squad3 = ([] call F_getAdaptiveSquadComp) };
		if (_active_players > 2) then { _squad4 = ([] call F_getAdaptiveSquadComp) };
		if (_active_players > 4) then { _squad5 = ([] call F_getAdaptiveSquadComp) };
		_vehtospawn pushback (selectRandom militia_vehicles);
		if(floor(random 100) > 33) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		if(floor(random 100) > 66) then { _vehtospawn pushback ([] call F_getAdaptiveVehicle) };
		_spawncivs = true;
		_building_ai_max = 6;
		_building_range = 100;
		_ied_count = (3 + (floor (random 3)));
	};

	if ( _sector in sectors_tower ) then {
		_spawncivs = false;
		_infsquad1 = "infantry";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_infsquad2 = "infantry";
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if (combat_readiness >= 70) then { _squad3 = ([] call F_getAdaptiveSquadComp) };
		if (_active_players > 2) then { _squad4 = ([] call F_getAdaptiveSquadComp) };
		_building_ai_max = 4;
		if(floor(random 100) > 75) then { _vehtospawn pushback ([] call F_getAdaptiveVehicle) };
		[_sector_pos, 50] call createlandmines;
		_static_count = 4;
	};

	if ( opforcap >= GRLIB_opfor_cap ) then { _vehtospawn = [] };
	if ( count _vehtospawn > 0 ) then {
		{
			private _spawn_pos = _sector_pos getPos [2 + (floor random 125), random 360];
			_vehicle = [_spawn_pos, _x] call F_libSpawnVehicle;
			if (!isNull _vehicle) then {
				[group (driver _vehicle), _spawn_pos, (50 + floor random 60)] spawn defence_ai;
				_managed_units pushback _vehicle;
				{ _managed_units pushback _x } foreach (crew _vehicle);
				sleep 2;
			};
		} foreach _vehtospawn;
	} else {
		if (count _squad1 == 0) then { _squad1 = ([] call F_getAdaptiveSquadComp) };
		if (count _squad2 == 0) then { _squad2 = ([] call F_getAdaptiveSquadComp) };
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then {
			if (count _squad3 == 0) then { _squad3 = ([] call F_getAdaptiveSquadComp) };
		};
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then {
			if (count _squad4 == 0) then { _squad4 = ([] call F_getAdaptiveSquadComp) };
		};
	};

	if ( opforcap >= GRLIB_opfor_cap ) then { _building_ai_max = 0 };
	if ( _building_ai_max > 0 ) then {
		_building_ai_max = (_building_ai_max * GRLIB_building_ai_ratio);
		_managed_units = _managed_units + ([_infsquad1, _building_ai_max, _sector_pos, _building_range] call F_spawnBuildingSquad);
		sleep 2;
	};

	if ( count _squad1 > 0 ) then {
		_grp = [ _sector, _infsquad1, _squad1 ] call F_spawnRegularSquad;
		[ _grp, _sector_pos, 50 ] spawn defence_ai;
		_managed_units = _managed_units + (units _grp);
		sleep 2;
	};

	if ( count _squad2 > 0 ) then {
		_grp = [ _sector, _infsquad2, _squad2 ] call F_spawnRegularSquad;
		[ _grp, _sector_pos, 100 ] spawn defence_ai;
		_managed_units = _managed_units + (units _grp);
		sleep 2;
	};

	if ( count _squad3 > 0 ) then {
		_grp = [ _sector, _infsquad3, _squad3 ] call F_spawnRegularSquad;
		[ _grp, _sector_pos, 100 ] spawn defence_ai;
		_managed_units = _managed_units + (units _grp);
		sleep 2;
	};

	if ( count _squad4 > 0 ) then {
		_grp = [ _sector, _infsquad4, _squad4 ] call F_spawnRegularSquad;
		[ _grp, _sector_pos, 200 ] spawn defence_ai;
		_managed_units = _managed_units + (units _grp);
		sleep 2;
	};

	if ( count _squad5 > 0 ) then {
		_grp = [ _sector, _infsquad5, _squad5 ] call F_spawnRegularSquad;
		[ _grp, _sector_pos, 300 ] spawn defence_ai;
		_managed_units = _managed_units + (units _grp);
		sleep 2;
	};

	if ( _spawncivs && GRLIB_civilian_activity > 0) then {
		private _nbcivs = round ((6 + (floor random 8)) * GRLIB_civilian_activity);
		private _rndciv = [1,1,1,1,2,3];
		if ( _sector in sectors_bigtown ) then { _nbcivs = _nbcivs + 12 };
		while { _nbcivs > 0 } do {
			_maxcivs = (selectRandom _rndciv) min _nbcivs;
			_grp = [_sector_pos, _maxcivs] call F_spawnCivilians;
			_managed_units = _managed_units + (units _grp);
			_nbcivs = _nbcivs - _maxcivs;
			sleep 0.2;
		};
	};

	if (floor random 100 < combat_readiness) then {
		private _pilots = allPlayers select { (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x };
		if (count _pilots > 0 ) then {
			[getPosATL (selectRandom _pilots), GRLIB_side_enemy, 3] spawn spawn_air;
		} else {
			[_sector_pos] spawn send_paratroopers;
		};
	};

	[_sector, _static_count] spawn static_manager;
	[_sector, _building_range, round (_ied_count)] spawn ied_manager;
	[_sector, _building_range, round (_ied_count)] spawn ied_trap_manager;

	[ _sector_pos ] spawn {
		params ["_pos"];
		sleep (300 + floor(random 120));
		if (([_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount) == 0) exitWith {};
		if ( combat_readiness > 50 ) then { 
			if (floor random 2 == 0) then {
				[_pos, true] spawn send_paratroopers;
			} else {
				[_pos, GRLIB_side_enemy, 2] spawn spawn_air;
			};			
		};
		sleep 100;
		if (([_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount) == 0) exitWith {};
		if ( combat_readiness > 70 ) then {
			[_pos, GRLIB_side_enemy, 2] spawn spawn_air;
			sleep 20;
			if (floor random 2 == 0) then {
				[_pos, true] spawn send_paratroopers;
			} else {
				[_pos] spawn spawn_halo_vehicle;
			};
		};
	};

	private _building_alive = count ((nearestObjects [_sector_pos, ["House"], _local_capture_size]) select { alive _x && !([_x, GRLIB_ignore_colisions] call F_itemIsInClass) });
	diag_log format ["Sector %1 wait attack to finish", _sector];
	sleep 3;

	private ["_sector_ownership", "_sector_objective"];
	while { !_stopit } do {
		_sector_ownership = [_sector_pos, _local_capture_size] call F_sectorOwnership;
		_sector_objective = true;
		if (_sector in sectors_tower) then {
			private _towers = { (alive _x) && (_x getVariable ['GRLIB_Radio_Tower', false]) } count (nearestObjects [_sector_pos, [Radio_tower], 20]);
			if (_towers > 0) then { _sector_objective = false };
		};

		if (_sector_ownership == GRLIB_side_friendly && _sector_objective) then {
			[_sector] remoteExec ["sector_liberated_remote_call", 2];
			_stopit = true;
			private _enemy_left = (_sector_pos nearEntities ["CAManBase", _local_capture_size * 1.2]);
			_enemy_left = _enemy_left select { (side _x == GRLIB_side_enemy) && (isNull objectParent _x) };
			{
				if ( _max_prisonners > 0 && ((floor random 100) < GRLIB_surrender_chance) ) then {
					[_x] spawn prisoner_ai;
					_max_prisonners = _max_prisonners - 1;
					_managed_units = _managed_units - [_x];
				} else {
					if ( ((random 100) <= 50) ) then {
						[_x] spawn bomber_ai;
					};
				};
				sleep 0.5;
			} foreach _enemy_left;
			if !(_sector in sectors_military + sectors_tower) then {
				private _building_destroyed = _building_alive - count ((nearestObjects [_sector_pos, ["House"], _local_capture_size]) select { alive _x });
				if (_building_destroyed > 0) then {
					[_sector, 4, _building_destroyed] remoteExec ["remote_call_sector", 0];
					{ [_x, -(_building_destroyed * 3)] call F_addReput } forEach ([_sector_pos, _local_capture_size] call F_getNearbyPlayers);
				};
			};
			sleep 60;
		} else {
			if ( ([_sector_pos, (GRLIB_sector_size + 300), GRLIB_side_friendly] call F_getUnitsCount) == 0 ) then {
				_sector_despawn_tickets = _sector_despawn_tickets - 1;
			} else {
				_sector_despawn_tickets = GRLIB_despawn_tickets;
			};

			if ( _sector_despawn_tickets <= 1 ) then {
				_stopit = true;
			};
		};
		sleep 5;
	};
} else {
	sleep 40;
};

active_sectors = active_sectors - [_sector];
publicVariable "active_sectors";
diag_log format ["End Defend Sector %1 at %2", _sector, time];

// Cleanup
waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_sector_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
diag_log format ["Cleanup Defend Sector %1 at %2", _sector, time];
{
	if (_x isKindOf "CAManBase") then {
		deleteVehicle _x;
	} else {
		[_x] call clean_vehicle;
	};
} forEach _managed_units;
[_sector_pos] call clearlandmines;
