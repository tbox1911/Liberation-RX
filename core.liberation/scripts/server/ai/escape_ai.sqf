params [ "_unit"];

private _side = side group _unit;
waitUntil { sleep 12; !(alive _unit) || isNull objectParent _unit };
if (!alive _unit) exitWith {};

private _sector_list = opfor_sectors;
if (_side == GRLIB_side_friendly) then {
    _sector_list = blufor_sectors;
};

private _nearest_sector = [_sector_list, _unit] call F_nearestPosition;
if (_nearest_sector != "") then {
    if (_unit distance2D (markerPos _nearest_sector) > 10) then {
        private _flee_grp = createGroup [_side, true];
		[_unit] joinSilent _flee_grp;
        [_flee_grp] call F_deleteWaypoints;
        _waypoint = _flee_grp addWaypoint [markerPos _nearest_sector, 0];
        _waypoint setWaypointType "MOVE";
        _waypoint setWaypointSpeed "FULL";
        _waypoint setWaypointBehaviour "SAFE";
        _waypoint setWaypointCombatMode "BLUE";
        _waypoint setWaypointCompletionRadius 50;
        _waypoint setWaypointStatements ["true", "deleteVehicle this"];
        { _x doFollow (leader _flee_grp) } foreach (units _flee_grp);
    } else {
        deleteVehicle _unit;
    };
} else {
    deleteVehicle _unit;
};
