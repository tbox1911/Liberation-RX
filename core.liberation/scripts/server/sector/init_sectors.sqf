private _min_sector_dist = round ((GRLIB_capture_size + GRLIB_fob_range) * 1.5);

sectors_allSectors = [];
sectors_capture = [];
sectors_bigtown = [];
sectors_factory = [];
sectors_military = [];
sectors_tower = [];
sectors_opforSpawn = [];
sectors_airSpawn = [];

{
	_ismissionsector = false;

	if (_x select [0,11] == "opfor_point") then {
		sectors_opforSpawn pushback _x;
		_ismissionsector = false;
	};

	if (_x select [0,14] == "opfor_airspawn") then {
		sectors_airSpawn pushback _x;
		_ismissionsector = false;
	};

	if (_x select [0,7] == "capture") then {
		sectors_capture pushback _x;
		_ismissionsector = true;
	};

	if (_x select [0,7] == "bigtown") then {
		sectors_bigtown pushback _x;
		_ismissionsector = true;
	};

	if (_x select [0,7] == "factory") then {
		sectors_factory pushback _x;
		_ismissionsector = true;
	};

	if (_x select [0,8] == "military") then {
		if (isNil "GRLIB_all_fobs") then {
			sectors_military pushback _x;
			_ismissionsector = true;
		} else {
			private _fob_pos = [markerPos _x] call F_getNearestFob;
			if (_fob_pos distance2D markerPos _x < _min_sector_dist) then {
				_ismissionsector = false;
				deleteMarker _x;
			} else {
				sectors_military pushback _x;
				_ismissionsector = true;
			};
		};
	};

	if (_x select [0,5] == "tower") then {
		sectors_tower pushback _x;
		_x setMarkerTextLocal format ["%1 %2",markerText _x, mapGridPosition (markerPos _x)];
		_ismissionsector = true;
	};

	if ( _ismissionsector ) then {
		sectors_allSectors pushback _x;
	};
} foreach allMapMarkers;

// Only on client
if (!hasInterface) exitWith {};

{
	private _marker = _x;
	private _marker_dist = 999;
	private _marker_text = "";
	if (markerText _marker == "") then {
		{
			_loc = nearestLocations [markerPos _marker, [_x], GRLIB_sector_size] select 0;
			if (!isNil "_loc") then {
				_dist = round (markerPos _marker distance _loc);
				if (_dist < _marker_dist ) then {
					_marker_text = text _loc;
					_marker_dist = _dist;
				};
			};
		} forEach ["NameCityCapital", "NameCity", "NameVillage", "NameLocal", "Hill"];

		if (_marker_text == "") then {
			if (_marker in sectors_capture) then {_marker_text = format ["Town #%1", _forEachIndex]};
			if (_marker in sectors_military) then {_marker_text = format ["Military Base #%1", _forEachIndex]};
			if (_marker in sectors_factory) then {_marker_text = format ["Fuel Depot #%1", _forEachIndex]};
			diag_log format ["--- LRX World: %1 - Auto-Name failed for marker: %2", worldname, _marker]
		};
		_marker setMarkerTextLocal _marker_text;
 };
} forEach (sectors_capture + sectors_bigtown + sectors_factory + sectors_military);
