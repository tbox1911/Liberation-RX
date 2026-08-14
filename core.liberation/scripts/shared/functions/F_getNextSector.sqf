params ["_sector_list", "_start_marker", "_max_dist"];

private _ret = "";
private _startpos = markerpos _start_marker;
{
	if (_startpos distance2D (markerpos _x) <= _max_dist) exitWith { _ret = _x };
} forEach _sector_list;

_ret;
