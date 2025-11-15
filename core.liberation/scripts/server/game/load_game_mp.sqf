//--- LRX Load Savegame
if (!isServer) exitWith {};
private ["_buildings_created", "_nextbuilding"];

date_year = date select 0;
date_month = date select 1;
date_day = date select 2;
blufor_sectors = [];
GRLIB_all_fobs = [];
GRLIB_all_outposts = [];
GRLIB_mobile_respawn = [];
buildings_to_load = [];
combat_readiness = 0;
stats_opfor_soldiers_killed = 0;
stats_opfor_killed_by_players = 0;
stats_blufor_soldiers_killed = 0;
stats_player_deaths = 0;
stats_opfor_vehicles_killed = 0;
stats_opfor_vehicles_killed_by_players = 0;
stats_blufor_vehicles_killed = 0;
stats_blufor_soldiers_recruited = 0;
stats_blufor_vehicles_built = 0;
stats_civilians_killed = 0;
stats_civilians_killed_by_players = 0;
stats_sectors_liberated = 0;
stats_playtime = 0;
stats_spartan_respawns = 0;
stats_secondary_objectives = 0;
stats_hostile_battlegroups = 0;
stats_ieds_detonated = 0;
stats_saves_performed = 0;
stats_saves_loaded = 0;
stats_reinforcements_called = 0;
stats_prisoners_captured = 0;
stats_blufor_teamkills = 0;
stats_vehicles_recycled = 0;
stats_ammo_spent = 0;
stats_sectors_lost = 0;
stats_fobs_built = 0;
stats_fobs_lost = 0;
stats_readiness_earned = 0;
infantry_weight = 33;
armor_weight = 33;
air_weight = 33;
sector_attack_in_progress = [];
fob_attack_in_progress = [];
GRLIB_vehicle_to_military_base_links = [];
GRLIB_vehicle_huron = objNull;
resources_intel = 0;
GRLIB_warehouse = [
	[waterbarrel_typename, 2],
	[fuelbarrel_typename, 2],
	[foodbarrel_typename, 1],
	[basic_weapon_typename, 0]
];
GRLIB_sector_defense = [];

// Savegame file
private _lrx_liberation_savegame = profileNamespace getVariable [GRLIB_save_key, nil];

// Load Player Context
GRLIB_permissions = [["Default",[true,false,false,true,false,true]]];
GRLIB_player_context = [];
GRLIB_player_scores = [];
if (GRLIB_param_wipe_context == 0) then {
	if (!isNil "_lrx_liberation_savegame") then {
		GRLIB_permissions = _lrx_liberation_savegame select 13;
		GRLIB_player_context = _lrx_liberation_savegame select 14;
		GRLIB_player_scores = _lrx_liberation_savegame select 16;
	};
} else {
	// Wipe Context
	diag_log format ["--- LRX Player Context Erased!", GRLIB_save_key];
};

// Wipe Savegame
if (GRLIB_param_wipe_savegame_1 == 1 && GRLIB_param_wipe_savegame_2 == 1) then {
	profileNamespace setVariable [GRLIB_save_key, nil];
	saveProfileNamespace;
	diag_log format ["--- LRX Savegame %1 Erased!", GRLIB_save_key];
	_lrx_liberation_savegame = nil;
	sleep 1;
};

// Load Savegame
private _side_west = "";
private _side_east = "";
private _warehouse = [];
private _sector_defense = [];
private _buildings_created = [];

