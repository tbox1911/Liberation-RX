params ["_start_marker", "_radius", "_sector_list", "_max_wp"];

private _destinations_markers = [_start_marker];
private _next_marker = "";

_sector_list = _sector_list call BIS_fnc_arrayShuffle;
while { count _destinations_markers < _max_wp } do {
	_next_marker = [_sector_list, _start_marker, _radius, _destinations_markers] call F_getNextSector;
	if (_next_marker == "") exitWith {};
	if ([markerPos _start_marker, markerPos _next_marker] call F_isWaterBetween) exitWith {};

	_destinations_markers pushback _next_marker;
	_start_marker = _next_marker;
	_sector_list = _sector_list - [_next_marker];
};

_destinations_markers;
