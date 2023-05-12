//--- LRX Load Savegame
if (!isServer) exitWith {};
private [ "_buildings_created", "_nextbuilding"];

date_year = date select 0;
date_month = date select 1;
date_day = date select 2;
blufor_sectors = [];
GRLIB_all_fobs = [];
GRLIB_all_outposts = [];
GRLIB_mobile_respawn = [];
buildings_to_load= [];
combat_readiness = 0;
stats_opfor_soldiers_killed = 0;
stats_opfor_killed_by_players = 0;
stats_blufor_soldiers_killed = 0;
stats_player_deaths = 0;
stats_opfor_vehicles_killed = 0;
stats_opfor_vehicles_killed_by_players = 0;
stats_blufor_vehicles_killed = 0;
stats_blufor_soldiers_recruited = 0; publicVariable "stats_blufor_soldiers_recruited";
stats_blufor_vehicles_built = 0; publicVariable "stats_blufor_vehicles_built";
stats_civilians_killed = 0;
stats_civilians_killed_by_players = 0;
stats_sectors_liberated = 0; publicVariable "stats_sectors_liberated";
stats_playtime = 0;
stats_spartan_respawns = 0;
stats_secondary_objectives = 0;
stats_hostile_battlegroups = 0; publicVariable "stats_hostile_battlegroups";
stats_ieds_detonated = 0; publicVariable "stats_ieds_detonated";
stats_saves_performed = 0;
stats_saves_loaded = 0;
stats_reinforcements_called = 0; publicVariable "stats_reinforcements_called";
stats_prisonners_captured = 0; publicVariable "stats_prisonners_captured";
stats_blufor_teamkills = 0;
stats_vehicles_recycled = 0;  publicVariable "stats_vehicles_recycled";
stats_ammo_spent = 0; publicVariable "stats_ammo_spent";
stats_sectors_lost = 0;
stats_fobs_built = 0;
stats_fobs_lost = 0;
stats_readiness_earned = 0; publicVariable "stats_readiness_earned";
infantry_weight = 33;
armor_weight = 33;
air_weight = 33;
GRLIB_vehicle_to_military_base_links = [];
GRLIB_permissions = [];
GRLIB_player_context = [];
resources_intel = 0;
GRLIB_player_scores = [];
GRLIB_garage = [];
GRLIB_warehouse = [];

private _no_kill_handler_classnames = [FOB_typename, FOB_outpost];
{ _no_kill_handler_classnames pushback (_x select 0) } foreach buildings;

private _vehicles_light = list_static_weapons + [mobile_respawn];
{ _vehicles_light pushback (_x select 0) } foreach support_vehicles;
_vehicles_light = _vehicles_light arrayIntersect _vehicles_light;

// Wipe Savegame
if ( GRLIB_param_wipe_savegame_1 == 1 && GRLIB_param_wipe_savegame_2 == 1 ) then {
	if (GRLIB_param_wipe_keepscore == 1) then {
		GRLIB_permissions = profileNamespace getVariable GRLIB_save_key select 12;
		private _keep_players = [];
		{
			if (_x select 1 > GRLIB_perm_tank) then {
				_x set [1, GRLIB_perm_tank];  	// score
			};
			_x set [2, GREUH_start_ammo];  		// ammo
			_x set [3, GREUH_start_fuel];  		// fuel
			_keep_players pushback _x;
		} foreach (profileNamespace getVariable GRLIB_save_key select 15);
		GRLIB_player_scores = _keep_players;
	};
	profileNamespace setVariable [ GRLIB_save_key, nil ];
	saveProfileNamespace;
};

// Load Savegame
private _lrx_liberation_savegame = profileNamespace getVariable GRLIB_save_key;
private _side_west = "";
private _side_east = "";
private _buildings_created = [];

