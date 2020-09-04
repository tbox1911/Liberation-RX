// Save the game state in ProfileNamespace
if (!isServer) exitWith {};

buildings_to_save = [];
private _all_buildings = [];
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
		_hascrew = _x getVariable ["GRLIB_vehicle_manned", false];
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

_saved_score = [];
{ if ((_x select 1) >= 20) then {_saved_score pushback _x} } forEach GRLIB_player_scores;

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
	0,  //ai_groups
	resources_intel,
	_saved_score
];

profileNamespace setVariable [ GRLIB_save_key, greuh_liberation_savegame ];
saveProfileNamespace;