// Filter markers list too close from blufor sectors / FOB
params ["_markers", ["_fob_only", false]];

if (count _markers == 0) exitWith {[]};

private ["_keep_sector", "_sector", "_sector_pos"];
private _list = [];

{
	_keep_sector = true;
	_sector = _x select 0;
	_sector_pos = markerPos _sector;

	if (!_fob_only) then {
		{
			if (_sector_pos distance2D (markerPos _x) < GRLIB_sector_size) exitWith { _keep_sector = false };
		} foreach blufor_sectors;
	};

	{
		if (_sector_pos distance2D _x < GRLIB_sector_size) exitWith { _keep_sector = false };
	} foreach GRLIB_all_fobs;

	if (_sector in (A3W_sectors_in_use + active_sectors)) then { _keep_sector = false };

	if (_keep_sector) then { _list pushBack _x };
} forEach _markers;

_list;
