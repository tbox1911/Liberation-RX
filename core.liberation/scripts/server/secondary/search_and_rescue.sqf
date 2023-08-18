params [ ["_mission_cost", 0], "_caller" ];

private _spawn_marker = [GRLIB_spawn_min, 99999, false] call F_findOpforSpawnPoint;
if ( _spawn_marker == "" ) exitWith { [gamelogic, "Could not find position for search and rescue mission"] remoteExec ["globalChat", 0] };
GRLIB_secondary_used_positions pushbackUnique _spawn_marker;

diag_log format ["--- LRX: %1 start static mission: SAR at %2", _caller, time];
resources_intel = resources_intel - _mission_cost;
GRLIB_secondary_in_progress = 2;
publicVariable "GRLIB_secondary_in_progress";

[ 6 ] remoteExec ["remote_call_intel", 0];

private _helopos = markerpos _spawn_marker;
private _helowreck = GRLIB_sar_wreck createVehicle _helopos;
_helowreck allowDamage false;
_helowreck setpos (getpos _helowreck);

private _helofire = GRLIB_sar_fire createVehicle (getpos _helowreck);

private _pilotsGrp = createGroup [GRLIB_side_enemy, true];
private _pilotsPos = [ getpos _helowreck, 25, random 360 ] call BIS_fnc_relPos;
pilot_classname createUnit [ _pilotsPos, _pilotsGrp,'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "private"];
pilot_classname createUnit [ _pilotsPos, _pilotsGrp,'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "private"];
private _pilotUnits = units _pilotsGrp;
{
	[ _x, true, false ] spawn prisonner_ai;
	_x setDir (random 360);
} foreach (_pilotUnits);
sleep 5;

private _patrolcorners = [
	[ (getpos _helowreck select 0) - 40, (getpos _helowreck select 1) - 40, 0 ],
	[ (getpos _helowreck select 0) + 40, (getpos _helowreck select 1) - 40, 0 ],
	[ (getpos _helowreck select 0) + 40, (getpos _helowreck select 1) + 40, 0 ],
	[ (getpos _helowreck select 0) - 40, (getpos _helowreck select 1) + 40, 0 ]
];

private _grppatrol = [_patrolcorners select 0, ([] call F_getAdaptiveSquadComp), GRLIB_side_enemy, "infantry"] call F_libSpawnUnits;

[_grppatrol] call F_deleteWaypoints;
{
	_waypoint = _grppatrol addWaypoint [_x, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointCompletionRadius 5;
} foreach _patrolcorners;

_waypoint = _grppatrol addWaypoint [(_patrolcorners select 0), 0];
_waypoint setWaypointType "CYCLE";
{_x doFollow (leader _grppatrol)} foreach units _grppatrol;

private _nbsentry = 2 + (floor (random 3));
private _unitclass = [];
while { (count _unitclass) < _nbsentry } do { _unitclass pushback opfor_sentry };	
_grpsentry = [_pilotsPos, _unitclass, GRLIB_side_enemy, "infantry"] call F_libSpawnUnits;

private _vehicle_pool = opfor_vehicles;
if ( combat_readiness < 50 ) then {
	_vehicle_pool = opfor_vehicles_low_intensity;
};

private _vehtospawn = [];
private _spawnchances = [75,50,15];
{ if (random 100 < _x ) then { _vehtospawn pushBack (selectRandom _vehicle_pool); }; } foreach _spawnchances;

private _vehicle_list = [];
{ 
	_vehicle = [[getpos _helowreck, 30 + (random 30), random 360] call BIS_fnc_relPos, _x, true] call F_libSpawnVehicle;
	_vehicle setVariable ["GRLIB_vehicle_owner", "server"];
	_vehicle addMPEventHandler ['MPKilled', {_this spawn kill_manager}]; 
	_vehicle_list pushBack _vehicle;
} foreach _vehtospawn;

secondary_objective_position = getpos _helowreck;
secondary_objective_position_marker = [ secondary_objective_position, 800, random 360 ] call BIS_fnc_relPos;
publicVariable "secondary_objective_position_marker";

waitUntil {
	sleep 5;
	({(alive _x) && !([_x, "FOB", 50] call F_check_near)} count _pilotUnits == 0)
};

sleep 5;

private _alive_crew_count = { alive _x } count _pilotUnits;
if ( _alive_crew_count == 0 ) then {
	// failed
	[ 7 ] remoteExec ["remote_call_intel", 0];
	[_vehicle_list, 10, true] spawn cleanMissionVehicles;
} else {
	// success
	[ 8 ] remoteExec ["remote_call_intel", 0];
	{ _x setVariable ["GRLIB_vehicle_owner", ""] } foreach _vehicle_list;
	[_vehicle_list, 300] spawn cleanMissionVehicles;
	resources_intel = resources_intel + (25 * _alive_crew_count);
	combat_readiness = combat_readiness - 10;
	stats_secondary_objectives = stats_secondary_objectives + 1;
};

sleep 5;
{ moveOut _x; deleteVehicle _x } forEach units _grppatrol;
{ moveOut _x; deleteVehicle _x } forEach units _grpsentry;
deleteVehicle _helowreck;
deleteVehicle _helofire;

sleep 60;
GRLIB_secondary_in_progress = -1;
publicVariable "GRLIB_secondary_in_progress";
GRLIB_secondary_used_positions = [];
