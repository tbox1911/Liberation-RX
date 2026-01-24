params ["_dest_pos", "_side"];

private _spawn_sectors = sectors_airSpawn select { (markerpos _x) distance2D _dest_pos > GRLIB_spawn_max };
if (_side == GRLIB_side_enemy) then {
    _spawn_sectors = _spawn_sectors select { ([(markerpos _x), false] call F_getNearestBluforObjective select 1) > GRLIB_spawn_max };
};
_spawn_sectors = ([_spawn_sectors, [_dest_pos], { (markerpos _x) distance2D _input0 }, "ASCEND"] call BIS_fnc_sortBy);

if (count _spawn_sectors == 0) exitWith { [] };
(markerPos (_spawn_sectors select 0));
