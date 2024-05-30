params ["_dest_pos"];

private ["_spawn_pos", "_dist", "_blufor"];

private _spawn_sectors = ([sectors_airspawn, [_dest_pos], { (markerpos _x) distance2D _input0 }, "ASCEND"] call BIS_fnc_sortBy);
{
    _spawn_pos = markerPos _x;
    _dist = [_spawn_pos, true, false] call F_getNearestBluforObjective select 1;
    if (_spawn_pos distance2D _dest_pos > GRLIB_spawn_max && _dist > GRLIB_spawn_max) exitWith {};
} foreach _spawn_sectors;

_spawn_pos;
