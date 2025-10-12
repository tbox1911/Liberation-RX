waitUntil {sleep 1; !isNil "GRLIB_mobile_respawn"};

private _no_marker_classnames = [
	playerbox_typename,
	PAR_grave_box_typename,
	GRLIB_sar_wreck,
	GRLIB_sar_fire,
	Warehouse_desk_typename,
	"ParachuteBase",
	"NVTarget",
	"LaserTarget",
	"Land_Campfire_F",
	"Kart_01_Base_F",
	"Land_CashDesk_F",
	"Land_HumanSkull_F",
	"Land_HumanSkeleton_F",
	"WeaponHolderSimulated"
] + GRLIB_force_cleanup_classnames + GRLIB_ide_traps + GRLIB_intel_items + all_buildings_classnames + fob_defenses_classnames;

if (GRLIB_allow_redeploy > 0) then {
	_no_marker_classnames = _no_marker_classnames + respawn_vehicles;
};
_no_marker_classnames = _no_marker_classnames arrayIntersect _no_marker_classnames;
_no_marker_classnames = _no_marker_classnames - ai_resupply_sources;

private ["_veh_list","_veh_list_all","_veh_list_blu","_veh_list_civ"];
private ["_nextvehicle","_nextmarker","_nextvehicle_owner","_nextvehicle_disabled"];
private ["_marker","_marker_color","_marker_type","_marker_show"];
private _vehmarkers = [];

while {true} do {
	waitUntil {sleep 0.1; visibleMap };

	_veh_list = [];
	_veh_list_all = vehicles select {
		(getObjectType _x >= 8) &&
		(_x distance2D lhd > GRLIB_fob_range) &&
		(alive _x) && !(isObjectHidden _x) && isNull (attachedTo _x) &&
		!([_x, _no_marker_classnames] call F_itemIsInClass) &&
		!(_x getVariable ['R3F_LOG_disabled', false]) &&
		(isNil {_x getVariable "GRLIB_vehicle_init"}) &&
		(isNil {_x getVariable "GRLIB_mission_AI"}) &&
		(isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull]))
	};

	_veh_list_blu = _veh_list_all select { (side _x == GRLIB_side_friendly) };
	_veh_list_civ = _veh_list_all select { (side _x == GRLIB_side_civilian && count (crew _x) == 0) };
	_veh_list = _veh_list_blu + _veh_list_civ;

	if (GRLIB_allow_redeploy > 0) then {
		private _mobile_respawn_list = GRLIB_mobile_respawn select {
			(alive _x) && !(isObjectHidden _x) &&
			!(_x getVariable ['R3F_LOG_disabled', false]) &&
			!([_x, "LHD", GRLIB_fob_range] call F_check_near) &&
			!surfaceIsWater (getPos _x) && ((getPosATL _x) select 2) < 5 && speed vehicle _x < 5
		};
		_veh_list = _veh_list + _mobile_respawn_list;
	};
	private _mobile_respawn = ([] call F_getMobileRespawns);
	private _vehmarkers_bak = [];
	{
		_nextvehicle = _x;
		_nextmarker = format ["markedveh_%1", (_nextvehicle call BIS_fnc_netId)];
		// in cache ?
		if (_vehmarkers find _nextmarker < 0) then {
			if (!isNull _nextvehicle) then {
				_marker = createMarkerLocal [format ["markedveh_%1", (_nextvehicle call BIS_fnc_netId)], markers_reset];
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
		if (_nextvehicle_owner == "server") exitWith { _nextmarker setMarkerAlphaLocal 0 };

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

		if (typeOf _nextvehicle == money_typename) then {
			_marker_color = "ColorGreen";
			_marker_type = "EmptyIcon";
			_nextmarker setMarkerTextLocal "$";
		};

		if (typeOf _nextvehicle == repairbox_typename) then {
			_marker_color = "ColorWEST";
			_marker_type = "loc_repair";
			_nextmarker setMarkerSizeLocal [1.4, 1.4];
		};

		if (typeOf _nextvehicle == canister_fuel_typename) then {
			_marker_color = "Color1_FD_F";
			_marker_type = "loc_refuel";
			_nextmarker setMarkerSizeLocal [1.4, 1.4];
		};

		if (_nextvehicle isKindOf repair_offroad) then {
			_marker_color = "ColorOrange";
			_nextmarker setMarkerTextLocal "Repair";
			_marker_show = 1;
		};

		if (_nextvehicle isKindOf "AllVehicles") then {
			if (_nextvehicle_owner in ["server","public",""]) then {
				_marker_color = "ColorKhaki";
			} else {
				_marker_show = 0;
				if ((GRLIB_show_blufor == 1 && [player, _nextvehicle] call is_owner) || GRLIB_show_blufor == 2) then {
					private _datcrew = crew _nextvehicle;
					private _vehiclename = ([(typeOf _nextvehicle)] call F_getLRXName);
					if (count _datcrew > 0) then {
						_marker_type ="mil_arrow2";
						_nextmarker setMarkerDirLocal (getDir _nextvehicle);
						_vehiclename = "";
						{
							if (isPlayer _x) then {
								_vehiclename = _vehiclename + (name _x);
							} else {
								_vehiclename = _vehiclename + (format [ "%1", [_x] call F_getUnitPositionId]);
							};

							if( (_datcrew find _x) != ((count _datcrew) - 1) ) then {
								_vehiclename = _vehiclename + ",";
							};
							_vehiclename = _vehiclename + " ";
						} foreach  _datcrew;
						_vehiclename = _vehiclename + (format ["(%1)", [_nextvehicle] call F_getLRXName]);
					};
					_nextmarker setMarkerTextLocal _vehiclename;
					_marker_color = GRLIB_color_friendly;
					if (_vehiclename in _veh_list_civ) then { _marker_color = GRLIB_color_civilian };
					_marker_show = 1;
				};
			};
		};

		if (_nextvehicle in _mobile_respawn) then {
			_marker_color = "ColorYellow";
			_marker_type = "mil_end";
			_nextmarker setMarkerTextLocal format ["%1 - %2", [_nextvehicle] call F_getLRXName, mapGridPosition _nextvehicle];
		};

		_nextmarker setMarkerColorLocal _marker_color;
		_nextmarker setMarkerTypeLocal _marker_type;
		_nextmarker setMarkerAlphaLocal _marker_show;
	} foreach _veh_list;

	{ deleteMarkerLocal _x } foreach (_vehmarkers - _vehmarkers_bak);
	_vehmarkers = _vehmarkers_bak;

	sleep 2;
};
