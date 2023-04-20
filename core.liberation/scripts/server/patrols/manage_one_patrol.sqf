params [ "_minimum_readiness", "_patrol_type", "_index" ];
waitUntil { !isNil "blufor_sectors" };
waitUntil { !isNil "combat_readiness" };

private [ "_grp", "_spawn_marker", "_headless_client", "_unit", "_vehicle_object", "_sectorpos", "_spawnpos" ];

while { GRLIB_endgame == 0 } do {
	waitUntil { sleep 1; count blufor_sectors >= 3; };
	waitUntil { sleep 1; combat_readiness >= (_minimum_readiness / GRLIB_difficulty_modifier); };

	sleep ((1 + random 5) * 60);

	while { [] call F_opforCap > GRLIB_patrol_cap || diag_fps < 25.0 } do {
		sleep (30 + floor(random 30));
	};

	while { (count sectors_allSectors - count blufor_sectors) < ((_index + 1) * 2) } do {
		sleep (150 + floor(random 150));
	};

	_spawn_marker = "";
	while { _spawn_marker == "" } do {
		_spawn_marker = [GRLIB_spawn_min, GRLIB_spawn_max, true] call F_findOpforSpawnPoint;
		if ( _spawn_marker == "" ) then { sleep (150 + floor(random 150)) };
	};

	_grp = grpNull;
	_spawnpos = [];
	while { count _spawnpos == 0 } do {
		_sectorpos = [ getMarkerPos _spawn_marker, floor(random 100), random 360 ] call BIS_fnc_relPos;
		_spawnpos = [4, _sectorpos, 200, 30, false] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol;
		if ( count _spawnpos == 0 ) then { sleep 30 };
	};

	if (_patrol_type == 1) then {
		_grp = [_spawnpos, ([] call F_getAdaptiveSquadComp), GRLIB_side_enemy, "infantry"] call F_libSpawnUnits;
		diag_log format [ "Spawn Infantry Patrol on sector %1 at %2", _spawn_marker, time ];
	};

	if (_patrol_type == 2) then {
		if (combat_readiness > 75 && floor(random 100) > 70) then {
			_vehicle_object = [ _spawnpos, selectRandom opfor_air ] call F_libSpawnVehicle;
		} else {
			_vehicle_object = [ _spawnpos, [] call F_getAdaptiveVehicle ] call F_libSpawnVehicle;
		};
		sleep 0.5;
		_grp = group ((crew _vehicle_object) select 0);
		diag_log format [ "Spawn Armored Patrol on sector %1 at %2", _spawn_marker, time ];
	};

	if (_patrol_type == 3) then {
		_opfor_spawn = [sectors_tower + sectors_military, {!( _x in blufor_sectors) && ([GRLIB_spawn_max, markerPos _x, blufor_sectors] call F_getNearestSector != "")}] call BIS_fnc_conditionalSelect;
		if ( count _opfor_spawn > 0) then {
			_grp = createGroup [GRLIB_side_enemy, true];
			_spawn_sector = selectRandom _opfor_spawn;
			_spawn_pos = [ getMarkerPos _spawn_sector, floor(random 50), random 360 ] call BIS_fnc_relPos;
			_vehicle_object = [ _spawn_pos, selectRandom opfor_statics ] call F_libSpawnVehicle;
			_grp_veh = group _vehicle_object;
			[_vehicle_object] spawn protect_static;
			opfor_spotter createUnit [ getposATL _vehicle_object, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "PRIVATE"];
			opfor_spotter createUnit [ getposATL _vehicle_object, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "PRIVATE"];
 			(units _grp_veh) joinSilent _grp;
			{ _x setVariable ["OPFor_vehicle", _vehicle_object] } forEach units _grp;
			diag_log format [ "Spawn Static Patrol on sector %1 at %2", _spawn_sector, time ];
		};
	};

	sleep 1;
	if (!isNil "_grp") then {
		[_grp, _patrol_type] spawn patrol_ai;
		sleep 1;
		_started_time = time;
		_patrol_continue = true;

		if ( local _grp ) then {
			_headless_client = [] call F_lessLoadedHC;
			if ( !isNull _headless_client ) then {
				_grp setGroupOwner ( owner _headless_client );
			};
		};

		while { _patrol_continue } do {
			sleep 60;
			if ( count (units _grp) == 0 ) then {
				_patrol_continue = false;
			} else {
				if ( time - _started_time > 900 ) then {
					if ( [ getpos (leader _grp) , (GRLIB_sector_size * 2) , GRLIB_side_friendly ] call F_getUnitsCount == 0 ) then {
						_patrol_continue = false;
						{
							if ( vehicle _x != _x ) then {
								deleteVehicle (vehicle _x);
								//(vehicle _x) setVariable ["GRLIB_counter_TTL", 0];
							};
							deleteVehicle _x;
						} foreach (units _grp);
						deleteGroup _grp;
					};
				};
			};
		};
	};
	if ( !([] call F_isBigtownActive) ) then {
		sleep (300.0 / GRLIB_difficulty_modifier);
	};

	diag_log format [ "End Patrol type %1 on sector %2 at %3", _patrol_type, _spawn_marker, time ];
};
