waitUntil {sleep 1; !isNil "GRLIB_mobile_respawn"};

private _no_marker_classnames = [
	PAR_grave_box_typename,
	GRLIB_sar_wreck,
	GRLIB_sar_fire,
	Warehouse_desk_typename,
	"StaticWeapon",
	"LaserTarget",
	"NVTarget",
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

private ["_veh_list","_nextvehicle","_nextmarker","_nextvehicle_owner","_nextvehicle_disabled"];
private ["_marker","_marker_color","_marker_type","_marker_show"];
private _vehmarkers = [];

while {true} do {
	waitUntil {sleep 0.1; (visibleMap || dialog) };

	// Vehicles
	_veh_list = vehicles select {
		(getObjectType _x >= 8) &&
		(side _x != GRLIB_side_enemy) &&
		(_x distance2D lhd > GRLIB_fob_range) &&
		(alive _x) && !(isObjectHidden _x) && isNull (attachedTo _x) &&
		!([_x, _no_marker_classnames] call F_itemIsInClass) &&
		!(_x getVariable ['R3F_LOG_disabled', false]) &&
		(_x getVariable ["GRLIB_vehicle_owner", ""] != "server") &&
		(isNil {_x getVariable "GRLIB_vehicle_init"}) &&
		(isNil {_x getVariable "GRLIB_mission_AI"}) &&
		(isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull]))
	};

	// Static Weapons
	_veh_list = _veh_list + ((entities [["StaticWeapon"],[]]) select {
		(_x distance2D lhd > GRLIB_fob_range) &&
		(alive _x) && !(isObjectHidden _x) && isNull (attachedTo _x) &&
		(typeOf _x in list_static_weapons) &&
		(
			!(_x getVariable ['R3F_LOG_disabled', false]) ||
			(side _x == GRLIB_side_friendly)
		)
	});

	if (GRLIB_allow_redeploy > 0) then {
		_veh_list = _veh_list + ([] call F_getMobileRespawns);
	};

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

		// marker decoration
		_marker_color = "ColorKhaki";
		_marker_type = "mil_dot";
		_marker_show = 1;
		_nextvehicle_owner = _nextvehicle getVariable ["GRLIB_vehicle_owner", ""];

		// all vehicles
		if (_nextvehicle isKindOf "AllVehicles") then {
			if (typeOf _nextvehicle in (uavs_vehicles + static_vehicles_AI)) exitWith {
				// as 3.20, unit in uav/static show a marker on the map regardless of setGroupIconsVisible
				_marker_color = GRLIB_color_friendly;
				//_marker_type = "EmptyIcon";
			};
			_marker_show = 0;
			private _vehicle_crew = crew _nextvehicle;
			private _blufor_crew = (count (_vehicle_crew select { !(isNil {_x getVariable "PAR_Grp_ID"}) || side _x == GRLIB_side_friendly}) > 0);
			if (_nextvehicle_owner in ["public", ""] && !_blufor_crew) then {
				_marker_color = "ColorKhaki";
				if (count _vehicle_crew == 0) then {
					_marker_show = 1;
				};
			} else {
				_marker_color = GRLIB_color_friendly;
				if (side _nextvehicle == GRLIB_side_civilian && count _vehicle_crew > 0) then { _marker_color = GRLIB_color_civilian };
				_marker_show = 1;
			};

			if ((GRLIB_show_blufor == 1 && [player, _nextvehicle] call is_owner) || GRLIB_show_blufor == 2) then {
				private _vehicle_name = ([(typeOf _nextvehicle)] call F_getLRXName);
				if (_blufor_crew) then {
					_marker_type ="mil_arrow2";
					_nextmarker setMarkerDirLocal (getDir _nextvehicle);
					_vehicle_name = "";
					{
						if (isPlayer _x) then {
							_vehicle_name = _vehicle_name + (name _x);
						} else {
							_vehicle_name = _vehicle_name + (format [ "%1", [_x] call F_getUnitPositionId]);
						};

						if( (_vehicle_crew find _x) != ((count _vehicle_crew) - 1) ) then {
							_vehicle_name = _vehicle_name + ",";
						};
						_vehicle_name = _vehicle_name + " ";
					} foreach  _vehicle_crew;
					_vehicle_name = _vehicle_name + (format ["(%1)", [_nextvehicle] call F_getLRXName]);
					_marker_show = 1;
				};
				_nextmarker setMarkerTextLocal _vehicle_name;
			};
		} else {
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

			if (_nextvehicle isKindOf "PlasticCase_01_base_F") then {
				_marker_color = "ColorKhaki";
				_marker_type = "loc_rearm";
				_nextmarker setMarkerSizeLocal [1.4, 1.4];
				if (typeOf _nextvehicle == playerbox_typename) then {
					_marker_color = "ColorCIV";
				};
			};
		};

		// specific vehicles
		if (typeOf _nextvehicle in ai_resupply_sources) then {
			_marker_color = "ColorOrange";
			_marker_type = "loc_Rifle";
			_marker_show = 1;
			_nextmarker setMarkerSizeLocal [1.4, 1.4];
		};

		if (_nextvehicle in GRLIB_mobile_respawn) then {
			_marker_color = "ColorYellow";
			_marker_type = "mil_end";
			_marker_show = 1;
			_nextmarker setMarkerTextLocal format ["%1 - %2", [_nextvehicle] call F_getLRXName, mapGridPosition _nextvehicle];
		};

		// diag_log format ["DBG-2: %1 (%2-%3-%4) - %5", typeOf _nextvehicle, _marker_color, _marker_type, _marker_show, _nextvehicle_owner];
		_nextmarker setMarkerColorLocal _marker_color;
		_nextmarker setMarkerTypeLocal _marker_type;
		_nextmarker setMarkerAlphaLocal _marker_show;
	} foreach _veh_list;

	{ deleteMarkerLocal _x } foreach (_vehmarkers - _vehmarkers_bak);
	_vehmarkers = _vehmarkers_bak;

	sleep 1;
};
