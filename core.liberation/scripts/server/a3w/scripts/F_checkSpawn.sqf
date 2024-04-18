// Mission spawn trop proche d'un secteur capture
params ['_markers'];

private ["_ret", "_sector", "_state", "_timer"];
private _list = [];

{
	_ret = true;
	_sector = _x select 0;
	_state = _x select 1;
	_timer = _x select 2;
	if !(_sector in (A3W_sectors_in_use + active_sectors)) then {
		{		
			if ( (markerPos _x) distance2d (markerPos _sector) < GRLIB_sector_size) exitWith { _ret = false };
		} foreach blufor_sectors;
		if (_ret) then { _list pushBack [_sector, _state, _timer] };
	};
} forEach _markers;

_list;
