sectors_allSectors = [];
sectors_capture = [];
sectors_bigtown = [];
sectors_factory = [];
sectors_military = [];
sectors_tower = [];
sectors_opfor = [];
sectors_airspawn = [];

{
	_ismissionsector = false;
	_tempmarker = toArray _x; _tempmarker resize 11;
	if ( toString _tempmarker == "opfor_point" ) then {
		sectors_opfor pushback _x;
		_ismissionsector = false;
	};
	_tempmarker = toArray _x; _tempmarker resize 14;
	if ( toString _tempmarker == "opfor_airspawn" ) then {
		sectors_airspawn pushback _x;
		_ismissionsector = false;
	};
	_tempmarker = toArray _x; _tempmarker resize 7;
	if ( toString _tempmarker == "capture" ) then {
		sectors_capture pushback _x;
		_ismissionsector = true;
	};
	_tempmarker = toArray _x; _tempmarker resize 7;
	if ( toString _tempmarker == "bigtown" ) then {
		sectors_bigtown pushback _x;
		_ismissionsector = true;
	};
	_tempmarker = toArray _x; _tempmarker resize 7;
	if ( toString _tempmarker == "factory" ) then {
		sectors_factory pushback _x;
		_ismissionsector = true;
	};
	_tempmarker = toArray _x; _tempmarker resize 8;
	if ( toString _tempmarker == "military" ) then {
		sectors_military pushback _x;
		_ismissionsector = true;
	};
	_tempmarker = toArray _x; _tempmarker resize 5;
	if ( toString _tempmarker == "tower" ) then {
		sectors_tower pushback _x;
		_x setMarkerTextLocal format ["%1 %2",markerText _x, mapGridPosition (markerPos _x)];
		_ismissionsector = true;
	};

	if ( _ismissionsector ) then {
		sectors_allSectors pushback _x;
	};
} foreach allMapMarkers;

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
			if (_marker in sectors_capture) then {_marker_text = "Town"};
			if (_marker in sectors_military) then {_marker_text = "Military Base"};
			if (_marker in sectors_factory) then {_marker_text = "Fuel Depot"};
			diag_log format ["--- LRX World: %1 - Auto-Name failed for marker: %2", worldname, _marker]
		};
		_marker setMarkerText _marker_text;
  };
} forEach sectors_capture + sectors_bigtown + sectors_factory + sectors_military;
GRLIB_sectors_init = true;
publicVariable "GRLIB_sectors_init";