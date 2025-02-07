params ["_radius", ["_postosearch", getPosATL player], ["_sector_list", sectors_allSectors]];

private _sector_to_return = "";
private _close_sectors = _sector_list select { (markerPos _x) distance2D _postosearch < _radius };
private _close_sectors_sorted = [_close_sectors, [_postosearch] , { (markerPos _x) distance2D _input0 }, 'ASCEND'] call BIS_fnc_sortBy;
if (count _close_sectors_sorted > 0) then { _sector_to_return = _close_sectors_sorted select 0; };

_sector_to_return;
