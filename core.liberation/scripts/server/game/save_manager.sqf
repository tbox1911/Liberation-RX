if ( !(isNil "GRLIB_param_wipe_savegame_1") && !(isNil "GRLIB_param_wipe_savegame_2") ) then {
	if ( GRLIB_param_wipe_savegame_1 == 1 && GRLIB_param_wipe_savegame_2 == 1 ) then {
		profileNamespace setVariable [ GRLIB_save_key, nil ];
		saveProfileNamespace;
	};
};
private ["_nextbuilding"];

date_year = date select 0;
date_month = date select 1;
date_day = date select 2;
blufor_sectors = [];
GRLIB_all_fobs = [];
GRLIB_mobile_respawn = [];
buildings_to_save= [];
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
stats_sectors_liberated = 0;
stats_playtime = 0;
stats_spartan_respawns = 0;
stats_secondary_objectives = 0;
stats_hostile_battlegroups = 0;
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
resources_intel = 0;
GRLIB_player_scores = [];
GRLIB_garage = [];

no_kill_handler_classnames = [FOB_typename, FOB_outpost, huron_typename];
_classnames_to_save = [];
{
	no_kill_handler_classnames pushback (_x select 0);
	_classnames_to_save pushback (_x select 0);
} foreach buildings;

_classnames_to_save_blu = [FOB_typename, FOB_outpost, FOB_sign, huron_typename];
{
	_classnames_to_save_blu pushback (_x select 0);
} foreach (air_vehicles + heavy_vehicles + light_vehicles + support_vehicles + static_vehicles + ind_recyclable);

_vehicles_blacklist = list_static_weapons + uavs + [mobile_respawn];

_classnames_to_save = _classnames_to_save + _classnames_to_save_blu + all_hostile_classnames;
_buildings_created = [];

trigger_server_save = false;
greuh_liberation_savegame = profileNamespace getVariable GRLIB_save_key;

_side_west = "";
_side_east = "";

