params [ "_unit"];

waitUntil { sleep 12; !(alive _unit) || isNull objectParent _unit };
if (!alive _unit) exitWith {};

private _grp = group _unit;
private _sector_list = opfor_sectors;
if (side group _unit == GRLIB_side_friendly) then {
    _sector_list = blufor_sectors;
};

private _nearest_sector = [_sector_list, _unit] call F_nearestPosition;
if (_nearest_sector != "") then {
    private _dist = _unit distance2D (markerPos _nearest_sector);
    if (_dist > 50 && _dist < 2000) then {
        [_grp] call F_deleteWaypoints;
        _waypoint = _grp addWaypoint [markerPos _nearest_sector, 0];
        _waypoint setWaypointType "MOVE";
        _waypoint setWaypointSpeed "FULL";
        _waypoint setWaypointBehaviour "SAFE";
        _waypoint setWaypointCombatMode "BLUE";
        _waypoint setWaypointCompletionRadius 50;
        _waypoint setWaypointStatements ["true", "deleteVehicle this"];
        { _x doFollow (leader _grp) } foreach (units _grp);
    } else {
        waitUntil { sleep 30; (GRLIB_global_stop == 1 || [getPosATL _unit, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
        deleteVehicle _unit;
    };
} else {
    waitUntil { sleep 30; (GRLIB_global_stop == 1 || [getPosATL _unit, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
    deleteVehicle _unit;
};
