private [ "_vehmarkers", "_markedveh", "_cfg", "_vehtomark", "_supporttomark", "_marker", "_loaded" ];

_vehmarkers = [];
_beacmarkers = [];
_markedveh = [];
_markedbeac = [];

_cfg = configFile >> "cfgVehicles";
_vehtomark = [];

_support_to_skip = [
];

{
	_vehtomark pushback (_x select 0);
} foreach light_vehicles + heavy_vehicles + air_vehicles + support_vehicles;

_vehtomark = _vehtomark - _support_to_skip;
waitUntil { !isNil "GRLIB_mobile_respawn" };

while { true } do {

	_markedveh = [];
	{
		_loaded = _x getVariable ["R3F_LOG_est_transporte_par", objNull];
		_disabled = _x getVariable ['R3F_LOG_disabled', true];
		if ((alive _x) && ((typeof _x) in _vehtomark) && (count (crew _x) == 0) && (_x distance lhd > 500) && (isNull _loaded) && !(_disabled) && (locked _x != 2) ) then {
				_markedveh pushback _x;
		};
	} foreach vehicles;

	if ( count _markedveh != count _vehmarkers ) then {
		{ deleteMarkerLocal _x; } foreach _vehmarkers;
		_vehmarkers = [];

		{
			_marker = createMarkerLocal [ format [ "markedveh%1" ,_x], markers_reset ];
			_marker setMarkerColorLocal "ColorKhaki";
			_marker setMarkerTypeLocal "mil_dot";
			_marker setMarkerSizeLocal [ 0.75, 0.75 ];
			_vehmarkers pushback _marker;
		} foreach _markedveh;
	};

	{
		_marker = _vehmarkers select (_markedveh find _x);
		_marker setMarkerPosLocal getpos _x;
		_marker setMarkerTextLocal  (getText (_cfg >> typeOf _x >> "displayName"));

	} foreach _markedveh;

	// Mobile Markers Update
	_markedbeac = [ GRLIB_mobile_respawn, { alive _x && _x distance2D lhd > 1000 && _x distance2D ([_x] call F_getNearestFob) > GRLIB_sector_size && !surfaceIsWater (getpos _x) && isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull])}] call BIS_fnc_conditionalSelect;

	if ( count _markedbeac != count _beacmarkers ) then {
		{ deleteMarkerLocal _x; } foreach _beacmarkers;
		_beacmarkers = [];

		{
			_marker = createMarkerLocal [format ["markedbeac%1" ,_x], markers_reset];
			_marker setMarkerColorLocal "ColorBlue";
			_marker setMarkerTypeLocal "mil_dot";
			_marker setMarkerSizeLocal [ 0.75, 0.75 ];
			_beacmarkers pushback _marker;
		} forEach _markedbeac;
	};

	{
		_marker = _beacmarkers select (_markedbeac find _x);
		_marker setMarkerPosLocal getpos _x;
		_marker setMarkerTextLocal (getText (_cfg >> typeOf _x >> "displayName"));
	} foreach _markedbeac;

	sleep 5;
};
