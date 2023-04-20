if ( !(isNil "GRLIB_param_wipe_savegame_1") && !(isNil "GRLIB_param_wipe_savegame_2") ) then {
	if ( GRLIB_param_wipe_savegame_1 == 1 && GRLIB_param_wipe_savegame_2 == 1 ) then {
		profileNamespace setVariable [ GRLIB_save_key,nil ];
		saveProfileNamespace;
	};
};

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
stats_blufor_soldiers_recruited = 0;
stats_blufor_vehicles_built = 0;
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
stats_reinforcements_called = 0;
stats_prisonners_captured = 0;
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
GRLIB_vehicle_to_military_base_links = [];
GRLIB_permissions = [];
ai_groups = [];
saved_intel_res = 0;
resources_intel = 0;
GRLIB_player_scores = [];
GRLIB_garage = [];

no_kill_handler_classnames = [FOB_typename, huron_typename];
_classnames_to_save = [FOB_typename, huron_typename];
_classnames_to_save_blu = [];
_building_classnames = [FOB_typename];
{
	no_kill_handler_classnames pushback (_x select 0);
	_classnames_to_save pushback (_x select 0);
	_building_classnames pushback (_x select 0);
} foreach buildings;

{
	_classnames_to_save_blu pushback (_x select 0);
} foreach (static_vehicles + air_vehicles + heavy_vehicles + light_vehicles + support_vehicles + ind_recyclable);

_classnames_to_save = _classnames_to_save + _classnames_to_save_blu + all_hostile_classnames;

trigger_server_save = false;
greuh_liberation_savegame = profileNamespace getVariable GRLIB_save_key;

// Manager Load Save
if ( !isNil "greuh_liberation_savegame" ) then {

	blufor_sectors = greuh_liberation_savegame select 0;
	GRLIB_all_fobs = greuh_liberation_savegame select 1;
	buildings_to_save = greuh_liberation_savegame select 2;
	time_of_day = greuh_liberation_savegame select 3;
	combat_readiness = greuh_liberation_savegame select 4;
	GRLIB_garage = greuh_liberation_savegame select 5;
	if (typeName GRLIB_garage != "ARRAY") then {GRLIB_garage = []};

	if ( "capture_13_1_2_26_25" in blufor_sectors ) then { // Patching Molos Airfield which was a town instead of a factory
		blufor_sectors = blufor_sectors - [ "capture_13_1_2_26_25" ];
		blufor_sectors = blufor_sectors + [ "factory666" ];
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
	saved_intel_res = greuh_liberation_savegame select 14;
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

	_list_static = [];
	{_list_static pushBack ( _x select 0 )} foreach (static_vehicles);

	{
		_nextclass = _x select 0;

		if ( _nextclass in _classnames_to_save ) then {

			_nextpos = _x select 1;
			_nextdir = _x select 2;
			_hascrew = false;
			_owner = "";
			_color = "";
			_color_name = "";

			if ( count _x > 3 ) then {
				_hascrew = _x select 3;
			};

			if ( count _x > 4 ) then {
				_owner = _x select 4;
			};

			if ( count _x > 5 ) then {
				_color = _x select 5;
			};

			if ( count _x > 6 ) then {
				_color_name = _x select 6;
			};

			_nextbuilding = _nextclass createVehicle _nextpos;
			_nextbuilding allowDamage false;
			_nextbuilding setVectorUp [0,0,1];
			_nextbuilding setPosATL _nextpos;
			_nextbuilding setdir _nextdir;
			_nextbuilding setdamage 0;
			_nextbuilding allowDamage true;

			if (!(_nextclass in GRLIB_Ammobox)) then {
				clearWeaponCargoGlobal _nextbuilding;
				clearMagazineCargoGlobal _nextbuilding;
				clearItemCargoGlobal _nextbuilding;
				clearBackpackCargoGlobal _nextbuilding;
			};

			if ( _nextclass in vehicle_rearm_sources ) then {
				_nextbuilding setAmmoCargo 0;
			};

			if ( _nextclass in _building_classnames ) then {
				_nextbuilding setVariable [ "GRLIB_saved_pos", _nextpos, false];
			};

			if ( _hascrew ) then {
				[ _nextbuilding ] call F_forceBluforCrew;
			};

			if ( _owner != "" ) then {
				_nextbuilding setVehicleLock "LOCKED";
				_nextbuilding setVariable ["GRLIB_vehicle_owner", _owner, true];
				_nextbuilding setVariable ["R3F_LOG_disabled", true, true];
				[_nextbuilding, _color, _color_name, []] call RPT_fnc_TextureVehicle;
			};

			if (typeOf _nextbuilding in _list_static) then {
				_nextbuilding allowDamage false;
			};

			if ( !(_nextclass in no_kill_handler_classnames ) ) then {
				_nextbuilding addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
				_nextbuilding addEventHandler ["HandleDamage", damage_manager_EH];
			};

			if ( _nextclass in all_hostile_classnames ) then {
				_nextbuilding setVariable [ "GRLIB_captured", 1, true ];
			};

			if ( _nextclass == FOB_typename ) then {
				_nextbuilding allowDamage false;
				_nextbuilding addEventHandler ["HandleDamage", { 0 }];
			};

			if ( _nextclass == mobile_respawn ) then {
				GRLIB_mobile_respawn pushback _nextbuilding;
				_nextbuilding addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
			};

		};
	} foreach buildings_to_save;

	{
		private [ "_nextgroup", "_grp" ];
		_nextgroup = _x;
		_grp = createGroup [GRLIB_side_friendly, true];

		{
			private [ "_nextunit", "_nextpos", "_nextdir", "_nextobj"];
			_nextunit = _x;
			_nextpos = [(_nextunit select 1) select 0, (_nextunit select 1) select 1, ((_nextunit select 1) select 2) + 0.2];
			_nextdir = _nextunit select 2;
			(_nextunit select 0) createUnit [ _nextpos, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}] '];
			_nextobj = ((units _grp) select ((count (units _grp)) - 1));
			_nextobj setPosATL _nextpos;
			_nextobj setDir _nextdir;
		} foreach _nextgroup;
	} foreach ai_groups;
};

