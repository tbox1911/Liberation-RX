params [ "_sector" ];

active_sectors pushback _sector;
publicVariable "active_sectors";

private _sectorpos = getmarkerpos _sector;
private _stopit = false;
private _spawncivs = false;
private _building_ai_max = 0;
private _infsquad = "militia";
private _building_range = 200;
private _local_capture_size = GRLIB_capture_size;
private _iedcount = 0;
private _defensecount = 0;
private _vehtospawn = [];
private _managed_units = [];
private _squad1 = [];
private _squad2 = [];
private _squad3 = [];
private _squad4 = [];
private _minimum_building_positions = 5;
private _max_prisonners = 5;
private _sector_despawn_tickets = 24;
private _popfactor = 1;

diag_log format ["Spawn Defend Sector %1 at %2", _sector, time];

if ( GRLIB_adaptive_opfor ) then {
	private _active_players = count ([getmarkerpos _sector, GRLIB_sector_size] call F_getNearbyPlayers);
	switch (true) do {
		case (_active_players > 6) : { _popfactor = 1.4 };
		case (_active_players > 4) : { _popfactor = 1.3 };
		case (_active_players > 2) : { _popfactor = 1.2 };
		case (_active_players > 1) : { _popfactor = 1.1 };
		default { _popfactor = GRLIB_unitcap };
	};
};

