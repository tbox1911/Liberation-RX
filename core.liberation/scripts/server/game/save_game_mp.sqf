//--- LRX Savegame
if (!isServer) exitWith {};
if (!isNil "GRLIB_server_stopped") exitWith {};
if (!isNil "GRLIB_save_in_progress") exitWith {};

diag_log format ["--- LRX Save start at %1", time];
GRLIB_save_in_progress = true;

if ( GRLIB_endgame >= 1 || GRLIB_global_stop == 1 ) then {
	if (GRLIB_param_wipe_keepscore == 1) then {
		private _player_scores = [];
		{
			if (_x select 1 > GRLIB_perm_tank) then {
				_x set [1, GRLIB_perm_tank];	// score
			};
			if (_x select 2 > 3000) then {
				_x set [2, 3000];		// ammo
			};
			if (_x select 3 > 400) then {
				_x set [3, 400];		// fuel
			};
			_player_scores pushback _x;
		} foreach GRLIB_player_scores;
		GRLIB_player_scores = _player_scores;
	} else {
		GRLIB_permissions = [["Default",[true,false,false,true,false,true]]];
		GRLIB_player_scores = [];
	};

	if (GRLIB_param_wipe_keepcontext == 0) then {
		GRLIB_player_context = [];
	};

	// Save Restart Blob
	private _savegame = [
		[],
		[],
		[],
		time_of_day,
		0,
		[],
		[],
		GRLIB_mod_west,
		GRLIB_mod_east,
		[2,2,1,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		[33,33,33],
		[],
		GRLIB_permissions,
		GRLIB_player_context,
		0,
		GRLIB_player_scores
	];
	profileNamespace setVariable [GRLIB_save_key, _savegame];
	saveProfileNamespace;
} else {
	buildings_to_save = [];
	private _all_buildings = [];
	{
		_fobpos = _x;
		_nextbuildings = _fobpos nearObjects (GRLIB_fob_range * 2) select {
			( getObjectType _x >= 8 ) &&
			( !isSimpleObject _x ) &&
			( alive _x) && !(isObjectHidden _x) &&
			( (typeof _x) in GRLIB_classnames_to_save ) &&
			( speed vehicle _x < 5 ) &&
			( isNull attachedTo _x ) &&
			!(_x getVariable ["GRLIB_vehicle_owner", ""] in ["server", "public"])
		};
		_all_buildings = _all_buildings + _nextbuildings;
	} foreach GRLIB_all_fobs;

	// Filter low score Player
	private _player_scores = [];
	private _keep_score_id = ["Default"];
	{
		_uid = _x select 0;
		_score = _x select 1;
		if (_score >= GRLIB_min_score_player) then {
			_keep_score_id pushback _uid;
			_player_scores pushback _x;
		};
	} forEach GRLIB_player_scores;

	// Save Objects
	{
		private _savedpos = getPosWorld _x;
		private _nextclass = typeof _x;
		private _nextdir = [vectorDir _x, vectorUp _x];
		private _hascrew = false;
		private _owner = "";

		if (_nextclass in GRLIB_classnames_to_save_blu) then {
			if (side group _x != GRLIB_side_enemy) then {
				_owner = _x getVariable ["GRLIB_vehicle_owner", ""];
				_hascrew = _x getVariable ["GRLIB_vehicle_manned", false];
				if (_nextclass == FOB_sign) exitWith {
					_hascrew = _x getVariable ["GRLIB_fob_type", FOB_typename];
					buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner ];
				};
				if (_owner == "") exitWith {
					buildings_to_save pushback [ _nextclass, _savedpos, _nextdir ];
				};
				if (_owner == "lrx") exitWith {
					buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner ];
				};
				if (_owner in _keep_score_id) then {
					if (_nextclass in GRLIB_vehicles_light) then {
						private _default = true;
						if (_nextclass == playerbox_typename) then {
							buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner, [_x, true] call F_getCargo ];
							_default = false;
						};
						if (_nextclass == storage_medium_typename) then {
							private	_lst_grl = [];
							{_lst_grl pushback (typeOf _x)} forEach (_x getVariable ["GRLIB_ammo_truck_load", []]);
							buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner, _lst_grl ];
							_default = false;
						};
						if (_nextclass == box_uavs_typename) then {
							private _loaded_uavs = [_x] call save_object_direct;
							if (count _loaded_uavs > 0) then {
								buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner, _loaded_uavs ];
							};
							_default = false;
						};
						if (_default) then {
							buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner ];
						};
					} else {
						//_color = _x getVariable ["GRLIB_vehicle_color", ""];
						private _color = "";
						private _color_name = _x getVariable ["GRLIB_vehicle_color_name", ""];
						private _compo = _x getVariable ["GRLIB_vehicle_composant", []];
						private _lst_a3 = [];
						private	_lst_r3f = [_x] call save_object_direct;
						private	_lst_grl = [];
						{ if !(isNull _x) then { _lst_grl pushback (typeOf _x) } } forEach (_x getVariable ["GRLIB_ammo_truck_load", []]);
						buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner, _color, _color_name, _lst_a3, _lst_r3f, _lst_grl, _compo];
					};
				};
			};
		} else {
			buildings_to_save pushback [ _nextclass, _savedpos, _nextdir ];
		};
	} foreach _all_buildings;

	// Save Scores
	private _permissions = [];
	{
		_uid = _x select 0;
		if (_uid in _keep_score_id) then {_permissions pushback _x};
	} forEach GRLIB_permissions;

	// Save Context
	private _player_context = [];
	private _buffer = [];
	{
		_uid = _x;
		_buffer = localNamespace getVariable [format ["player_context_%1", _uid], []];
		if (count _buffer > 0) then {
			_player_context pushBack _buffer;
		} else {
			{if (_x select 0 == _uid) exitWith {_player_context pushBack _x}} foreach GRLIB_player_context;
		}
	} forEach _keep_score_id;
	GRLIB_player_context = _player_context;

	// Time
	time_of_day = date select 3;

	// Stats
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
	_stats pushback stats_prisoners_captured;
	_stats pushback stats_blufor_teamkills;
	_stats pushback stats_vehicles_recycled;
	_stats pushback stats_ammo_spent;
	_stats pushback stats_sectors_lost;
	_stats pushback stats_fobs_built;
	_stats pushback stats_fobs_lost;
	_stats pushback stats_readiness_earned;

	private _warehouse = [];
	{_warehouse pushBack (_x select 1)} forEach GRLIB_warehouse;

	// Save Blob
	private _lrx_liberation_savegame = [
		(blufor_sectors - sector_attack_in_progress),
		GRLIB_all_fobs,
		buildings_to_save,
		time_of_day,
		round combat_readiness,
		GRLIB_sector_defense,
		[],
		GRLIB_mod_west,
		GRLIB_mod_east,
		_warehouse,
		_stats,
		[ round infantry_weight max 33, round armor_weight max 33, round air_weight max 33 ],
		GRLIB_vehicle_to_military_base_links,
		_permissions,
		GRLIB_player_context,
		resources_intel,
		_player_scores
	];

	profileNamespace setVariable [GRLIB_save_key, _lrx_liberation_savegame];
	saveProfileNamespace;
	diag_log format [ "--- LRX Save %1 in Profile at %2", GRLIB_save_key, time ];
};

GRLIB_save_in_progress = nil;
