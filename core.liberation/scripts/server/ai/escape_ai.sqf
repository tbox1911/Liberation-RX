params [ "_unit", "_friendly"];

private _grp = createGroup [GRLIB_side_civilian, true];
[_unit] joinSilent _grp;

_unit removeAllEventHandlers "GetInMan";
_unit removeAllEventHandlers "SeatSwitchedMan";
_unit removeAllEventHandlers "Take";
_unit addEventHandler ["GetInMan", {_this spawn vehicle_perm}];
_unit addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_perm}];
_unit addEventHandler ["Take", {removeAllWeapons (_this select 0)}];
[_unit, "flee"] remoteExec ["remote_call_prisoner", 0];
sleep 3;

if (_friendly) exitWith { [_grp, getPos _unit, 80] call BIS_fnc_taskPatrol};

private _nearest_sector = [GRLIB_spawn_min, _unit, opfor_sectors] call F_getNearestSector;
if (_nearest_sector != "") then {
    [_grp] call F_deleteWaypoints;
    _waypoint = _grp addWaypoint [markerPos _nearest_sector, 0];
    _waypoint setWaypointType "MOVE";
    _waypoint setWaypointSpeed "FULL";
    _waypoint setWaypointBehaviour "SAFE";
    _waypoint setWaypointCombatMode "BLUE";
    _waypoint setWaypointCompletionRadius 100;
    _waypoint setWaypointStatements ["true", "deleteVehicle this"];
    (units _grp) doFollow leader _grp;
} else {
    deleteVehicle _unit;
};
