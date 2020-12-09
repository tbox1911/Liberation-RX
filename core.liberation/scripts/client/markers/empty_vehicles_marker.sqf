private [ "_vehmarkers", "_markedveh", "_vehtomark", "_supporttomark", "_marker", "_loaded" ];

_vehmarkers = [];
_beacmarkers = [];
_markedveh = [];
_markedbeac = [];

private _no_marker_classnames = [];
{ _no_marker_classnames pushback (_x select 0) } foreach (opfor_recyclable);

waitUntil { !isNil "GRLIB_mobile_respawn" };

while { true } do {

	_markedveh = [];
	{
		_loaded = _x getVariable ["R3F_LOG_est_transporte_par", objNull];
		_disabled = _x getVariable ['R3F_LOG_disabled', true];
		if ((alive _x) && (count (crew _x) == 0) && (_x distance lhd > 1000) && (isNull _loaded) && !(_disabled) && (locked _x != 2) && !(typeOf _x in _no_marker_classnames) ) then {
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
		_text = [(typeOf _x)] call get_lrx_name;
		_marker setMarkerTextLocal _text;
		_marker setMarkerColorLocal "ColorKhaki";
		if (typeOf _x in [waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename]) then {
			_marker setMarkerColorLocal "ColorGrey";
		};
	} foreach _markedveh;

	sleep 5;
};
