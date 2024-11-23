params ["_radius", "_sector_list", ["_min_wp", 3], ["_max_try", 10], ["_check_water", true]];

if (count _sector_list < _min_wp) exitWith {[]};

private _destinations_markers = [];
private _sector_list_tmp = [];
private _start_marker = "";
private _next_marker = "";

while { count _destinations_markers < _min_wp && _max_try > 0} do {
	_start_marker = selectRandom _sector_list;
	_destinations_markers = [_start_marker];
	_sector_list_tmp = _sector_list - [_start_marker];

	while { count _destinations_markers < _min_wp && count _sector_list_tmp > _min_wp} do {
		_next_marker = [_sector_list_tmp, _start_marker, _radius] call F_getNextSector;
		if (_next_marker != "") then {
			if (_check_water && [markerPos _start_marker, markerPos _next_marker] call F_isWaterBetween) then {
				_sector_list_tmp = _sector_list_tmp - [_next_marker];
			} else {
				_destinations_markers pushback _next_marker;
				_start_marker = _next_marker;
				_sector_list_tmp = _sector_list_tmp - [_start_marker];
			};
		} else {
			_sector_list_tmp = [];
		};
	};
    _max_try = _max_try - 1;
	sleep 0.1;
};

_destinations_markers;