if ( !isNil "_lrx_liberation_savegame" ) then {
	diag_log format [ "--- LRX Load Game start at %1", time ];

	blufor_sectors = _lrx_liberation_savegame select 0;
	GRLIB_all_fobs = _lrx_liberation_savegame select 1;
	buildings_to_load = _lrx_liberation_savegame select 2;
	time_of_day = _lrx_liberation_savegame select 3;
	combat_readiness = _lrx_liberation_savegame select 4;
	GRLIB_garage = _lrx_liberation_savegame select 5;
	_side_west = _lrx_liberation_savegame select 6;
	_side_east = _lrx_liberation_savegame select 7;
	GRLIB_warehouse = _lrx_liberation_savegame select 8;
	_stats = _lrx_liberation_savegame select 9;
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
	stats_prisonners_captured = _stats select 20;
	stats_blufor_teamkills = _stats select 21;
	stats_vehicles_recycled = _stats select 22;
	stats_ammo_spent = _stats select 23;
	stats_sectors_lost = _stats select 24;
	stats_fobs_built = _stats select 25;
	stats_fobs_lost = _stats select 26;
	stats_readiness_earned = _stats select 27;

	_weights = _lrx_liberation_savegame select 10;
	infantry_weight = _weights select 0;
	armor_weight = _weights select 1;
	air_weight = _weights select 2;

	GRLIB_vehicle_to_military_base_links = _lrx_liberation_savegame select 11;
	GRLIB_permissions = _lrx_liberation_savegame select 12;
	GRLIB_player_context = _lrx_liberation_savegame select 13;
	resources_intel = _lrx_liberation_savegame select 14;
	GRLIB_player_scores = _lrx_liberation_savegame select 15;

	if ( GRLIB_force_load == 0 && typeName _side_west == "STRING" && typeName _side_east == "STRING" ) then {
		if ( _side_west != GRLIB_mod_west || _side_east != GRLIB_mod_east ) exitWith {
			abort_loading_msg = format [
			"********************************\n
			FATAL! - The savegame was made with a differents Modset (%1 / %2)\n\n
			Loading Aborted to protect data integrity.\n
			Correct the Modset or Wipe the savegame...\n
			Current Modset: (%3 / %4)\n
			*********************************", _side_west, _side_east, GRLIB_mod_west, GRLIB_mod_east];			
			abort_loading = true;
		};
	};

	if (typeName GRLIB_warehouse != "ARRAY") exitWith {
		abort_loading_msg = format [
		"********************************\n
		FATAL! - The savegame is incompatible with this version of LRX\n\n
		Loading Aborted to protect data integrity.\n
		Wipe the savegame...\n
		*********************************"];			
		abort_loading = true;
	};
	if (abort_loading) exitWith {};

	setDate [ GRLIB_date_year, GRLIB_date_month, GRLIB_date_day, time_of_day, 0];

	stats_saves_loaded = stats_saves_loaded + 1;

	diag_log format ["--- LRX Load Game %1 objects to load...", count(buildings_to_load)];

	private _s1 = [];
	private _s2 = [];
	private _s3 = [];
	{
		_nextclass = _x select 0;
		if (_nextclass in _no_kill_handler_classnames) then {
			_s1 pushBack _x;
		} else {
			if (_nextclass iskindOf "AllVehicles") then {
				_s2 pushBack _x;
			} else {
				_s3 pushBack _x;
			};
		};
	} foreach buildings_to_load;
 
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
		_nextbuilding setVectorDirAndUp [_nextdir select 0, _nextdir select 1];
		_nextbuilding setPosWorld _nextpos;
		_buildings_created pushback _nextbuilding;

		if (!(_nextclass in GRLIB_Ammobox_keep)) then {
			clearWeaponCargoGlobal _nextbuilding;
			clearMagazineCargoGlobal _nextbuilding;
			clearItemCargoGlobal _nextbuilding;
			clearBackpackCargoGlobal _nextbuilding;
		};

        if ( _nextclass in vehicle_rearm_sources ) then {
            _nextbuilding setAmmoCargo 0;
        };

        if ( _owner != "" ) then {
            _nextbuilding setVariable ["GRLIB_vehicle_owner", _owner, true];
			if ( _nextclass == huron_typename ) then {
            	_nextbuilding setVariable ["GRLIB_vehicle_ishuron", true, true];
			};
        };

		if ( _owner == "public" && _nextclass in GRLIB_Ammobox_keep ) then {
			_nextbuilding setVariable ["R3F_LOG_disabled", true, true];
		};

        if ( _nextclass in _vehicles_light ) then {
			if (_nextclass iskindof "LandVehicle") then {
				_nextbuilding setVehicleLock "LOCKED";
				_nextbuilding setVariable ["R3F_LOG_disabled", true, true];
			};

			if ( _nextclass in list_static_weapons ) then {
            	_nextbuilding setVariable ["GRLIB_vehicle_owner", _owner, true];
            	_nextbuilding setVariable ["R3F_LOG_disabled", false, true];
				_nextbuilding setVehicleLock "DEFAULT";
				if (_nextclass in static_vehicles_AI) then {
					_nextbuilding setVehicleLock "LOCKEDPLAYER";
					_nextbuilding addEventHandler ["Fired", { (_this select 0) setVehicleAmmo 1 }];
					_nextbuilding addEventHandler ["HandleDamage", { _this call damage_manager_static }];
					_nextbuilding allowCrewInImmobile [true, false];
					_nextbuilding setUnloadInCombat [true, false];
				};
			};
			if ( _nextclass == playerbox_typename ) then {
				_nextbuilding setVariable ["GRLIB_vehicle_owner", _owner, true];
				_nextbuilding setVariable ["R3F_LOG_disabled", false, true];
				_nextbuilding setVehicleLock "DEFAULT";
				[_nextbuilding, _x select 5] call F_setCargo;
			};
			if ( _nextclass == Box_Ammo_typename ) then {
				_nextbuilding addItemCargoGlobal ["SatchelCharge_Remote_Mag", 2];
			};			
        } else {
			if ( !(_owner in ["", "public"]) && count _x > 5 ) then {
				[_x select 5] params [["_color", ""]];
				[_x select 6] params [["_color_name", ""]];
				[_x select 7] params [["_lst_a3", []]];
				[_x select 8] params [["_lst_r3f", []]];
				[_x select 9] params [["_lst_grl", []]];
				[_x select 10] params [["_compo", []]];

				_nextbuilding setVehicleLock "LOCKED";
				_nextbuilding lockCargo true;
				_nextbuilding lockDriver true;
				_nextbuilding lockTurret [[0], true];
				_nextbuilding lockTurret [[0,0], true];
				_nextbuilding allowCrewInImmobile [true, false];
				_nextbuilding setUnloadInCombat [true, false];
				_nextbuilding setVariable ["R3F_LOG_disabled", true, true];

				// temp workaround
				if (typeName _color != "ARRAY") then {
					if (_color != "") then {
						[_nextbuilding, _color, _color_name] call RPT_fnc_TextureVehicle;
					};
				};
				if (count _compo > 0) then {
					[_nextbuilding, _compo]  call RPT_fnc_CompoVehicle;
				};
				if (GRLIB_CUPV_enabled && _nextclass isKindOf "Tank") then {
					[_nextbuilding, false, ["hide_front_ti_panels",1,"hide_cip_panel_rear",1,"hide_cip_panel_bustle",1]] call BIS_fnc_initVehicle;
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

        if ( _nextclass in uavs ) then {
            _nextbuilding setVehicleLock "LOCKED";
            _nextbuilding setVariable ["R3F_LOG_disabled", true, true];
        };

        if ( _hascrew ) then {
            [ _nextbuilding ] call F_forceBluforCrew;
            _nextbuilding setVariable ["GRLIB_vehicle_manned", true, true];
        };

        if ( _nextclass == mobile_respawn ) then {
            GRLIB_mobile_respawn pushback _nextbuilding;
        };

        if ( _nextclass == FOB_sign ) then {
            _nextbuilding setObjectTextureGlobal [0, getMissionPath "res\splash_libe2.paa"];
        };

		if (_nextclass == land_cutter_typename) then {
			{_x hideObjectGlobal true} forEach (nearestTerrainObjects [_nextpos, GRLIB_clutter_cutter, 20]);
		};

        if ( !(_nextclass in _no_kill_handler_classnames) ) then {
            _nextbuilding addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		};

		if (_nextclass == Warehouse_typename) then {
			[_nextbuilding] call warehouse_init_remote_call;
		};
        //diag_log format [ "--- LRX Load Game %1 loaded at %2.", typeOf _nextbuilding, time];
	} foreach (_s1 + _s2 + _s3);
	sleep 1;

	{ 
		_allow_damage = true;
		if ( (typeOf _x) in [FOB_typename,FOB_outpost,FOB_sign,Warehouse_typename,playerbox_typename] ) then {
			_x addEventHandler ["HandleDamage", { 0 }];
			_allow_damage = false;
		};
		if ( (typeOf _x) in GRLIB_Ammobox_keep && [_x] call is_public ) then {
			_allow_damage = false;
		};
		if ( _allow_damage ) then { _x allowDamage true };
	} foreach _buildings_created;
	sleep 1;

	diag_log format [ "--- LRX Load Game finish at %1", time ];
} else {
	_lrx_liberation_savegame = [];
};

if ( count GRLIB_vehicle_to_military_base_links == 0 ) then {
	private [ "_assigned_bases", "_assigned_vehicles", "_nextbase", "_nextvehicle" ];
	_assigned_bases = [];
	_assigned_vehicles = [];

	while { count _assigned_bases < count sectors_military && count _assigned_vehicles < count elite_vehicles } do {
		_nextbase =  selectRandom ( [ sectors_military, { !(_x in _assigned_bases) } ] call BIS_fnc_conditionalSelect );
		_nextvehicle =  selectRandom ( [ elite_vehicles, { !(_x in _assigned_vehicles) } ] call BIS_fnc_conditionalSelect );
		_assigned_bases pushback _nextbase;
		_assigned_vehicles pushback _nextvehicle;
		GRLIB_vehicle_to_military_base_links pushback [_nextvehicle, _nextbase];
	};
} else {
	_classnames_to_check = GRLIB_vehicle_to_military_base_links;
	{
		if ( ! ( [ _x select 0 ] call F_checkClass ) ) then {
			GRLIB_vehicle_to_military_base_links = GRLIB_vehicle_to_military_base_links - [_x];
		};
	} foreach _classnames_to_check;
};

{
	if (count (_x nearObjects [FOB_outpost, 20]) > 0) then { GRLIB_all_outposts pushBack _x };
} forEach GRLIB_all_fobs;

publicVariable "GRLIB_garage";
publicVariable "GRLIB_warehouse";
publicVariable "blufor_sectors";
publicVariable "GRLIB_all_fobs";
publicVariable "GRLIB_all_outposts";
publicVariable "GRLIB_mobile_respawn";
publicVariable "GRLIB_vehicle_to_military_base_links";
publicVariable "GRLIB_permissions";
publicVariable "GRLIB_player_scores";
save_is_loaded = ([] call F_getValid); publicVariable "save_is_loaded";
