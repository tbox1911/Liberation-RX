if (!isServer && hasInterface) exitWith {};
params ["_player", "_vehicle"];

private _crew = crew _vehicle;
if (count _crew == 0) exitWith {};

private _grp = group (_crew select 0);
{ [_x, false] spawn F_ejectUnit; sleep 0.1 } forEach _crew;

if (side _grp == GRLIB_side_civilian && !([_player, _vehicle] call is_owner)) then {
    [localize "STR_DO_EJECT"] remoteExec ["hintSilent", owner _player];
    ["vtolAlarm"] remoteExec ["playSoundNow", owner _player];
	[_player, -5] call F_addScore;

	private _nearest_sector = [sectors_allSectors, _vehicle] call F_nearestPosition;

	if (typeName _nearest_sector == "STRING") then {
		[_grp] call F_deleteWaypoints;
		private _waypoint = _grp addWaypoint [markerPos _nearest_sector, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "FULL";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointCombatMode "BLUE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointStatements ["true", "deleteVehicle this"];
		{_x doFollow leader _grp} foreach units _grp;
		sleep 10;
	} else {
		sleep 60;
		{ deleteVehicle _x } forEach _crew;
	};
};
