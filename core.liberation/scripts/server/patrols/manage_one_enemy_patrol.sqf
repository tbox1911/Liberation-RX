params ["_readiness"];

private [
	"_usable_sectors",
	"_all_players",
	"_sector",
	"_player_nearby",
	"_dist",
	"_spawnsector",
	"_sector_pos",
	"_opfor_grp",
	"_opfor_veh",
	"_unit_ttl",
	"_unit_pos"
];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	sleep (300 + floor(random 300));
	while { opforcap > GRLIB_patrol_cap || (diag_fps < 35.0) || combat_readiness < _readiness } do {
		sleep 60;
	};

	_opfor_veh = objNull;
	_opfor_grp = grpNull;
	_usable_sectors = [];
	_all_players = (AllPlayers - (entities "HeadlessClient_F"));
	{
		_sector =_x;
		_player_nearby = {
			_dist = (_x distance2D (markerPos _sector));
			if (_dist > GRLIB_spawn_min && _dist < GRLIB_spawn_max ) exitWith {1};
		} count _all_players;

		if (_player_nearby > 0) then { _usable_sectors pushback _sector };
		sleep 0.1;
	} foreach (sectors_allSectors - active_sectors);

	if ( count _usable_sectors > 0 ) then {
		_sector_pos = markerPos (selectRandom _usable_sectors);
		// 50% in vehicles
		if ( floor random 100 > 50 && count militia_vehicles > 0 ) then {
			_opfor_veh = [_sector_pos, (selectRandom militia_vehicles)] call F_libSpawnVehicle;
			if !(isNull _opfor_veh) then {
				_opfor_grp = group (driver _opfor_veh);
				[_opfor_grp, _sector_pos] spawn add_civ_waypoints;
				{ _x setVariable ["GRLIB_mission_AI", true, true] } forEach (units _opfor_grp);
			};
		} else {
			_opfor_grp = [_sector_pos, (6 + floor random 6), "militia"] call createCustomGroup;
		};

		private _hc = [] call F_lessLoadedHC;
		if (!isNull _hc) then {
			_opfor_grp setGroupOwner (owner _hc);
		};

		// Wait
		_unit_ttl = round (time + 1800);
		_unit_pos = getPosATL (leader _opfor_grp);
		_radius = GRLIB_spawn_max * 2;
		waitUntil {
			if (alive (leader _opfor_grp)) then { _unit_pos = getPosATL (leader _opfor_grp) };
			sleep 60;
			(
				GRLIB_global_stop == 1 ||
				(diag_fps < 20) ||
				({alive _x} count (units _opfor_grp) < 2) ||
				([_unit_pos, _radius, GRLIB_side_friendly] call F_getUnitsCount == 0) ||
				(time > _unit_ttl)
			)
		};

		// Cleanup
		waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_unit_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
		if (isNull _opfor_veh) then {
			{ deleteVehicle _x } forEach (units _opfor_grp);
			deleteGroup _opfor_grp;
		} else {
			[_opfor_veh] call clean_vehicle;
		};
	};
};
