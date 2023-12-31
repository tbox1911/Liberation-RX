params [ "_sector" ];

waitUntil {sleep 0.5; !GRLIB_GC_Running };
active_sectors pushback _sector;
publicVariable "active_sectors";

private _sectorpos = markerPos _sector;
private _stopit = false;
private _spawncivs = false;
private _building_ai_max = 0;
private _infsquad = "militia";
private _building_range = 200;
private _local_capture_size = GRLIB_capture_size;
private _iedcount = 0;
private _defensecount = 0;
private _vehtospawn = [];
private _vehicle = objNull;
private _grp = grpNull;
private _managed_units = [];
private _squad1 = [];
private _squad2 = [];
private _squad3 = [];
private _squad4 = [];
private _squad5 = [];
private _minimum_building_positions = 5;
private _max_prisonners = 5;
private _sector_despawn_tickets = GRLIB_despawn_tickets;
private _popfactor = 1;

diag_log format ["Spawn Defend Sector %1 at %2", _sector, time];

if (GRLIB_adaptive_opfor) then {
	private _active_players = count ([_sectorpos, GRLIB_sector_size] call F_getNearbyPlayers);
	switch (true) do {
		case (_active_players > 6) : { _popfactor = 1.8 };
		case (_active_players > 4) : { _popfactor = 1.6 };
		case (_active_players > 2) : { _popfactor = 1.4 };
		case (_active_players > 1) : { _popfactor = 1.2 };
		default { _popfactor = 1 };
	};
	if (GRLIB_difficulty_modifier > 1.5 && count (entities "HeadlessClient_F") > 1) then {
		_popfactor = _popfactor + 0.45;
	};
};

