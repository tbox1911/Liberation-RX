params ["_dest_pos"];

private _spawn_sectors = sectors_airSpawn select { (markerpos _x) distance2D _dest_pos > GRLIB_spawn_max };
_spawn_sectors = ([_spawn_sectors, [_dest_pos], { (markerpos _x) distance2D _input0 }, "ASCEND"] call BIS_fnc_sortBy);

private ["_spawn_pos", "_countblufor"];
{
    _spawn_pos = markerPos _x;
    _countblufor = {
        (alive _x) && !(captive _x) &&
        (_x distance2D _spawn_pos < GRLIB_sector_size) &&
        ((getPosATL _x) select 2 < 150) && (speed (vehicle _x) <= 80)
    } count (units GRLIB_side_friendly);
    if (_countblufor == 0) exitWith {};
} foreach _spawn_sectors;

_spawn_pos;
