//--- LRX Savegame
params [["_force", false]];
if (!isServer) exitWith {};
if (!isNil "GRLIB_server_stopped") exitWith {};

private _save_warmup = 300;
if (time < _save_warmup && !_force) exitWith {diag_log format ["--- LRX MP Warmup (no save done), %1sec remaining...", round (_save_warmup - time)];};
diag_log format ["--- LRX Save start at %1", time];

private _classnames_to_save = [] + all_buildings_classnames;
private _classnames_to_save_blu = [FOB_typename, FOB_outpost, FOB_sign, huron_typename] + all_friendly_classnames;
{
	_classnames_to_save_blu pushback (_x select 0);
} foreach ind_recyclable;

_classnames_to_save_blu = _classnames_to_save_blu arrayIntersect _classnames_to_save_blu;
_classnames_to_save append (_classnames_to_save_blu + all_hostile_classnames);
_classnames_to_save = _classnames_to_save arrayIntersect _classnames_to_save;

private _vehicles_light = GRLIB_vehicle_blacklist + list_static_weapons + uavs + [mobile_respawn];
{ _vehicles_light pushback (_x select 0) } foreach support_vehicles;
_vehicles_light = _vehicles_light arrayIntersect _vehicles_light;

if ( GRLIB_endgame >= 1 ) then {
    if (GRLIB_param_wipe_keepscore == 1) then {
        GRLIB_permissions = profileNamespace getVariable GRLIB_save_key select 12;
        GRLIB_player_scores = [];
        {
            if (_x select 1 > GRLIB_perm_tank) then {
                _x set [1, GRLIB_perm_tank];  	// score
            };
            if (_x select 2 > 3000) then {
				_x set [2, 3000];  				// ammo
			};
            _x set [3, GREUH_start_fuel];  		// fuel
            GRLIB_player_scores pushback _x;
        } foreach (profileNamespace getVariable GRLIB_save_key select 15);

        private _savegame = [
            [],
            [],
            [],
            time_of_day,
            0,
            [],
            GRLIB_mod_west,
            GRLIB_mod_east,
            [],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [33, 33, 33],
            [],
            GRLIB_permissions,
            [],
            0,
            GRLIB_player_scores
        ];
        profileNamespace setVariable [ GRLIB_save_key, _savegame ];
    } else {
        profileNamespace setVariable [ GRLIB_save_key, nil ];
    };
    saveProfileNamespace;
} else {
    buildings_to_save = [];
    private _all_buildings = [];
    {
        _fobpos = _x;
        _nextbuildings = [ _fobpos nearobjects (GRLIB_fob_range * 2), {
            ( getObjectType _x >= 8 ) &&
            ( !isSimpleObject _x ) &&
            ((typeof _x) in _classnames_to_save ) &&
            ( alive _x) &&
            ( speed vehicle _x < 5 ) &&
            ( isNull attachedTo _x ) &&
            (((getPosATL _x) select 2) < 10 ) &&
            (_x getVariable ["GRLIB_vehicle_owner", ""] != "server")
        }] call BIS_fnc_conditionalSelect;
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

    // Save objects
    {
        private _savedpos = getPosWorld _x;
        private _nextclass = typeof _x;
        private _nextdir = [vectorDir _x, vectorUp _x];
        private _hascrew = false;
        private _owner = "";
        private _color = "";
        private _color_name = "";
        private _lst_a3 = [];
        private	_lst_r3f = [];
        private	_lst_grl = [];
        private _compo = [];

        if ( _nextclass in _classnames_to_save_blu + all_hostile_classnames ) then {
            if (side _x != GRLIB_side_enemy) then {
                _owner = _x getVariable ["GRLIB_vehicle_owner", ""];
                _hascrew = _x getVariable ["GRLIB_vehicle_manned", false];
                if (_owner == "") then {
                    buildings_to_save pushback [ _nextclass, _savedpos, _nextdir ];
                };
                if (_owner == "public") then {
                    buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner ];
                };

                if (_owner in _keep_score_id) then {
                    if (_nextclass in _vehicles_light) then {
                        if ( _nextclass == playerbox_typename ) then {
                            buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner, [_x] call F_getCargo ];
                        } else {
                            buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner ];
                        };
                    } else {
                        //_color = _x getVariable ["GRLIB_vehicle_color", ""];
                        _color = "";
                        _color_name = _x getVariable ["GRLIB_vehicle_color_name", ""];
                        _compo = _x getVariable ["GRLIB_vehicle_composant", []];
                        _lst_a3 = [_x] call F_getCargo;
                        {_lst_r3f pushback (typeOf _x)} forEach (_x getVariable ["R3F_LOG_objets_charges", []]);
                        {_lst_grl pushback (typeOf _x)} forEach (_x getVariable ["GRLIB_ammo_truck_load", []]);
                        buildings_to_save pushback [ _nextclass, _savedpos, _nextdir, _hascrew, _owner, _color, _color_name, _lst_a3, _lst_r3f, _lst_grl, _compo];
                    };
                };
            };
        } else {
            buildings_to_save pushback [ _nextclass, _savedpos, _nextdir ];
        };
    } foreach _all_buildings;

    // Save scores
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
        _unit = _uid call BIS_fnc_getUnitByUID;
        [_unit, _uid] call save_context;
        _buffer = localNamespace getVariable [format ["player_context_%1", _uid], []];
        if (count _buffer > 0) then {
            _player_context pushBack _buffer;
        } else {
            {if (_x select 0 == _uid) exitWith {_player_context pushBack _x}} foreach GRLIB_player_context;
        }
    } forEach _keep_score_id;

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
    _stats pushback stats_prisonners_captured;
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
        (blufor_sectors - ["final_fight"]),
        GRLIB_all_fobs,
        buildings_to_save,
        time_of_day,
        round combat_readiness,
        GRLIB_garage,
        GRLIB_mod_west,
        GRLIB_mod_east,
        _warehouse,
        _stats,
        [ round infantry_weight max 33, round armor_weight max 33, round air_weight max 33 ],
        GRLIB_vehicle_to_military_base_links,
        _permissions,
        _player_context,
        resources_intel,
        _player_scores
    ];

    profileNamespace setVariable [ GRLIB_save_key, _lrx_liberation_savegame ];
    saveProfileNamespace;
    diag_log format [ "--- LRX Save %1 in Profile at %2", GRLIB_save_key, time ];
};
