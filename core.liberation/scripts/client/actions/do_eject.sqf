params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

_crew = crew _vehicle;
_grp = group (_crew select 0);
_crew allowGetIn false;
{
	if (alive _x && lifeState _x != "INCAPACITATED") then {
		unassignVehicle _x;
		commandGetOut _x;
		doGetOut _x;
	} else {
		moveOut _x;
	};
} forEach _crew;

if (side _grp == GRLIB_side_civilian) then {
	hintSilent localize "STR_DO_EJECT";
	playSound "vtolAlarm";
	[player, -5] remoteExec ["addScore", 2];

	private _nearest_sector = [sectors_allSectors, _vehicle] call F_nearestPosition;

	if (typeName _nearest_sector == "STRING") then {

		while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
		{_x doFollow leader _grp} foreach units _grp;

		_waypoint = _grp addWaypoint [markerPos _nearest_sector, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "FULL";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointCompletionRadius 50;

		_waypoint = _grp addWaypoint [markerPos _nearest_sector, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointStatements ["true", "deleteVehicle this"];
		sleep 10;
	};

};
