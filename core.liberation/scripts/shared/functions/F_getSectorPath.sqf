params ["_start_pos", "_radius", "_sector_list", "_max_wp"];
private _destinations_markers = [];
private _next_pos = "";
_destinations_markers pushback _start_pos;

_sector_list = _sector_list call BIS_fnc_arrayShuffle;
while { count _destinations_markers < _max_wp } do {
	_next_pos = [_sector_list, _start_pos, _radius, _destinations_markers] call F_getNextSector;
	if (_next_pos == "") exitWith {};
	_destinations_markers pushback _next_pos;
	_start_pos = _next_pos;
};
_destinations_markers;