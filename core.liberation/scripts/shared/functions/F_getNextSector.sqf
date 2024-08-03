params ["_sector_list", "_start_marker", "_max_dist"];

private _ret = "";
private _dist = 0;
{
	_dist = (markerpos _x) distance2D (markerpos _start_marker);
	if (_dist > 200 && _dist < _max_dist) exitWith { _ret = _x };
} forEach _sector_list;

_ret;
