// Filter markers list too close from blufor sectors and/or FOB
params ["_markers"];

if (count _markers == 0) exitWith {[]};

private ["_keep_sector", "_sector", "_sector_pos"];
private _list = [];

{
	_keep_sector = true;
	_sector = _x select 0;
	_sector_pos = markerPos _sector;

	// no opfor sector
	if (_sector in opfor_sectors) then { _keep_sector = false };

	// sector in use
	if (_sector in (active_sectors + A3W_sectors_in_use)) then { _keep_sector = false };

	if (_keep_sector) then {
		// sector too close from any FOB
		if (_sector_pos distance2D ([_sector_pos] call F_getNearestFob) <= (GRLIB_sector_size * 1.25)) then { _keep_sector = false };
	};

	if (_keep_sector) then {
		// sector too far from any blufor sectors
		if (([GRLIB_spawn_min, _sector_pos, blufor_sectors] call F_getNearestSector) == "") then { _keep_sector = false };
	};

	if (_keep_sector) then {
		// sector too close from any opfor sectors
		if (([(GRLIB_sector_size * 1.25), _sector_pos, opfor_sectors] call F_getNearestSector) != "") then { _keep_sector = false };
	};

	if (_keep_sector) then { _list pushBack _x };

} forEach _markers;

_list;
