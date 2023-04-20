private [ "_marker", "_nextvehicle", "_nextmarker" ];
private _veh_list = [];
private _vehmarkers = [];
private _vehmarkers_bak = [];

private _no_marker_classnames = [
	"Kart_01_Base_F",
	Respawn_truck_typename,
	huron_typename,
	playerbox_typename,
	GRLIB_player_gravebox
] + GRLIB_ide_traps + GRLIB_intel_items;
{ _no_marker_classnames pushback (_x select 0) } foreach buildings;

waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1; !isNil "GRLIB_mobile_respawn"};

while { true } do {
	_veh_list = [vehicles, {
		alive _x &&
		(_x distance2D lhd > GRLIB_fob_range) &&
		!(_x isKindOf "CAManBase") &&
		!(_x isKindOf "WeaponHolderSimulated") &&
		!([typeOf _x, _no_marker_classnames] call F_itemIsInClass) &&
		(isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull])) &&
		(
			(side _x == GRLIB_side_friendly) ||
			(side _x == GRLIB_side_civilian && count (crew _x) == 0)
		)
	}] call BIS_fnc_conditionalSelect;

	_vehmarkers_bak = [];
	{
		_nextvehicle = _x;
		_nextmarker = format ["markedveh%1" ,_nextvehicle];
		if (_vehmarkers find _nextmarker < 0) then {
			_marker = createMarkerLocal [format ["markedveh%1", _nextvehicle], markers_reset];
			_marker setMarkerColorLocal "ColorKhaki";
			_marker setMarkerTypeLocal "mil_dot";
			_marker setMarkerSizeLocal [ 0.75, 0.75 ];
			_marker setMarkerPosLocal (getPosATL _nextvehicle);
			_marker setMarkerTextLocal ([(typeOf _nextvehicle)] call F_getLRXName);
			_vehmarkers_bak pushback _marker;

			if (typeOf _nextvehicle in [Arsenal_typename] + support_box_noArsenal) then {
				_marker setMarkerColorLocal "ColorOrange";
				_marker setMarkerTypeLocal "loc_Rifle";
			};
			if (typeOf _nextvehicle in [ammobox_b_typename,ammobox_o_typename,ammobox_i_typename]) then {
				_marker setMarkerColorLocal "ColorGUER";
				_marker setMarkerTypeLocal "mil_box";
			};
			if (typeOf _nextvehicle in [waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename]) then {
				_marker setMarkerColorLocal "ColorGrey";
				_marker setMarkerTypeLocal "mil_triangle";
			};
		} else {
			_nextmarker setMarkerPosLocal (getPosATL _nextvehicle);
			_vehmarkers_bak pushback _nextmarker;
		};

		if (_nextvehicle isKindOf "AllVehicles") then {
			if ((_nextvehicle getVariable ["GRLIB_vehicle_owner", ""]) in ["server","public",""]) then {
				_nextmarker setMarkerColorLocal "ColorKhaki";
			} else {
				_nextmarker setMarkerColorLocal GRLIB_color_friendly;
			};
		};

		if (_nextvehicle getVariable ['R3F_LOG_disabled', false] || (_nextvehicle getVariable ["GRLIB_vehicle_owner", ""] == "server")) then {
			_nextmarker setMarkerAlphaLocal 0;
		} else {
			_nextmarker setMarkerAlphaLocal 1;
		};

		if (_nextvehicle isKindOf repair_offroad) then {
			_nextmarker setMarkerColorLocal "ColorOrange";
			_nextmarker setMarkerTextLocal "Repair";
			_nextmarker setMarkerAlphaLocal 1;
		};
	} foreach _veh_list;
	
	{ deleteMarkerLocal _x} foreach (_vehmarkers - _vehmarkers_bak);
	_vehmarkers = _vehmarkers_bak;

	sleep 5;
};