if ( (!(_sector in blufor_sectors)) && (([_sectorpos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount) > 0)) then {

	if ( _sector in sectors_bigtown ) then {
		_vehtospawn = [([] call F_getAdaptiveVehicle), (selectRandom militia_vehicles), (selectRandom militia_vehicles)];
		_infsquad = "militia";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if (combat_readiness >= 70) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};
		if (GRLIB_unitcap >= 1) then {
			_squad4 = ([] call F_getAdaptiveSquadComp);
		};
		if (GRLIB_unitcap >= 1.5) then {
			_squad5 = ([] call F_getAdaptiveSquadComp);
		};
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles) };
		if(floor(random 100) > (50 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles) };
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback ([] call F_getAdaptiveVehicle) };
		_spawncivs = true;

		_defensecount = 2;
		_building_ai_max = round (15 * _popfactor) ;
		_building_range = 300;
		_local_capture_size = _local_capture_size * 1.4;
		_iedcount = (5 + (floor (random 6))) * GRLIB_difficulty_modifier;
		if ( _iedcount > 10 ) then { _iedcount = 10 };
	};

	if ( _sector in sectors_capture ) then {
		_vehtospawn = [];
		_infsquad = "militia";
		while { count _squad1 < ( 20 * _popfactor) } do { _squad1 pushback (selectRandom militia_squad) };
		if (combat_readiness >= 50) then {
			while { count _squad2 < ( 15 * _popfactor) } do { _squad2 pushback (selectRandom militia_squad) };
		};
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		_spawncivs = true;
		_building_ai_max = round ((floor (10 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 200;
		_iedcount = (4 + (floor (random 3))) * GRLIB_difficulty_modifier;
		if ( _iedcount > 7 ) then { _iedcount = 7 };
	};

	if ( _sector in sectors_military ) then {
		_infsquad = "csat";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if (combat_readiness >= 70) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};		
		if (GRLIB_unitcap >= 1.5) then {
			_squad4 = ([] call F_getAdaptiveSquadComp);
		};
		if (GRLIB_unitcap >= 2) then {
			_squad5 = ([] call F_getAdaptiveSquadComp);
		};
		_vehtospawn = [([] call F_getAdaptiveVehicle),([] call F_getAdaptiveVehicle)];
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback ([] call F_getAdaptiveVehicle) };
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback ([] call F_getAdaptiveVehicle) };
		_spawncivs = false;
		_building_ai_max = round ((floor (8 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 150;
		_defensecount = 3;
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

	if ( _sector in sectors_factory ) then {
		_vehtospawn = [];
		_infsquad = "militia";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if (combat_readiness >= 70) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};		
		if (GRLIB_unitcap >= 1.25) then {
			_squad4 = ([] call F_getAdaptiveSquadComp);
		};
		if(floor(random 100) > 33) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		if(floor(random 100) > 66) then { _vehtospawn pushback ([] call F_getAdaptiveVehicle) };
		_spawncivs = true;
		_building_ai_max = round ((floor (10 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 100;
		_iedcount = (3 + (floor (random 4))) * GRLIB_difficulty_modifier;
		if ( _iedcount > 5 ) then { _iedcount = 5 };
	};

	if ( _sector in sectors_tower ) then {
		_spawncivs = false;
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if (combat_readiness >= 70) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};		
		if (GRLIB_unitcap >= 1.5) then {
			_squad2 = ([] call F_getAdaptiveSquadComp);
		};
		_building_ai_max = 0;
		if(floor(random 100) > 75) then { _vehtospawn pushback ([] call F_getAdaptiveVehicle) };
		[_sectorpos, 50] call createlandmines;
		_defensecount = 4;
	};

	if ( _building_ai_max > 0 && GRLIB_adaptive_opfor ) then {
		_building_ai_max = round ( _building_ai_max * _popfactor);
	};

	if (count _vehtospawn > 0) then {
		{
			_vehicle = [_sectorpos, _x] call F_libSpawnVehicle;
			[group ((crew _vehicle) select 0), _sectorpos] spawn add_defense_waypoints;
			_managed_units pushback _vehicle;
			{ _managed_units pushback _x } foreach (crew _vehicle);
		} foreach _vehtospawn;
	} else {
		if (count _squad1 == 0) then { _squad1 = ([] call F_getAdaptiveSquadComp) };
		if (count _squad2 == 0) then { _squad2 = ([] call F_getAdaptiveSquadComp) };
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then {
			if (count _squad4 == 0) then { _squad4 = ([] call F_getAdaptiveSquadComp) };
		};
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then {
			if (count _squad5 == 0) then { _squad5 = ([] call F_getAdaptiveSquadComp) };
		};
	};

	if ( _building_ai_max > 0 ) then {
		private _allbuildings = (nearestObjects [_sectorpos, ["House"], _building_range]) select {alive _x};
		private _buildingpositions = [];
		{
			_buildingpositions = _buildingpositions + ([_x] call BIS_fnc_buildingPositions);
		} foreach _allbuildings;
		if ( count _buildingpositions > _minimum_building_positions ) then {
			_managed_units = _managed_units + ([_infsquad, _building_ai_max, _buildingpositions, _sectorpos, _sector] call F_spawnBuildingSquad);
		};
	};

	_managed_units = _managed_units + ([_sectorpos] call F_spawnMilitaryPostSquad);

	if ( count _squad1 > 0 ) then {
		_grp = [ _sector, _infsquad, _squad1 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos, 50 ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( count _squad2 > 0 ) then {
		_grp = [ _sector, _infsquad, _squad2 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos, 100 ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( count _squad3 > 0 ) then {
		_grp = [ _sector, _infsquad, _squad3 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos, 100 ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( count _squad4 > 0 ) then {
		_grp = [ _sector, _infsquad, _squad4 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos, 200 ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( count _squad5 > 0 ) then {
		_grp = [ _sector, _infsquad, _squad5 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos, 300 ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( _spawncivs && GRLIB_civilian_activity > 0) then {
		private _nbcivs = round ((6 + (floor random 8)) * GRLIB_civilian_activity);
		if ( _sector in sectors_bigtown ) then { _nbcivs = _nbcivs + 12 };
		while { _nbcivs > 0 } do {
			_maxcivs = (1 + floor random 3) min _nbcivs;
			_grp = [_sectorpos, _maxcivs] call F_spawnCivilians;
			[_grp, _sectorpos] spawn add_civ_waypoints;
			_managed_units = _managed_units + (units _grp);
			_nbcivs = _nbcivs - _maxcivs;
		};
	};

	if (floor random 100 < combat_readiness) then {
		private _pilots = allPlayers select { (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x };
		if (count _pilots > 0 ) then {
			[getPosATL (selectRandom _pilots), GRLIB_side_enemy, 3] spawn spawn_air;
		};
	};

	[_sector, _defensecount] spawn static_manager;
	[_sector, _building_range, round (_iedcount)] spawn ied_manager;
	[_sector, _building_range, round (_iedcount)] spawn ied_trap_manager;

	[ _sectorpos ] spawn {
		params ["_pos"];
		sleep (300 + floor(random 60));
		if (([_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount) == 0) exitWith {};
		if ( combat_readiness > 50 ) then { [_pos, true] spawn send_paratroopers };
		sleep 100;
		if (([_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount) == 0) exitWith {};
		if ( combat_readiness > 80 ) then { [_pos, true] spawn send_paratroopers };
	};

	diag_log format ["Sector %1 wait attack to finish", _sector];
	while { !_stopit } do {
		_sector_ownership = [_sectorpos, _local_capture_size] call F_sectorOwnership;
		if (_sector_ownership == GRLIB_side_friendly) then {
			[_sector] remoteExec ["sector_liberated_remote_call", 2];
			_stopit = true;
			private _enemy_left = (units GRLIB_side_enemy) select {(alive _x) && (isNull objectParent _x) && ((_x distance2D _sectorpos) < _local_capture_size * 1.2)};
			{
				if ( _max_prisonners > 0 && ((floor random 100) < GRLIB_surrender_chance) ) then {
					[_x] spawn prisoner_ai;
					_max_prisonners = _max_prisonners - 1;
					_managed_units = _managed_units - [_x];
				} else {
					if ( ((random 100) <= 50) ) then { [_x] spawn bomber_ai };
				};
			} foreach _enemy_left;
			sleep 60;
		} else {
			if ( ([_sectorpos, (GRLIB_sector_size + 300), GRLIB_side_friendly] call F_getUnitsCount) == 0 ) then {
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
waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_sectorpos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
diag_log format ["Cleanup Defend Sector %1 at %2", _sector, time];
{
	if (_x isKindOf "CAManBase") then {
		deleteVehicle _x;
	} else {
		[_x] call clean_vehicle;
	};
} forEach _managed_units;