if (!isNil "_lrx_liberation_savegame") then {
	if (count _lrx_liberation_savegame <= 16) exitWith {
		abort_loading_msg = format [
		"********************************\n
		FATAL! - The savegame is incompatible with this version of LRX\n\n
		Loading Aborted to protect data integrity.\n
		Wipe the savegame...\n
		*********************************"];
		abort_loading = true;
	};
	diag_log format [ "--- LRX Load Game start at %1", time ];

	blufor_sectors = _lrx_liberation_savegame select 0;
	if (isNil "blufor_sectors") then { blufor_sectors = [] };
	GRLIB_all_fobs = _lrx_liberation_savegame select 1;
	buildings_to_load = _lrx_liberation_savegame select 2;
	time_of_day = _lrx_liberation_savegame select 3;
	combat_readiness = _lrx_liberation_savegame select 4;
	_sector_defense = _lrx_liberation_savegame select 5;
	//_unused = _lrx_liberation_savegame select 6;
	_side_west = _lrx_liberation_savegame select 7;
	_side_east = _lrx_liberation_savegame select 8;
	_warehouse = _lrx_liberation_savegame select 9;
	_stats = _lrx_liberation_savegame select 10;
		stats_opfor_soldiers_killed = _stats select 0;
		stats_opfor_killed_by_players = _stats select 1;
		stats_blufor_soldiers_killed = _stats select 2;
		stats_player_deaths = _stats select 3;
		stats_opfor_vehicles_killed = _stats select 4;
		stats_opfor_vehicles_killed_by_players = _stats select 5;
		stats_blufor_vehicles_killed = _stats select 6;
		stats_blufor_soldiers_recruited = _stats select 7;
		stats_blufor_vehicles_built = _stats select 8;
		stats_civilians_killed = _stats select 9;
		stats_civilians_killed_by_players = _stats select 10;
		stats_sectors_liberated = _stats select 11;
		stats_playtime = _stats select 12;
		stats_spartan_respawns = _stats select 13;
		stats_secondary_objectives = _stats select 14;
		stats_hostile_battlegroups = _stats select 15;
		stats_ieds_detonated = _stats select 16;
		stats_saves_performed = _stats select 17;
		stats_saves_loaded = _stats select 18;
		stats_reinforcements_called = _stats select 19;
		stats_prisoners_captured = _stats select 20;
		stats_blufor_teamkills = _stats select 21;
		stats_vehicles_recycled = _stats select 22;
		stats_ammo_spent = _stats select 23;
		stats_sectors_lost = _stats select 24;
		stats_fobs_built = _stats select 25;
		stats_fobs_lost = _stats select 26;
		stats_readiness_earned = _stats select 27;
	_weights = _lrx_liberation_savegame select 11;
		infantry_weight = _weights select 0;
		armor_weight = _weights select 1;
		air_weight = _weights select 2;
	GRLIB_vehicle_to_military_base_links = _lrx_liberation_savegame select 12;
	resources_intel = _lrx_liberation_savegame select 15;

	if (GRLIB_force_load == 0 && (_side_west != GRLIB_mod_west || _side_east != GRLIB_mod_east)) exitWith {
		abort_loading_msg = format [
		"********************************\n
		FATAL! - The savegame was made with a differents Modset (%1 / %2)\n\n
		Loading Aborted to protect data integrity.\n
		Correct the Modset or Wipe the savegame...\n
		Current Modset: (%3 / %4)\n
		*********************************", _side_west, _side_east, GRLIB_mod_west, GRLIB_mod_east];
		abort_loading = true;
	};

	if (typeName _warehouse != "ARRAY") exitWith {
		abort_loading_msg = format [
		"********************************\n
		FATAL! - The savegame is incompatible with this version of LRX\n\n
		Loading Aborted to protect data integrity.\n
		Wipe the savegame...\n
		*********************************"];
		abort_loading = true;
	};

	GRLIB_warehouse = [
		[waterbarrel_typename, (_warehouse select 0)],
		[fuelbarrel_typename, (_warehouse select 1)],
		[foodbarrel_typename, (_warehouse select 2)],
		[basic_weapon_typename, (_warehouse select 3)]
	];

	setDate [ GRLIB_date_year, GRLIB_date_month, GRLIB_date_day, time_of_day, 0];

	stats_saves_loaded = stats_saves_loaded + 1;

	if (count buildings_to_load == 0) exitWith {};
	diag_log format ["--- LRX Load Game %1 objects to load...", count buildings_to_load];

	private _s1 = [];
	private _s2 = [];
	private _s3 = [];
	{
		_nextclass = _x select 0;
		if (_nextclass in GRLIB_no_kill_handler_classnames) then {
			_s1 pushBack _x;
		} else {
			if (_nextclass iskindOf "AllVehicles") then {
				_s3 pushBack _x;
			} else {
				_s2 pushBack _x;
			};
		};
	} foreach buildings_to_load;

	// Buildings
	{
		_nextclass = _x select 0;
		_nextpos = _x select 1;
		_nextdir = _x select 2;

		_nextbuilding = createVehicle [_nextclass, zeropos, [], 0, "CAN_COLLIDE"];
		_nextbuilding allowDamage false;
		_nextbuilding setVectorDirAndUp [_nextdir select 0, _nextdir select 1];
		_nextbuilding setPosWorld _nextpos;
		_buildings_created pushback _nextbuilding;

		if (_nextclass == FOB_sign) then {
			_nextbuilding setObjectTextureGlobal [0, getMissionPath "res\splash_libe2.paa"];
			_nextbuilding setVariable ["GRLIB_fob_type", (_x select 3), true];
			_nextbuilding setVariable ["GRLIB_vehicle_owner", (_x select 4), true];
		};

		if (_nextclass == land_cutter_typename) then {
			[_nextpos] call build_cutter_remote_call;
			_nextbuilding enableSimulationGlobal false;
		};

		if (_nextclass == helipad_typename) then {
			_nextbuilding enableSimulationGlobal false;
		};

		if (_nextclass == Warehouse_typename) then {
			[_nextbuilding] call warehouse_init_remote_call;
		};

		if (_nextclass == FOB_typename) then {
			[_nextbuilding] call fob_init_officer;
		};

		if (_nextclass == FOB_carrier) then {
			[_nextbuilding] call BIS_fnc_carrier01Init;
			[_nextbuilding] call BIS_fnc_Carrier01PosUpdate;
		};
	} foreach _s1;

	// Objects
	{
		_nextclass = _x select 0;
		_nextpos = _x select 1;
		_nextdir = _x select 2;

		private _owner = "";
		if (count _x > 4) then {
			_owner = _x select 4;
		};

		_nextbuilding = createVehicle [_nextclass, zeropos, [], 0, "CAN_COLLIDE"];
		_nextbuilding allowDamage false;
		_nextbuilding addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_nextbuilding setVectorDirAndUp [_nextdir select 0, _nextdir select 1];
		_nextbuilding setPosWorld _nextpos;
		_nextbuilding setVelocity [0, 0, 0];
		_buildings_created pushback _nextbuilding;

		if (GRLIB_ACE_enabled) then {
			[_nextbuilding] call F_aceInitVehicle;
		};

		if (_nextclass == playerbox_typename) then {
			_nextbuilding setMaxLoad playerbox_cargospace;
			_nextbuilding setVehicleLock "DEFAULT";
			[_nextbuilding, (_x select 5)] call F_setCargo;
		};

		if (_nextclass == Box_Ammo_typename) then {
			_nextbuilding addItemCargoGlobal ["SatchelCharge_Remote_Mag", 2];
		};

		if (_nextclass == Arsenal_typename) then {
			_nextbuilding setMaxLoad 0;
		};

		if (!(_nextclass in GRLIB_Ammobox_keep)) then {
			[_nextbuilding] call F_clearCargo;
		};

		if (_nextclass in vehicle_rearm_sources) then {
			_nextbuilding setAmmoCargo 0;
		};

		if (_nextclass == box_uavs_typename) then {
			_nextbuilding setMaxLoad 0;
			[_nextbuilding, (_x select 5)] call load_object_direct;
		};

		if (_nextclass == storage_medium_typename) then {
			{[_nextbuilding, _x] call attach_object_direct} forEach (_x select 5);
			private _drop_zone_dir = (getdir _nextbuilding);
			private _drop_zone_pos = (getposATL _nextbuilding) vectorAdd ([[0, -5, 0], -_drop_zone_dir] call BIS_fnc_rotateVector2D);
			private _drop_zone = createVehicle ["VR_Area_01_square_2x2_yellow_F", ([] call F_getFreePos), [], 0, "NONE"];
			_drop_zone_pos set [2, 0.02];
			_drop_zone setDir _drop_zone_dir;
			_drop_zone setPosATL _drop_zone_pos;
			_drop_zone setVectorDirAndUp [[-cos _drop_zone_dir, sin _drop_zone_dir, 0] vectorCrossProduct surfaceNormal _drop_zone_pos, surfaceNormal _drop_zone_pos];
		};

		if (_owner != "") then {
			_nextbuilding setVariable ["GRLIB_vehicle_owner", _owner, true];
			if (_owner != "public") then {
				_nextbuilding setVehicleLock "LOCKED";
				_nextbuilding setVariable ["R3F_LOG_disabled", false, true];
			};
		};

		if (_nextclass == mobile_respawn) then {
			GRLIB_mobile_respawn pushback _nextbuilding;
		};
		sleep 0.1;
	} foreach _s2;

	// Vehicles
	{
		_nextclass = _x select 0;
		_nextpos = _x select 1;
		_nextdir = _x select 2;

		private _hascrew = false;
		if (count _x > 3) then {
			_hascrew = _x select 3;
		};

		private _owner = "";
		if (count _x > 4) then {
			_owner = _x select 4;
		};

		_nextbuilding = createVehicle [_nextclass, zeropos, [], 0, "CAN_COLLIDE"];
		_nextbuilding allowDamage false;
		_nextbuilding addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_nextbuilding setVectorDirAndUp [_nextdir select 0, _nextdir select 1];
		_nextbuilding setPosWorld _nextpos;
		_nextbuilding setPos (getPos _nextbuilding);
		_buildings_created pushback _nextbuilding;

		if (GRLIB_ACE_enabled) then {
			[_nextbuilding] call F_aceInitVehicle;
		};

		[_nextbuilding] call F_clearCargo;
		[_nextbuilding] call F_fixModVehicle;

		if (_nextclass in vehicle_rearm_sources) then {
			_nextbuilding setAmmoCargo 0;
		};

		if (_hascrew) then {
			[_nextbuilding] call F_forceCrew;
			_nextbuilding setVariable ["GRLIB_vehicle_manned", true, true];
		};

		if (_nextclass in respawn_vehicles) then {
			GRLIB_mobile_respawn pushback _nextbuilding;
		};

		if (_owner != "") then {
			if (_owner == "lrx") then {
				_nextbuilding setVariable ["GRLIB_vehicle_owner", "lrx", true];
				if (_nextclass == huron_typename) then { GRLIB_vehicle_huron = _nextbuilding };
			} else {
				[_nextbuilding, "lock", _owner] call F_vehicleLock;
			};
		};

		if (_nextclass in GRLIB_vehicles_light) then {
			_nextbuilding setVariable ["R3F_LOG_disabled", false, true];
			if (_nextclass in list_static_weapons) then {
				_nextbuilding setVehicleLock "DEFAULT";
				{ _nextbuilding lockTurret [_x, false] } forEach (allTurrets _nextbuilding);
				if (_nextclass in static_vehicles_AI) then {
					_nextbuilding setVehicleLock "LOCKED";
					_nextbuilding allowCrewInImmobile [true, false];
					_nextbuilding setUnloadInCombat [true, false];
					_nextbuilding setAutonomous true;
				};
			};
			if (_nextclass in uavs_vehicles) then {
				_nextbuilding setVariable ["R3F_LOG_disabled", true, true];
			};
		} else {
			if (!(_owner in ["", "public"]) && count _x > 5) then {
				//[_x select 5] params [["_color", ""]];
				[_x select 6] params [["_color_name", ""]];
				[_x select 7] params [["_lst_a3", []]];
				[_x select 8] params [["_lst_r3f", []]];
				[_x select 9] params [["_lst_grl", []]];
				[_x select 10] params [["_compo", []]];

				_nextbuilding allowCrewInImmobile [true, false];
				_nextbuilding setUnloadInCombat [true, false];

				if (_color_name != "") then {
					[_nextbuilding, _color_name] call RPT_fnc_TextureVehicle;
				};

				if (count _compo > 0) then {
					[_nextbuilding, _compo] call RPT_fnc_CompoVehicle;
				};

				if (count _lst_a3 > 0) then {
					[_nextbuilding, _lst_a3] call F_setCargo;
				};

				if (count _lst_r3f > 0) then {
					[_nextbuilding, _lst_r3f] call load_object_direct;
				};

				if (count _lst_grl > 0) then {
					{[_nextbuilding, _x] call attach_object_direct} forEach _lst_grl;
				};
			};
		};
		sleep 0.1;
	} foreach _s3;

	[_buildings_created] spawn {
		params ["_list"];
		sleep 30;
		private _no_damage = [
			FOB_typename,
			FOB_outpost,
			FOB_sign,
			Warehouse_typename,
			playerbox_typename,
			land_cutter_typename,
			storage_medium_typename,
			"Land_PortableHelipadLight_01_F"
		];
		{
			_allow_damage = true;
			if (typeOf _x in _no_damage) then { _allow_damage = false };
			_x setDamage 0;
			if (_allow_damage) then { _x allowDamage true };
			sleep 0.1;
		} foreach _list;
	};

	diag_log format [ "--- LRX Load Game finish at %1", time ];
};

if (abort_loading) exitWith {};
if (count GRLIB_vehicle_to_military_base_links == 0) then {
	private [ "_assigned_bases", "_assigned_vehicles", "_nextbase", "_nextvehicle" ];
	_assigned_bases = [];
	_assigned_vehicles = [];

	while { count _assigned_bases < count sectors_military && count _assigned_vehicles < count elite_vehicles } do {
		_nextbase = selectRandom (sectors_military select { !(_x in _assigned_bases) });
		_nextvehicle = selectRandom (elite_vehicles select { !(_x in _assigned_vehicles) });
		_assigned_bases pushback _nextbase;
		_assigned_vehicles pushback _nextvehicle;
		GRLIB_vehicle_to_military_base_links pushback [_nextvehicle, _nextbase];
	};
} else {
	_classnames_to_check = GRLIB_vehicle_to_military_base_links;
	{
		if (! ([ _x select 0 ] call F_checkClass)) then {
			GRLIB_vehicle_to_military_base_links = GRLIB_vehicle_to_military_base_links - [_x];
		};
	} foreach _classnames_to_check;
};

{
	if (count (_x nearObjects [FOB_outpost, 20]) > 0) then { GRLIB_all_outposts pushBack _x };
} forEach GRLIB_all_fobs;

{
	if ((_x select 0) in blufor_sectors) then { GRLIB_sector_defense pushBack _x };
} forEach _sector_defense;

publicVariable "stats_blufor_soldiers_recruited";
publicVariable "stats_blufor_vehicles_built";
publicVariable "stats_sectors_liberated";
publicVariable "stats_hostile_battlegroups";
publicVariable "stats_ieds_detonated";
publicVariable "stats_reinforcements_called";
publicVariable "stats_prisoners_captured";
publicVariable "stats_vehicles_recycled";
publicVariable "stats_ammo_spent";
publicVariable "stats_readiness_earned";
publicVariable "GRLIB_vehicle_huron";
publicVariable "GRLIB_permissions";
publicVariable "GRLIB_warehouse";
publicVariable "blufor_sectors";
publicVariable "resources_intel";
publicVariable "combat_readiness";
publicVariable "GRLIB_all_fobs";
publicVariable "GRLIB_all_outposts";
publicVariable "GRLIB_mobile_respawn";
publicVariable "GRLIB_vehicle_to_military_base_links";
publicVariable "GRLIB_player_scores";
publicVariable "GRLIB_sector_defense";
publicVariable "sector_attack_in_progress";
publicVariable "fob_attack_in_progress";
