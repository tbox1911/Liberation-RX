params ["_sector_list", "_prev_sector", "_max_dist", "_sector_banned"];

private _ret = "";
private _dist = 0;
{
	_dist = (markerpos _x) distance2D (markerpos _prev_sector);
	if (! (_x in _sector_banned) && _dist > 200 && _dist < _max_dist) exitWith { _ret = _x };
} forEach _sector_list;

_ret;
