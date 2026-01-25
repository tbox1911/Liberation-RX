params ["_radius", ["_postosearch", getPosATL player], ["_sector_list", sectors_allSectors], ["_check_water", false]];

private _close_sectors = [];
if (_check_water) then {
    _close_sectors = _sector_list select { (markerPos _x) distance2D _postosearch <= _radius && !([_postosearch, (markerPos _x)] call F_isWaterBetween) };
} else {
    _close_sectors = _sector_list select { (markerPos _x) distance2D _postosearch <= _radius};
};
private _close_sectors_sorted = [_close_sectors, [_postosearch] , { (markerPos _x) distance2D _input0 }, 'ASCEND'] call BIS_fnc_sortBy;

if (count _close_sectors_sorted == 0) exitWith { "" };
(_close_sectors_sorted select 0);
