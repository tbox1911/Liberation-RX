params [ "_mission_index", ["_mission_free", false], "_caller_id"];

if (!isServer && hasInterface) exitWith {};
if ( GRLIB_secondary_starting ) exitWith { diag_log "-- LRX Error: Multiple calls to start secondary mission !!" };

GRLIB_secondary_starting = true; publicVariable "GRLIB_secondary_starting";

_mission_cost = GRLIB_secondary_missions_costs select _mission_index;
if (_mission_free) then { _mission_cost = 0 };

private _caller = "LRX Server";
if !(isNil "_caller_id") then {
	_name = name (_caller_id call BIS_fnc_getUnitByUID);
	_caller = format ["Player: %1(%2)", _name, _caller_id];
};

if ( _mission_index == 0 ) then { [_mission_cost, _caller] call fob_hunting };
if ( _mission_index == 1 ) then { [_mission_cost, _caller] call convoy_hijack };
if ( _mission_index == 2 ) then { [_mission_cost, _caller] call search_and_rescue };
if ( _mission_index == 3 ) then { [_mission_cost, _caller] call final_situaton };

GRLIB_secondary_starting = false; publicVariable "GRLIB_secondary_starting";