if ( (!(_sector in blufor_sectors)) &&  ( ( [getmarkerpos _sector , GRLIB_sector_size, GRLIB_side_friendly ] call F_getUnitsCount ) > 0 ) ) then {

	if ( _sector in sectors_bigtown ) then {
		_vehtospawn =
		[ ( [] call F_getAdaptiveVehicle ) ,
		(selectRandom militia_vehicles),
		(selectRandom militia_vehicles)];
		_infsquad = "militia";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if ( GRLIB_unitcap >= 1) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};
		if ( GRLIB_unitcap >= 1.5) then {
			_squad4 = ([] call F_getAdaptiveSquadComp);
		};
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		if(floor(random 100) > (50 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback ( [] call F_getAdaptiveVehicle ); };
		_spawncivs = true;

		_building_ai_max = round (15 * _popfactor) ;
		_building_range = 300;
		_local_capture_size = _local_capture_size * 1.4;
		_iedcount = (3 + (floor (random 4))) * GRLIB_difficulty_modifier;
		if ( _iedcount > 10 ) then { _iedcount = 10 };
	};

	if ( _sector in sectors_capture ) then {
		_vehtospawn = [];
		_infsquad = "militia";
		while { count _squad1 < ( 20 * _popfactor) } do { _squad1 pushback ( selectRandom militia_squad ) };
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		_spawncivs = true;
		_building_ai_max = round ((floor (10 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 200;
		_iedcount = (floor (random 5)) * GRLIB_difficulty_modifier;
		if ( _iedcount > 7 ) then { _iedcount = 7 };
	};

	if ( _sector in sectors_military ) then {
		_infsquad = "csat";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if ( GRLIB_unitcap >= 1.5) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};
		if ( GRLIB_unitcap >= 2) then {
			_squad4 = ([] call F_getAdaptiveSquadComp);
		};
		_vehtospawn = [( [] call F_getAdaptiveVehicle ),( [] call F_getAdaptiveVehicle )];
		if(floor(random 100) > (33 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback ( [] call F_getAdaptiveVehicle ); };
		if(floor(random 100) > (66 / GRLIB_difficulty_modifier)) then { _vehtospawn pushback ( [] call F_getAdaptiveVehicle ); };
		_spawncivs = false;
		_building_ai_max = round ((floor (8 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 110;
		_defensecount = 3;
		[_sector] spawn {
			params ["_sector"];
			private _pos = markerPos [_sector, true];
			private _sound = "A3\data_f_curator\sound\cfgsounds\air_raid.wss";
			while { _sector in active_sectors } do {
				for "_i" from 0 to (floor(random 4)) do {
					playSound3D [_sound, _pos, false, AGLToASL _pos, 5, 1, 1000];
					sleep (5 + floor(random 4));
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
		if ( GRLIB_unitcap >= 1.25) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};
		if(floor(random 100) > 66) then { _vehtospawn pushback ( [] call F_getAdaptiveVehicle ); };
		if(floor(random 100) > 33) then { _vehtospawn pushback (selectRandom militia_vehicles); };
		_spawncivs = true;
		_building_ai_max = round ((floor (10 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 100;
		_iedcount = (floor (random 4)) * GRLIB_difficulty_modifier;
		if ( _iedcount > 5 ) then { _iedcount = 5 };
	};

	if ( _sector in sectors_tower ) then {
		_spawncivs = false;
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if ( GRLIB_unitcap >= 1.5) then {
			_squad2 = ([] call F_getAdaptiveSquadComp);
		};
		_building_ai_max = 0;
		if(floor(random 100) > 75) then { _vehtospawn pushback ( [] call F_getAdaptiveVehicle ); };
		[markerPos _sector, 50] call createlandmines;
		_defensecount = 4;
	};

	if ( _building_ai_max > 0 && GRLIB_adaptive_opfor ) then {
		_building_ai_max = round ( _building_ai_max * ([] call F_adaptiveOpforFactor));
	};

	{
		_vehicle = [_sectorpos, _x] call F_libSpawnVehicle;
		[group ((crew _vehicle) select 0), _sectorpos] spawn add_defense_waypoints;
		_managed_units pushback _vehicle;
		{ _managed_units pushback _x } foreach (crew _vehicle);
	} foreach _vehtospawn;

	if ( _building_ai_max > 0 ) then {
		_allbuildings = [ nearestObjects [_sectorpos, ["House"], _building_range ], { alive _x } ] call BIS_fnc_conditionalSelect;
		_buildingpositions = [];
		{
			_buildingpositions = _buildingpositions + ( [_x] call BIS_fnc_buildingPositions );
		} foreach _allbuildings;
		if ( count _buildingpositions > _minimum_building_positions ) then {
			_managed_units = _managed_units + ( [ _infsquad, _building_ai_max, _buildingpositions, _sectorpos, _sector ] call F_spawnBuildingSquad );
		};
	};

	_managed_units = _managed_units + ([_sectorpos] call F_spawnMilitaryPostSquad);

	if ( count _squad1 > 0 ) then {
		_grp = [ _sector, _infsquad, _squad1 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos, 100 ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( count _squad2 > 0 ) then {
		_grp = [ _sector, _infsquad, _squad2 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos, 200 ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( count _squad3 > 0 ) then {
		_grp = [ _sector, _infsquad, _squad3 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos, 300 ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( count _squad4 > 0 ) then {
		_grp = [ _sector, _infsquad, _squad4 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos, 400 ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if ( _spawncivs && GRLIB_civilian_activity > 0) then {
		private _nbcivs = round ((5 + (floor (random 5))) * GRLIB_civilian_activity);
		if ( _sector in sectors_bigtown ) then { _nbcivs = _nbcivs + 10 };
		for "_i" from 1 to _nbcivs do {
			_grp = [_sector] call F_spawnCivilians;
			[_grp] spawn add_civ_waypoints;
			_managed_units = _managed_units + (units _grp);
		};
	};

	[ _sector, _defensecount ] spawn static_manager;
	[ markerPos _sector, _building_range, round (_iedcount) ] spawn ied_manager;
	[ markerPos _sector, _building_range, round (_iedcount) ] spawn ied_trap_manager;
	[ _sector ] spawn reinforcements_manager;
	sleep 10;

	diag_log format ["Sector %1 wait attack to finish", _sector];
	while { !_stopit } do {

		if ([_sectorpos, _local_capture_size] call F_sectorOwnership == GRLIB_side_friendly) then {
			[ _sector ] spawn sector_liberated_remote_call;
			_stopit = true;
			_enemy_left = [units GRLIB_side_enemy, {(alive _x) && (vehicle _x == _x) && !(_x getVariable ["GRLIB_mission_AI", false]) && (((getmarkerpos _sector) distance2D _x) < _local_capture_size * 1.2)}] call BIS_fnc_conditionalSelect;
			{
				if ( _max_prisonners > 0 && ((random 100) < GRLIB_surrender_chance) ) then {
					[_x] spawn prisonner_ai;
					_max_prisonners = _max_prisonners - 1;
				} else {
					if ( ((random 100) <= 50) ) then { [_x] spawn bomber_ai };
				};
			} foreach _enemy_left;
			sleep 60;

			active_sectors = active_sectors - [ _sector ];
			publicVariable "active_sectors";
			[ _sector ] spawn reinforcements_manager;
		} else {
			if ( ([_sectorpos, (GRLIB_sector_size + 300), GRLIB_side_friendly] call F_getUnitsCount) == 0 ) then {
				_sector_despawn_tickets = _sector_despawn_tickets - 1;
			} else {
				_sector_despawn_tickets = 24;
			};

			if ( _sector_despawn_tickets <= 0 ) then {
				_stopit = true;
				active_sectors = active_sectors - [ _sector ];
				publicVariable "active_sectors";
			};
		};
		sleep 5;
	};
} else {
	sleep 40;
	active_sectors = active_sectors - [ _sector ];
	publicVariable "active_sectors";
};

diag_log format ["End Defend Sector %1 at %2", _sector, time];

// Cleanup
waitUntil { sleep 10; [markerpos _sector, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0 };
{
	if (_x isKindOf "CAManBase") then {
		deleteVehicle _x;
	} else {
		[_x] spawn clean_vehicle;
	};
} foreach _managed_units;