// Manager Load Save
diag_log format [ "--- LRX Load Game start at %1", time ];
if ( !isNil "greuh_liberation_savegame" ) then {

	blufor_sectors = greuh_liberation_savegame select 0;
	GRLIB_all_fobs = greuh_liberation_savegame select 1;
	buildings_to_save = greuh_liberation_savegame select 2;
	time_of_day = greuh_liberation_savegame select 3;
	combat_readiness = greuh_liberation_savegame select 4;
	GRLIB_garage = greuh_liberation_savegame select 5;
	if (typeName GRLIB_garage != "ARRAY") then {GRLIB_garage = []};

	_side_west = greuh_liberation_savegame select 6;
	_side_east = greuh_liberation_savegame select 7;
	if ( GRLIB_force_load == 0 && typeName _side_west == "STRING" && typeName _side_east == "STRING" ) then {
		if ( _side_west != GRLIB_mod_west || _side_east != GRLIB_mod_east ) then {
			abort_loading = true;
		};
	};
	_stats = greuh_liberation_savegame select 9;
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

	_weights = greuh_liberation_savegame select 10;
	infantry_weight = _weights select 0;
	armor_weight = _weights select 1;
	air_weight = _weights select 2;

	GRLIB_vehicle_to_military_base_links = greuh_liberation_savegame select 11;
	GRLIB_permissions = greuh_liberation_savegame select 12;
	ai_groups = greuh_liberation_savegame select 13;
	resources_intel = greuh_liberation_savegame select 14;
	GRLIB_player_scores = greuh_liberation_savegame select 15;

	setDate [ GRLIB_date_year, GRLIB_date_month, GRLIB_date_day, time_of_day, 0];

	_correct_fobs = [];
	{
		_next_fob = _x;
		_keep_fob = true;
		{
			if ( _next_fob distance (markerpos _x) < 50 ) exitWith { _keep_fob = false };
		} foreach sectors_allSectors;
		if ( _keep_fob ) then { _correct_fobs pushback _next_fob };
	} foreach GRLIB_all_fobs;
	GRLIB_all_fobs = _correct_fobs;
	stats_saves_loaded = stats_saves_loaded + 1;

	diag_log format [ "--- LRX Load Game %1 objects to load...", count(buildings_to_save)];
	{
		_nextclass = _x select 0;

		if ( _nextclass in _classnames_to_save ) then {

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

			if ([_nextclass, simple_objects] call F_itemIsInClass) then {
				_nextbuilding = createSimpleObject [_nextclass, AGLtoASL _nextpos];
			} else {
				_nextbuilding = _nextclass createVehicle _nextpos;
				_nextbuilding allowDamage false;
				_nextbuilding setVectorUp [0,0,1];
				_nextbuilding setPosATL _nextpos;
				_nextbuilding setdir _nextdir;
				_nextbuilding setdamage 0;
			};
			_buildings_created pushback _nextbuilding;

			// Clear Cargo
			clearWeaponCargoGlobal _nextbuilding;
			clearMagazineCargoGlobal _nextbuilding;
			clearItemCargoGlobal _nextbuilding;
			clearBackpackCargoGlobal _nextbuilding;

			if ( _nextclass in vehicle_rearm_sources ) then {
				_nextbuilding setAmmoCargo 0;
			};

			if ( _owner != "" && _owner != "public" && !(_nextclass in _vehicles_blacklist) ) then {
				[_x select 5] params [["_color", ""]];
				[_x select 6] params [["_color_name", ""]];
				[_x select 7] params [["_lst_a3", []]];
				[_x select 8] params [["_lst_r3f", []]];
				[_x select 9] params [["_lst_grl", []]];

				_nextbuilding setVehicleLock "LOCKED";
				_nextbuilding allowCrewInImmobile true;
				_nextbuilding setUnloadInCombat [true, false];
				_nextbuilding setVariable ["GRLIB_vehicle_owner", _owner, true];
				_nextbuilding setVariable ["R3F_LOG_disabled", true, true];

				[_nextbuilding, _color, _color_name, []] call RPT_fnc_TextureVehicle;
				if (count _lst_a3 > 0) then {
					{_nextbuilding addWeaponWithAttachmentsCargoGlobal [ _x, 1]} forEach _lst_a3;
				};
				if (count _lst_r3f > 0) then {
					[_nextbuilding, _lst_r3f] call load_object_direct;
				};
				if (count _lst_grl > 0) then {
					{[_nextbuilding, _x] call attach_object_direct} forEach _lst_grl;
				};
			};

			if ( _owner == "public" && _nextclass == huron_typename ) then {
				_nextbuilding setVariable ["GRLIB_vehicle_owner", "public", true];
				_nextbuilding setVariable ["GRLIB_vehicle_ishuron", true, true];
			};

			if ( _nextclass in list_static_weapons ) then {
				[_nextbuilding] spawn protect_static;
				_nextbuilding setVariable ["GRLIB_vehicle_owner", _owner, true];
				_nextbuilding setVariable ["R3F_LOG_disabled", false, true];
				if (_nextclass in static_vehicles_AI) then {
					_nextbuilding setVehicleLock "LOCKEDPLAYER";
					_nextbuilding addEventHandler ["Fired", { (_this select 0) setVehicleAmmo 1}];
					_nextbuilding addEventHandler ["HandleDamage", { _this call damage_manager_EH }];
					_nextbuilding allowCrewInImmobile true;
					_nextbuilding setUnloadInCombat [true, false];			
				};
			};

			if ( _nextclass in uavs ) then {
				_nextbuilding setVariable ["GRLIB_vehicle_owner", _owner, true];
				_nextbuilding setVehicleLock "LOCKED";
				_nextbuilding setVariable ["R3F_LOG_disabled", true, true];
			};

			if ( _hascrew ) then {
				[ _nextbuilding ] call F_forceBluforCrew;
				_nextbuilding setVariable ["GRLIB_vehicle_manned", true, true];
			};

			if ( !(_nextclass in no_kill_handler_classnames ) ) then {
				_nextbuilding addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
			};

			if ( _nextclass in [FOB_typename, FOB_outpost] ) then {
				_nextbuilding allowDamage false;
				_nextbuilding addEventHandler ["HandleDamage", { 0 }];
			};

			if ( _nextclass == mobile_respawn ) then {
				_nextbuilding setVariable ["GRLIB_vehicle_owner", _owner, true];
				_nextbuilding addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
				GRLIB_mobile_respawn pushback _nextbuilding;
			};

			if ( _nextclass == FOB_sign ) then {
				_nextbuilding setVariable ["GRLIB_vehicle_owner", _owner, true];
				_nextbuilding setObjectTextureGlobal [0, getMissionPath "res\liberation.paa"];
				_nextbuilding allowDamage false;
			};
			
			//diag_log format [ "--- LRX Load Game %1 loaded at %2.", typeOf _nextbuilding, time];
		};
	} foreach buildings_to_save;

	sleep 1;
	{
		if (! (typeOf _x in [FOB_typename, FOB_sign])) then { _x allowDamage true };
	} foreach _buildings_created;
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
publicVariable "GRLIB_garage";
publicVariable "blufor_sectors";
publicVariable "GRLIB_all_fobs";
publicVariable "GRLIB_mobile_respawn";
publicVariable "GRLIB_vehicle_to_military_base_links";
publicVariable "GRLIB_permissions";
publicVariable "GRLIB_player_scores";
save_is_loaded = true; publicVariable "save_is_loaded";
if (abort_loading) exitWith { abort_loading_msg = format [
	"********************************\n
	FATAL! - This Savegame was made with a differents Modset (%1/%2)\n\n
	Loading Aborted to protect data integrity.\n
	Correct the Modset or Wipe the savegame..\n
	*********************************", _side_west, _side_east];
};

diag_log format [ "--- LRX Load Game finish at %1", time ];
sleep 5;

// Manager Save Loop
while { true } do {
	waitUntil {sleep 1; trigger_server_save || GRLIB_endgame == 1};

	if ( GRLIB_endgame == 1 ) then {
		profileNamespace setVariable [ GRLIB_save_key, nil ];
		saveProfileNamespace;
		while { true } do { sleep 300; };
	} else {
		trigger_server_save = false;
		buildings_to_save = [];
		private _all_buildings = [];
		{
			_fobpos = _x;
			_nextbuildings = [ _fobpos nearobjects (GRLIB_fob_range * 2), {
				( getObjectType _x >= 8 ) &&
				((typeof _x) in _classnames_to_save ) &&
				( alive _x) &&
				( speed _x < 5 ) &&
				( isNull attachedTo _x ) &&
				(((getpos _x) select 2) < 10 ) &&
				!(_x getVariable ["GRLIB_vehicle_owner", ""] == "server")
 				} ] call BIS_fnc_conditionalSelect;

			_all_buildings = _all_buildings + _nextbuildings;
		} foreach GRLIB_all_fobs;

		// Filter low score Player
		private _player_scores = [];
		private _keep_score_id = ["Default"];
		{
			_id = _x select 0;
			_score = _x select 1;
			_keep_score_id pushback _id;
			_player_scores pushback _x;
		} forEach GRLIB_player_scores;

		// Save objects
		{
			private _savedpos = getposATL _x;
			private _nextclass = typeof _x;
			private _nextdir = getdir _x;
			private _hascrew = false;
			private _owner = "";
			private _color = "";
			private _color_name = "";
			private _lst_a3 = [];
			private	_lst_r3f = [];
			private	_lst_grl = [];

			if ( _nextclass in _classnames_to_save_blu + all_hostile_classnames ) then {
				if (side _x != GRLIB_side_enemy) then {
					/*
					_owner = _x getVariable ["GRLIB_vehicle_owner", ""];
					if (_owner == "") then {
						buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew ];
					};
					if (_owner == "public") then {
						buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner ];
					};
					if (_owner in _keep_score_id && !([_nextclass, GRLIB_vehicle_blacklist] call F_itemIsInClass)) then {
					};
					*/
					
					_owner = "public";
					_hascrew = _x getVariable ["GRLIB_vehicle_manned", false];
					_color = _x getVariable ["GRLIB_vehicle_color", ""];
					_color_name = _x getVariable ["GRLIB_vehicle_color_name", ""];
					_lst_a3 = weaponsItemsCargo _x;
					{_lst_r3f pushback (typeOf _x)} forEach (_x getVariable ["R3F_LOG_objets_charges", []]);
					{_lst_grl pushback (typeOf _x)} forEach (attachedObjects _x);

					buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner, _color, _color_name, _lst_a3, _lst_r3f, _lst_grl];
				};
			} else {
				buildings_to_save pushback [ _nextclass, _savedpos, _nextdir ];
			};
		} foreach _all_buildings;

		// Save scores
		private _permissions = [];
		{
			_id = _x select 0;
			if (_id in _keep_score_id) then {_permissions pushback _x};
		} forEach GRLIB_permissions;

		time_of_day = date select 3;
		stats_saves_performed = stats_saves_performed + 1;

		_stats = [];
		_stats pushback stats_opfor_soldiers_killed;
		_stats pushback stats_opfor_killed_by_players;
		_stats pushback stats_blufor_soldiers_killed;
		_stats pushback stats_player_deaths;
		_stats pushback stats_opfor_vehicles_killed;
		_stats pushback stats_opfor_vehicles_killed_by_players;
		_stats pushback stats_blufor_vehicles_killed;
		_stats pushback stats_blufor_soldiers_recruited;
		_stats pushback stats_blufor_vehicles_built;
		_stats pushback stats_civilians_killed;
		_stats pushback stats_civilians_killed_by_players;
		_stats pushback stats_sectors_liberated;
		_stats pushback stats_playtime;
		_stats pushback stats_spartan_respawns;
		_stats pushback stats_secondary_objectives;
		_stats pushback stats_hostile_battlegroups;
		_stats pushback stats_ieds_detonated;
		_stats pushback stats_saves_performed;
		_stats pushback stats_saves_loaded;
		_stats pushback stats_reinforcements_called;
		_stats pushback stats_prisonners_captured;
		_stats pushback stats_blufor_teamkills;
		_stats pushback stats_vehicles_recycled;
		_stats pushback stats_ammo_spent;
		_stats pushback stats_sectors_lost;
		_stats pushback stats_fobs_built;
		_stats pushback stats_fobs_lost;
		_stats pushback stats_readiness_earned;

		greuh_liberation_savegame = [
			blufor_sectors,
			GRLIB_all_fobs,
			buildings_to_save,
			time_of_day,
			round combat_readiness,
			GRLIB_garage,
			GRLIB_mod_west,GRLIB_mod_east,
			0,		//free for extened use
			_stats,
			[ round infantry_weight max 33, round armor_weight max 33, round air_weight max 33 ],
			GRLIB_vehicle_to_military_base_links,
			_permissions,
			0,  //ai_groups
			resources_intel,
			_player_scores
		];

		profileNamespace setVariable [ GRLIB_save_key, greuh_liberation_savegame ];
		saveProfileNamespace;
		diag_server_save = ([] call F_getValid);
	};

};
