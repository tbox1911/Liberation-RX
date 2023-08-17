private ["_marker","_nextvehicle","_nextvehicle_owner","_nextvehicle_disabled","_nextmarker"];
private ["_marker_color","_marker_type","_marker_show"];
private _veh_list = [];
private _vehmarkers = [];
private _vehmarkers_bak = [];

waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1; !isNil "GRLIB_mobile_respawn"};

private _no_marker_classnames = [
	playerbox_typename,
	GRLIB_player_gravebox,
	GRLIB_sar_wreck,
	Warehouse_desk_typename,
	"Kart_01_Base_F",
	"Land_CashDesk_F",
	"Land_HumanSkull_F",
	"Land_HumanSkeleton_F"
] + GRLIB_ide_traps + GRLIB_intel_items + all_buildings_classnames;

if (GRLIB_allow_redeploy == 1) then {
	_no_marker_classnames = _no_marker_classnames + [Respawn_truck_typename, huron_typename];
};

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
		// in cache
		if (_vehmarkers find _nextmarker < 0) then {
			if (!isNull _nextvehicle) then {
				_marker = createMarkerLocal [format ["markedveh%1", _nextvehicle], markers_reset];
				_marker setMarkerSizeLocal [ 0.75, 0.75 ];
				_marker setMarkerPosLocal (getPosATL _nextvehicle);
				_marker setMarkerTextLocal ([(typeOf _nextvehicle)] call F_getLRXName);
				_vehmarkers_bak pushback _marker;
			};
		} else {
			_nextmarker setMarkerPosLocal (getPosATL _nextvehicle);
			_vehmarkers_bak pushback _nextmarker;
		};

		// decoration
		_marker_color = "ColorKhaki";
		_marker_type = "mil_dot";
		_marker_show = 1;

		_nextvehicle_owner = _nextvehicle getVariable ["GRLIB_vehicle_owner", ""];
		_nextvehicle_disabled = _nextvehicle getVariable ['R3F_LOG_disabled', false];

		if (typeOf _nextvehicle in ai_resupply_sources) then {
			_marker_color = "ColorOrange";
			_marker_type = "loc_Rifle";
		};
		if (typeOf _nextvehicle in [ammobox_b_typename,ammobox_o_typename,ammobox_i_typename]) then {
			_marker_color = "ColorGUER";
			_marker_type = "mil_box";
		};
		if (typeOf _nextvehicle in [waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename]) then {
			_marker_color = "ColorGrey";
			_marker_type = "mil_triangle";
		};

		if (_nextvehicle_disabled || _nextvehicle_owner == "server") then {
			_marker_show = 0;
		};

		if (_nextvehicle isKindOf repair_offroad) then {
			_marker_color = "ColorOrange";
			_nextmarker setMarkerTextLocal "Repair";
			_marker_show = 1;
		};

		if (_nextvehicle isKindOf "AllVehicles" && !_nextvehicle_disabled) then {
			if (_nextvehicle_owner in ["server","public",""]) then {
				_marker_color = "ColorKhaki";
			} else {
				_marker_show = 0;
				if (GRLIB_show_blufor > 0) then {
					if ((GRLIB_show_blufor == 1 && [player, _nextvehicle] call is_owner) || GRLIB_show_blufor == 2) then {
						_marker_color = GRLIB_color_friendly;
						_marker_show = 1;
					};
				};
			};
		};

		_nextmarker setMarkerColorLocal _marker_color;
		_nextmarker setMarkerTypeLocal _marker_type;
		_nextmarker setMarkerAlphaLocal _marker_show;
	} foreach _veh_list;
	
	{ deleteMarkerLocal _x} foreach (_vehmarkers - _vehmarkers_bak);
	_vehmarkers = _vehmarkers_bak;

	sleep 5;
};
