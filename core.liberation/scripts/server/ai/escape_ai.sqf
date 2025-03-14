params [ "_unit"];

private _grp = createGroup [GRLIB_side_civilian, true];
[_unit] joinSilent _grp;

_unit removeAllEventHandlers "GetInMan";
_unit removeAllEventHandlers "SeatSwitchedMan";
_unit removeAllEventHandlers "Take";
_unit addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["Take", {removeAllWeapons (_this select 0)}];
[_unit, "flee"] remoteExec ["remote_call_prisoner", 0];
sleep 3;

private _nearest_sector = [sectors_allSectors, _unit] call F_nearestPosition;
if (_nearest_sector != "") then {
    private _dist = _unit distance2D (markerPos _nearest_sector);
    if (_dist <= GRLIB_spawn_min) then {
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
} else {
    sleep 60;
    deleteVehicle _unit;
};
