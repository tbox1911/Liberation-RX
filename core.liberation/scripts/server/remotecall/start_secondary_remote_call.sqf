if (!isServer && hasInterface) exitWith {};
if ( isNil "GRLIB_secondary_starting" ) then { GRLIB_secondary_starting = false; };
if ( GRLIB_secondary_starting ) exitWith { diag_log "Multiple calls to start secondary mission : shouldn't be possible, isn't allowed"; };
if ( isNil "used_positions" ) then { used_positions = []; };

GRLIB_secondary_starting = true; publicVariable "GRLIB_secondary_starting";
params [ "_mission_index", ["_mission_free", false] ];

_mission_cost = GRLIB_secondary_missions_costs select _mission_index;
if (_mission_free) then {_mission_cost = 0 };

if ( _mission_index == 0 ) then { [_mission_cost] call fob_hunting; };
if ( _mission_index == 1 ) then { [_mission_cost] call convoy_hijack; };
if ( _mission_index == 2 ) then { [_mission_cost] call search_and_rescue; };

GRLIB_secondary_starting = false; publicVariable "GRLIB_secondary_starting";