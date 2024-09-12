params [ "_unit"];

private _nearest_sector = [opfor_sectors, _unit] call F_nearestPosition;
if (_nearest_sector != "") then {
    private _grp = group _unit;
    private _dist = _unit distance2D (markerPos _nearest_sector);
    if (_dist < GRLIB_spawn_max) then {
        [_grp] call F_deleteWaypoints;
        _waypoint = _grp addWaypoint [markerPos _nearest_sector, 0];
        _waypoint setWaypointType "MOVE";
        _waypoint setWaypointSpeed "FULL";
        _waypoint setWaypointBehaviour "SAFE";
        _waypoint setWaypointCombatMode "BLUE";
        _waypoint setWaypointCompletionRadius 50;
        _waypoint setWaypointStatements ["true", "deleteVehicle this"];
        { _x doFollow (leader _grp) } foreach (units _grp);
    };
};
