private [ "_vehmarkers", "_markedveh", "_vehtomark", "_supporttomark", "_marker", "_loaded" ];

_vehmarkers = [];
_beacmarkers = [];
_markedveh = [];
_markedbeac = [];
_enemy_faction = "OPF_F";
if (GRLIB_side_friendly == east) then { _enemy_faction = "BLU_F" };

private _no_marker_classnames = [];
{ _no_marker_classnames pushback (_x select 0) } foreach buildings;

private _force_marker_classnames = [
	Arsenal_typename,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	A3W_BoxWps,
	canisterFuel,
	waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename
];

waitUntil { !isNil "GRLIB_mobile_respawn" };

while { true } do {

	private _veh_list = [ vehicles, {
		alive _x &&
		_x distance lhd > 500 &&
		locked _x != 2 &&
		!(typeOf _x in _no_marker_classnames) &&
		!(_x getVariable ['R3F_LOG_disabled', true]) &&
		isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull]) &&
		(
		 side _x == GRLIB_side_friendly ||
		 (side _x == GRLIB_side_civilian && count (crew _x) == 0 && faction _x != _enemy_faction) ||
		 !((_x getVariable ["GRLIB_vehicle_owner", ""]) in ["server",""]) ||
		 typeOf _x in _force_marker_classnames
		)
	} ] call BIS_fnc_conditionalSelect;

	private _markedveh = [];
	{ _markedveh pushback _x } foreach _veh_list;

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
		if (typeOf _x in [ammobox_b_typename,ammobox_o_typename,ammobox_i_typename]) then {
			_marker setMarkerColorLocal "ColorGUER";
		};
		if (!((_x getVariable ["GRLIB_vehicle_owner", ""]) in ["server",""])) then {
			_marker setMarkerColorLocal GRLIB_color_friendly;
		};
		_marker setMarkerSizeLocal [ 0.75, 0.75 ];
	} foreach _markedveh;

	sleep 5;
};
