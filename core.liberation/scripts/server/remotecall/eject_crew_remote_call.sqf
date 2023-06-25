if (!isServer && hasInterface) exitWith {};
params ["_player", "_vehicle"];

private _crew = crew _vehicle;
if (count _crew == 0) exitWith {};

{ [_vehicle, _x] spawn F_ejectUnit } forEach _crew;

private _grp = group (_crew select 0);
if (side _grp == GRLIB_side_civilian && !([_player, _vehicle] call is_owner)) then {
    [localize "STR_DO_EJECT"] remoteExec ["hintSilent", owner _player];
    ["vtolAlarm"] remoteExec ["playSound", owner _player];
	[_player, -5] call F_addScore;

	private _nearest_sector = [sectors_allSectors, _vehicle] call F_nearestPosition;

	if (typeName _nearest_sector == "STRING") then {
		[_grp] call F_deleteWaypoints;
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
