params ["_sector_list", "_prev_sector", "_max_dist", "_sector_banned"];
private _ret = "";
{
	_sector = _x;
	_dist = (markerpos _sector) distance2D (markerpos _prev_sector);
	if (! (_sector in _sector_banned) && _dist > 200 && _dist < _max_dist) exitWith { _ret = _sector };
} forEach _sector_list;
_ret;