publicVariable "GRLIB_garage";
publicVariable "blufor_sectors";
publicVariable "GRLIB_all_fobs";
publicVariable "GRLIB_mobile_respawn";

if ( count GRLIB_vehicle_to_military_base_links == 0 ) then {
	private [ "_assigned_bases", "_assigned_vehicles", "_nextbase", "_nextvehicle" ];
	_assigned_bases = [];
	_assigned_vehicles = [];

	while { count _assigned_bases < count sectors_military && count _assigned_vehicles < count elite_vehicles } do {
		_nextbase =  ( [ sectors_military, { !(_x in _assigned_bases) } ] call BIS_fnc_conditionalSelect ) call BIS_fnc_selectRandom;
		_nextvehicle =  ( [ elite_vehicles, { !(_x in _assigned_vehicles) } ] call BIS_fnc_conditionalSelect ) call BIS_fnc_selectRandom;
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
publicVariable "GRLIB_vehicle_to_military_base_links";
publicVariable "GRLIB_permissions";
save_is_loaded = true; publicVariable "save_is_loaded";

// Manager Save Loop
while { true } do {
	waitUntil {trigger_server_save || GRLIB_endgame == 1};

	if ( GRLIB_endgame == 1 ) then {
		profileNamespace setVariable [ GRLIB_save_key, nil ];
		saveProfileNamespace;
		while { true } do { sleep 300; };
	} else {

		trigger_server_save = false;
		buildings_to_save = [];
		ai_groups = [];

		_all_buildings = [];
		{
			_fobpos = _x;
			_nextbuildings = [ _fobpos nearobjects (GRLIB_fob_range * 2), {
				((typeof _x) in _classnames_to_save ) &&
				( alive _x) &&
				( speed _x < 5 ) &&
				( isNull attachedTo _x ) &&
				(((getpos _x) select 2) < 10 ) &&
				( !(_x getVariable ['R3F_LOG_disabled', false]) || (_x getVariable ['GRLIB_vehicle_owner', "server"] != "server") ) &&
				( getObjectType _x >= 8 )
 				} ] call BIS_fnc_conditionalSelect;

			_all_buildings = _all_buildings + _nextbuildings;

			{
				_nextgroup = _x;
				if (  side _nextgroup == GRLIB_side_friendly ) then {
					if ( { isPlayer _x } count ( units _nextgroup ) == 0 ) then {
						if ( { alive _x } count ( units _nextgroup ) > 0  ) then {
							if ( _fobpos distance (leader _nextgroup) < GRLIB_fob_range * 2 ) then {
								private [ "_grouparray" ];
								_grouparray = [];
								{
									if ( alive _x && (vehicle _x == _x ) ) then {
										_grouparray pushback [ typeof _x, getPosATL _x, getDir _x ];
									};
								} foreach (units _nextgroup);

								ai_groups pushback _grouparray;
							};
						};
					};
				};
			} foreach allGroups;
		} foreach GRLIB_all_fobs;

		{
			private _savedpos = [];

			if ( (typeof _x) in _building_classnames ) then {
				_savedpos = _x getVariable [ "GRLIB_saved_pos", [] ];
				if ( count _savedpos == 0 ) then {
					_x setVariable [ "GRLIB_saved_pos", getposATL _x, false ];
					_savedpos = getposATL _x;
				};
			} else {
				_savedpos = getposATL _x;
			};

			private _nextclass = typeof _x;
			private _nextdir = getdir _x;
			private _hascrew = false;
			private _owner = "";
			private _color = "";
			private _color_name = "";
			private _skip = false;

			if ( _nextclass in _classnames_to_save_blu ) then {
				if ( ( { !isPlayer _x } count (crew _x) ) > 0 ) then {
					_hascrew = true;
				};
				_owner = _x getVariable ["GRLIB_vehicle_owner", ""];
				_color = _x getVariable ["GRLIB_vehicle_color", ""];
				_color_name = _x getVariable ["GRLIB_vehicle_color_name", ""];
			};

			if ( _nextclass in all_hostile_classnames ) then {
				_owner = _x getVariable ["GRLIB_vehicle_owner", ""];
				_color = _x getVariable ["GRLIB_vehicle_color", ""];
				_color_name = _x getVariable ["GRLIB_vehicle_color_name", ""];
				if (side _x == GRLIB_side_enemy) then {
					_skip = true;
				};
			};

			if (!_skip) then {
				buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner, _color, _color_name ];
			};
		} foreach _all_buildings;

		time_of_day = date select 3;

		stats_saves_performed = stats_saves_performed + 1;

		private [ "_newscores", "_knownplayers", "_playerindex", "_nextplayer" ];
		_knownplayers = [];
		_newscores = [] + GRLIB_player_scores;
		{ _knownplayers pushback (_x select 0) } foreach GRLIB_player_scores;

		{
			_nextplayer = _x;

			if ( (score _nextplayer >= 20) && (_nextplayer getVariable "GRLIB_score_set" == 1) ) then {
				_ammo = _nextplayer getVariable ["GREUH_ammo_count",0];
				_playerindex = _knownplayers find (getPlayerUID _nextplayer);
				if ( _playerindex >= 0 ) then {
					_newscores set [ _playerindex, [getPlayerUID _x, score _x, _ammo, name _x] ];
				} else {
					_newscores pushback [getPlayerUID _x, score _x, _ammo, name _x];
				};
			};
		} foreach allPlayers;
		GRLIB_player_scores = _newscores;

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
			0,0,0,		//free for extened use
			_stats,
			[ round infantry_weight, round armor_weight, round air_weight ],
			GRLIB_vehicle_to_military_base_links,
			GRLIB_permissions,
			ai_groups,
			resources_intel,
			GRLIB_player_scores
		];

		profileNamespace setVariable [ GRLIB_save_key, greuh_liberation_savegame ];
		saveProfileNamespace;
	};
};