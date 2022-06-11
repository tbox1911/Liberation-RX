params [ "_sector" ];

waitUntil {
	sleep 1;
	!isNil "combat_readiness"
};

private _sectorpos = getMarkerPos _sector;
private _stopit = false;
private _spawncivs = false;
private _building_ai_max = 0;
private _infsquad = "csat";
private _building_range = 200;
private _local_capture_size = GRLIB_capture_size;
private _iedcount = 0;
private _vehtospawn = [];
private _managed_units = [];
private _squad1 = [];
private _squad2 = [];
private _squad3 = [];
private _squad4 = [];
private _minimum_building_positions = 5;
private _max_prisonners = 5;
private _sector_despawn_tickets = 24;
private _popfactor = 1.5;

if (GRLIB_unitcap < 1) then {
	_popfactor = GRLIB_unitcap;
};

if (isNil "active_sectors") then {
	active_sectors = []
};
if (_sector in active_sectors) exitWith {};
active_sectors pushback _sector;
publicVariable "active_sectors";

diag_log format ["Spawn Defend Sector %1 at %2", _sector, time];
private _opforcount = [] call F_opforCap;
sleep 10;

if ((!(_sector in blufor_sectors)) && ( ( [ getMarkerPos _sector, [ _opforcount ] call F_getCorrectedSectorRange, GRLIB_side_friendly ] call F_getUnitsCount ) > 0 )) then {
	if (_sector in sectors_bigtown) then {
		_vehtospawn =
		[ ([] call F_getAdaptiveVehicle),
			(selectRandom opfor_vehicles),
		(selectRandom opfor_vehicles)];
		_infsquad = "csat";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if (GRLIB_unitcap >= 1) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};
		if (GRLIB_unitcap >= 1.5) then {
			_squad4 = ([] call F_getAdaptiveSquadComp);
		};
		if (floor(random 100) > (66 / GRLIB_difficulty_modifier)) then {
			_vehtospawn pushBack (selectRandom opfor_vehicles);
		};
		if (floor(random 100) > (50 / GRLIB_difficulty_modifier)) then {
			_vehtospawn pushBack (selectRandom opfor_vehicles);
		};
		if (floor(random 100) > (33 / GRLIB_difficulty_modifier)) then {
			_vehtospawn pushBack ([] call F_getAdaptiveVehicle);
		};
		_spawncivs = true;

		_building_ai_max = round (15 * _popfactor);
		_building_range = 300;
		_local_capture_size = _local_capture_size * 1.4;
		_iedcount = (2 + (floor (random 4))) * GRLIB_difficulty_modifier;
		if (_iedcount > 10) then {
			_iedcount = 10
		};
	};

	if (_sector in sectors_capture) then {
		_vehtospawn = [];
		_infsquad = "csat";
		while { count _squad1 < (20 * _popfactor) } do {
			_squad1 pushBack (selectRandom militia_squad)
		};
		if (floor(random 100) > (66 / GRLIB_difficulty_modifier)) then {
			_vehtospawn pushBack (selectRandom opfor_vehicles);
		};
		if (floor(random 100) > (33 / GRLIB_difficulty_modifier)) then {
			_vehtospawn pushBack (selectRandom opfor_vehicles);
		};
		_spawncivs = true;
		_building_ai_max = round ((floor (10 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 200;
		_iedcount = (floor (random 4)) * GRLIB_difficulty_modifier;
		if (_iedcount > 7) then {
			_iedcount = 7
		};
	};

	if (_sector in sectors_military) then {
		_infsquad = "csat";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if (GRLIB_unitcap >= 1.5) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};
		if (GRLIB_unitcap >= 2) then {
			_squad4 = ([] call F_getAdaptiveSquadComp);
		};
		_vehtospawn = [([] call F_getAdaptiveVehicle ), ( [] call F_getAdaptiveVehicle)];
		if (floor(random 100) > (33 / GRLIB_difficulty_modifier)) then {
			_vehtospawn pushBack ([] call F_getAdaptiveVehicle);
		};
		if (floor(random 100) > (66 / GRLIB_difficulty_modifier)) then {
			_vehtospawn pushBack ([] call F_getAdaptiveVehicle);
		};
		_spawncivs = false;
		_building_ai_max = round ((floor (8 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 110;
	};

	if (_sector in sectors_factory) then {
		_vehtospawn = [];
		_infsquad = "csat";
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if (GRLIB_unitcap >= 1.25) then {
			_squad3 = ([] call F_getAdaptiveSquadComp);
		};
		if (floor(random 100) > 66) then {
			_vehtospawn pushBack ([] call F_getAdaptiveVehicle);
		};
		if (floor(random 100) > 33) then {
			_vehtospawn pushBack (selectRandom opfor_vehicles);
		};
		_spawncivs = false;
		_building_ai_max = round ((floor (10 + (round (combat_readiness / 10 )))) * _popfactor);
		_building_range = 100;
		_iedcount = (floor (random 3)) * GRLIB_difficulty_modifier;
		if (_iedcount > 5) then {
			_iedcount = 5
		};
	};

	if (_sector in sectors_tower) then {
		_spawncivs = false;
		_squad1 = ([] call F_getAdaptiveSquadComp);
		_squad2 = ([] call F_getAdaptiveSquadComp);
		if (GRLIB_unitcap >= 1.5) then {
			_squad2 = ([] call F_getAdaptiveSquadComp);
		};
		_building_ai_max = 0;
		if (floor(random 100) > 75) then {
			_vehtospawn pushBack ([] call F_getAdaptiveVehicle);
		};
		[markerPos _sector, 50] call createlandmines;
	};

	if (_building_ai_max > 0 && GRLIB_adaptive_opfor) then {
		_building_ai_max = round (_building_ai_max * ([] call F_adaptiveOpforFactor));
	};

	{
		_vehicle = [_sectorpos, _x] call F_libSpawnVehicle;
		[group ((crew _vehicle) select 0), _sectorpos] spawn add_defense_waypoints;
		_managed_units pushBack _vehicle;
		{
			_managed_units pushBack _x;
		} forEach (crew _vehicle);
		sleep 0.25;
	} forEach _vehtospawn;

	if (_building_ai_max > 0) then {
		_allbuildings = [ nearestObjects [_sectorpos, ["House"], _building_range ], {
			alive _x
		} ] call BIS_fnc_conditionalSelect;
		_buildingpositions = [];
		{
			_buildingpositions = _buildingpositions + ([_x] call BIS_fnc_buildingPositions);
		} forEach _allbuildings;
		if (count _buildingpositions > _minimum_building_positions) then {
			_managed_units = _managed_units + ([ _infsquad, _building_ai_max, _buildingpositions, _sectorpos, _sector ] call F_spawnBuildingSquad);
		};
	};

	_managed_units = _managed_units + ([ _sectorpos ] call F_spawnMilitaryPostSquad);

	if (count _squad1 > 0) then {
		_grp = [ _sector, _squad1 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if (count _squad2 > 0) then {
		_grp = [ _sector, _squad2 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if (count _squad3 > 0) then {
		_grp = [ _sector, _squad3 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if (count _squad4 > 0) then {
		_grp = [ _sector, _squad4 ] call F_spawnRegularSquad;
		[ _grp, _sectorpos ] spawn add_defense_waypoints;
		_managed_units = _managed_units + (units _grp);
	};

	if (_spawncivs && GRLIB_civilian_activity > 0) then {
		private _nbcivs = round ((4 + (floor (random 5))) * GRLIB_civilian_activity);
		if (_sector in sectors_bigtown) then {
			_nbcivs = _nbcivs + 10
		};
		_managed_units = _managed_units + ([ _sector, _nbcivs ] call F_spawnCivilians);
	};

	[ _sector, _building_range, _iedcount ] spawn ied_manager;

	sleep 10;

	if (_sector in sectors_factory + sectors_capture + sectors_bigtown + sectors_military) then {
		[ _sector ] spawn reinforcements_manager;
	};

	diag_log format ["Sector %1 wait attack to finish", _sector];
	while { !_stopit } do {
		if (([_sectorpos, _local_capture_size] call F_sectorOwnership == GRLIB_side_friendly) && (GRLIB_endgame == 0)) then {
			[ _sector ] spawn sector_liberated_remote_call;
			_stopit = true;
			_enemy_left = [allUnits, {
				(alive _x) && (vehicle _x == _x) && (side group _x == GRLIB_side_enemy) && (((getMarkerPos _sector) distance2D _x) < _local_capture_size * 1.2)
			}] call BIS_fnc_conditionalSelect;
			{
				if (_max_prisonners > 0 && ((random 100) < GRLIB_surrender_chance)) then {
					[_x] spawn prisonner_ai;
					_max_prisonners = _max_prisonners - 1;
				} else {
					if (((random 100) <= 50)) then {
						[_x] spawn bomber_ai
					};
				};
			} forEach _enemy_left;
			sleep 60;

			active_sectors = active_sectors - [ _sector ];
			publicVariable "active_sectors";
			{
				_x setVariable ["GRLIB_counter_TTL", 0]
			} forEach _managed_units;
		} else {
			if (([_sectorpos, (([_opforcount] call F_getCorrectedSectorRange) + 300), GRLIB_side_friendly] call F_getUnitsCount) == 0) then {
				_sector_despawn_tickets = _sector_despawn_tickets - 1;
			} else {
				_sector_despawn_tickets = 24;
			};

			if (_sector_despawn_tickets <= 0) then {
				// {
					deleteVehicle _x
				} forEach _managed_units;
				{
					if (_x isKindOf "Man") then {
						deleteVehicle _x;
					} else {
						if (count(crew _x) > 0) then {
							deleteVehicle _x
						};
					};
				} forEach _managed_units;
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
