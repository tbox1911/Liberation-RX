params [ ["_mission_cost", 0] ];

private _spawn_marker = [GRLIB_spawn_min, 99999, false] call F_findOpforSpawnPoint;
if ( _spawn_marker == "" ) exitWith { [gamelogic, "Could not find position for search and rescue mission"] remoteExec ["globalChat", 0] };
used_positions pushbackUnique _spawn_marker;
resources_intel = resources_intel - _mission_cost;

private _helopos = [ getmarkerpos _spawn_marker, random 200, random 360 ] call BIS_fnc_relPos;
private _helowreck = GRLIB_sar_wreck createVehicle _helopos;
_helowreck allowDamage false;
_helowreck setPos _helopos;
_helowreck setPos _helopos;
private _helowreckDir = (random 360);
_helowreck setDir _helowreckDir;

private _helofire = GRLIB_sar_fire createVehicle (getpos _helowreck);

private _pilotsGrp = createGroup [GRLIB_side_enemy, true];
private _pilotsPos = [ getpos _helowreck, 25, random 360 ] call BIS_fnc_relPos;
pilot_classname createUnit [ _pilotsPos, _pilotsGrp,'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "private"];
pilot_classname createUnit [ _pilotsPos, _pilotsGrp,'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "private"];
private _pilotUnits = units _pilotsGrp;
{
	[ _x, true ] spawn prisonner_ai;
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

while {(count (waypoints _grppatrol)) != 0} do {deleteWaypoint ((waypoints _grppatrol) select 0);};
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

{ ( [ [ getpos _helowreck, 30 + (random 30), random 360 ] call BIS_fnc_relPos , _x, true ] call F_libSpawnVehicle ) addMPEventHandler ['MPKilled', {_this spawn kill_manager}]; } foreach _vehtospawn;

secondary_objective_position = getpos _helowreck;
secondary_objective_position_marker = [ secondary_objective_position, 800, random 360 ] call BIS_fnc_relPos;
publicVariable "secondary_objective_position_marker";
sleep 1;
GRLIB_secondary_in_progress = 2; publicVariable "GRLIB_secondary_in_progress";
[ 6 ] remoteExec ["remote_call_intel", 0];

waitUntil {
	sleep 5;
	{ ( alive _x ) && ( _x distance ( [ getpos _x ] call F_getNearestFob ) > 50 ) } count _pilotUnits == 0
};

sleep 5;

private _alive_crew_count = { alive _x } count _pilotUnits;
if ( _alive_crew_count == 0 ) then {
	[ 7 ] remoteExec ["remote_call_intel", 0];
} else {
	[ 8 ] remoteExec ["remote_call_intel", 0];
	private _grp = createGroup [GRLIB_side_friendly, true];
	_pilotUnits joinSilent _grp;
	while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
	{_x doFollow (leader _grp)} foreach units _grp;
	{ [ _x ] spawn { sleep 600; deleteVehicle (_this select 0) } } foreach _pilotUnits;
};

resources_intel = resources_intel + (25 * _alive_crew_count);
combat_readiness = combat_readiness - 10;
stats_secondary_objectives = stats_secondary_objectives + 1;

sleep 3;
{ moveOut _x; deleteVehicle _x } forEach units _grppatrol;
deleteVehicle _helowreck;
deleteVehicle _helofire;

sleep 60;
GRLIB_secondary_in_progress = -1; publicVariable "GRLIB_secondary_in_progress";
used_positions = [];
