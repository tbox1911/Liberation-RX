if (!isServer && hasInterface) exitWith {};
params ["_player", "_vehicle"];

private _crew = crew _vehicle;
if (count _crew == 0) exitWith {};
_crew allowGetIn false;
{
	[
		[_x],
	{
		params ["_unit"];
		unassignVehicle _unit;
		doGetOut _unit;
		sleep 2;
		if (!isNull (objectParent _unit)) then { 
			moveOut _unit
		};
	}] remoteExec ["bis_fnc_call", owner _x];
	sleep 0.2;
} forEach _crew;

private _grp = group (_crew select 0);
if (side _grp == GRLIB_side_civilian && !([_player, _vehicle] call is_owner)) then {
    [localize "STR_DO_EJECT"] remoteExec ["hintSilent", owner _player];
    ["vtolAlarm"] remoteExec ["playSound", owner _player];
	[_player, -5] call F_addScore;

	private _nearest_sector = [sectors_allSectors, _vehicle] call F_nearestPosition;

	if (typeName _nearest_sector == "STRING") then {
		while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
		{_x doFollow leader _grp} foreach units _grp;

		_waypoint = _grp addWaypoint [markerPos _nearest_sector, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "FULL";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointCompletionRadius 50;

		_waypoint = _grp addWaypoint [markerPos _nearest_sector, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointStatements ["true", "deleteVehicle this"];
		sleep 10;
	} else {
		sleep 60;
		{ deleteVehicle _x } forEach _crew;
	};
};

sleep 3;
_crew allowGetIn true;
