params ["_dest_pos"];

private _spawn_sectors = sectors_airSpawn select { (markerpos _x) distance2D _dest_pos > GRLIB_spawn_max };
_spawn_sectors = ([_spawn_sectors, [_dest_pos], { (markerpos _x) distance2D _input0 }, "ASCEND"] call BIS_fnc_sortBy);

private ["_spawn_pos", "_dist"];
{
    _spawn_pos = markerPos _x;
    _dist = [_spawn_pos, false] call F_getNearestBluforObjective select 1;
    if (_dist > GRLIB_spawn_max) exitWith {};
} foreach _spawn_sectors;

_spawn_pos;
