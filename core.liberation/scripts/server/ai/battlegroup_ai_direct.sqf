params ["_grp", "_objective"];
if (isNil "_grp" || isNil "_objective") exitWith {};
if (isNull _grp) exitWith {};

private _vehicle = objectParent leader _grp;
if (_vehicle isKindOf "Ship_F") exitWith {
	[_grp, getPosATL _vehicle] spawn defence_ai;
};

if (_vehicle isKindOf "ParachuteBase") then {
	_vehicle = objNull;
	waitUntil { sleep 1; ({getPos _x select 2 > 2} count (units _grp) == 0) };
};

sleep 15;
private _last_pos = getPosATL (leader _grp);
diag_log format ["Group %1 - Attack Direct: %2 - Distance: %3m", _grp, typeOf _objective, round (_last_pos distance2D _objective)];

private ["_waypoint", "_wp0", "_objective_pos"];
while { alive _objective } do {
	if ({alive _x} count (units _grp) == 0) exitWith {};
	{
		if (surfaceIsWater (getPos _x) && _x distance2D _objective > (GRLIB_sector_size * 1.5)) then { deleteVehicle _x } else { [_x] call F_fixPosUnit };
		sleep 0.5;
	} forEach (units _grp);

	_objective_pos = getPosATL _objective;

	[_grp] call F_deleteWaypoints;
	_waypoint = _grp addWaypoint [_objective_pos, 10];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "YELLOW";
	_waypoint setWaypointCompletionRadius 50;
	_waypoint = _grp addWaypoint [_objective_pos, 30];
	_waypoint setWaypointType "MOVE";
	_waypoint = _grp addWaypoint [_objective_pos, 30];
	_waypoint setWaypointType "MOVE";
	_waypoint = _grp addWaypoint [_objective_pos, 30];
	_waypoint setWaypointType "MOVE";
	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";
	sleep 1;
	(units _grp) doFollow leader _grp;
	if (alive (leader _grp)) then { _last_pos = getPosATL (leader _grp) };
	sleep 300;
};

// Cleanup
waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_last_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
{ deleteVehicle _x } forEach (units _grp);
deleteGroup _grp;
