// Filter markers list too close from blufor sectors and/or FOB
params ["_markers", ["_fob_only", false], ["_opfor", false]];

if (count _markers == 0) exitWith {[]};

private ["_keep_sector", "_sector", "_sector_pos"];
private _list = [];

{
	_keep_sector = true;
	_sector = _x select 0;
	_sector_pos = markerPos _sector;

	if (_opfor) then {
		if (_sector in opfor_sectors) then { _keep_sector = false };
	} else {
		if (_sector in (A3W_sectors_in_use + active_sectors)) then { _keep_sector = false };
		{
			if (_x distance2D _sector_pos < GRLIB_spawn_min) exitWith { _keep_sector = false };
		} foreach GRLIB_all_fobs;

		if (!_fob_only && _keep_sector) then {
			{
				if ((markerPos _x) distance2D _sector_pos < (GRLIB_sector_size * 1.25)) exitWith { _keep_sector = false };
			} foreach blufor_sectors;
		};
	};
	if (_keep_sector) then { _list pushBack _x };
} forEach _markers;

_list;
