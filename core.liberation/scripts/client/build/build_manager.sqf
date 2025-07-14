private [
	"_unit", "_pos", "_grp", "_classname", "_fob_box",
	"_idx", "_unitrank", "_ghost_spot", "_ghost_name", "_vehicle",
	"_dist", "_radius", "_actualdir", "_near_objects"
];

build_confirmed = 0;
buildindex = 0;
build_unit = [];
build_vehicle = objNull;
build_mode = 0;
build_water = 0;
buildtype = GRLIB_InfantryBuildType;
buildtypeSel = 0;

private _buildtype = 0;
private _buildindex = 0;
private _maxdist = GRLIB_fob_range;
private _truepos = [];
private _debug_colisions = false;
private _price = 0;
private _price_fuel = 0;
private _color = [];
private _compo = [];
private _ammo = 0;
private _lst_a3 = [];
private _lst_r3f = [];
private _lst_grl = [];

// player build actions
private _idactview = -1;
private _idactsnap = -1;
private _idactupper = -1;
private _idactlower = -1;
private _idactcloser = -1;
private _idactfarther = -1;
private _idactrotate = -1;
private _idactmode = -1;
private _idactcancel = -1;
private _idactplace = -1;
private _idactplacebis = -1;

GRLIB_build_force_mode = [
	FOB_typename,
	FOB_outpost,
	FOB_carrier,
	Warehouse_typename
];

GRLIB_preview_spheres = [];
while { count GRLIB_preview_spheres < 36 } do {
	GRLIB_preview_spheres pushback ( "Sign_Sphere100cm_F" createVehicleLocal [ 0, 0, 0 ] );
};

{ _x setObjectTexture [0, "#(rgb,8,8,3)color(0,1,0,1)"] } foreach GRLIB_preview_spheres;

manned = false;
gridmode = 0;
repeatbuild = false;
build_rotation = 0;
build_altitude = 0;
build_distance = 0;
building_altitude = 0;

waitUntil { sleep 0.2; !isNil "dobuild" };

while {true} do {
	waitUntil { sleep 0.2; dobuild != 0 };

	build_confirmed = 1;
	build_valid = true;
	_classname = "";
	_fob_box = objNull;
	_buildtype = buildtype;
	_buildindex = buildindex;

	// Init build properties
	if ( _buildtype in [GRLIB_BuildingBuildType,GRLIB_TrenchBuildType] ) then { build_altitude = building_altitude } else { build_altitude = 0.2 };

	// Configure build properties based on _buildtype using switch-case
	switch _buildtype do {
		case 99: {
			_classname = FOB_typename;
			_price = 0;
			_price_fuel = 0;
			_fob_box = build_vehicle;
		};
		case 98: {
			_classname = FOB_outpost;
			_price = 0;
			_price_fuel = 0;
			_fob_box = build_vehicle;
		};
		case 97: {
			_classname = FOB_carrier;
			_price = 0;
			_price_fuel = 0;
			_fob_box = build_vehicle;
		};
		case GRLIB_BuildTypeDirect: {
			_price = 0;
			_price_fuel = 0;
			_classname = build_unit select 0;
			_color = build_unit select 1;
			_ammo = build_unit select 2;
			_compo = build_unit select 3;
			_lst_a3 = build_unit select 4;
			_lst_r3f = build_unit select 5;
			_lst_grl = build_unit select 6;
			build_altitude = 0.4;
		};
		default {
			_score = [player] call F_getScore;
			_build_list = (build_lists select _buildtype) select { _score >= (_x select 4) };
			_build = _build_list select _buildindex;
			_classname = _build select 0;
			_price = _build select 2;
			_price_fuel = _build select 3;
			_color = [];
			_compo = [];
			_ammo = 0;
			_lst_a3 = [];
			_lst_r3f = [];
			_lst_grl = [];
		};
	};

	// Build
	private _near_outpost = ([player, "OUTPOST", GRLIB_fob_range] call F_check_near);
	if (_near_outpost) then { _price = round (_price * 1.25) };
	_pos = getPosATL player;
	if (surfaceIsWater _pos) then { _pos = getPosASL player };

	//diag_log format ["--- LRX: Build Called: %1 bt:%2 bi:%3 pos:%4", _classname, _buildtype, _buildindex, _pos];

	if ( _buildtype == GRLIB_InfantryBuildType ) then {
		if (_classname isKindOf "Dog_Base_F" || _classname in MFR_Dogs_classname) then {
			[0,0,0, "add", _classname] call do_dog;
		} else {
			if (!([_price] call F_pay)) exitWith {};
			[_classname] call do_build_unit;
		};
	};

	if ( _buildtype == GRLIB_SquadBuildType ) then {
		if (!([_price] call F_pay)) exitWith {};
		[_classname] call do_build_squad;
	};

	if ( _buildtype in [GRLIB_TransportVehicleBuildType, GRLIB_CombatVehicleBuildType, GRLIB_AerialBuildType, GRLIB_DefenceBuildType, GRLIB_BuildingBuildType, GRLIB_TrenchBuildType, GRLIB_SupportBuildType, GRLIB_BuildTypeDirect,99,98,97] ) then {
		if !(_buildtype in [99,98,97]) then {
			_pos = [] call F_getNearestFob;
			if (player distance2D _pos < GRLIB_fob_range && surfaceIsWater _pos && (getPosASL player select 2) > 2) then {
				build_altitude = (getPosASL player select 2) + 0.5;
				build_mode = 1;
				build_water = 1;
			};
		};

		if (!repeatbuild) then {
			if (build_water == 0) then {
				if ( _buildtype == GRLIB_BuildingBuildType && !(_classname in GRLIB_build_force_mode) ) then {
					_idactplacebis = player addAction ["<t color='#B0FF00'>" + localize "STR_PLACEMENT_BIS" + "</t> <img size='1' image='res\ui_confirm.paa'/>","scripts\client\build\build_place_bis.sqf","",-752,true,false,"","build_valid && build_confirmed == 1"];
					_idactmode = player addAction ["<t color='#B0FF00'>" + localize "STR_MODE" + "</t> <img size='1' image='R3F_LOG\icons\r3f_drop.paa'/>","scripts\client\build\build_mode.sqf","",-755,false,false,"","build_confirmed == 1"];
				};

				if ( _buildtype in [GRLIB_BuildingBuildType, 99, 98] ) then {
					_idactview = player addAction ["<t color='#B0FF00'>" + "-- Build view" + "</t>","scripts\client\build\build_view.sqf","",-755,false,false,"","build_confirmed == 1"];
					_idactsnap = player addAction ["<t color='#B0FF00'>" + localize "STR_GRID" + "</t>","scripts\client\build\do_grid.sqf","",-755,false,false,"","build_confirmed == 1"];
				};
			};

			if ( _buildtype in [GRLIB_TransportVehicleBuildType, GRLIB_CombatVehicleBuildType, GRLIB_AerialBuildType, GRLIB_DefenceBuildType, GRLIB_BuildingBuildType, GRLIB_TrenchBuildType, GRLIB_SupportBuildType, GRLIB_BuildTypeDirect,99,98] ) then {
				_idactfarther = player addAction ["<t color='#B0FF00'>" + localize "STR_MOVEFAR" + "</t> <img size='1' image='R3F_LOG\icons\r3f_far.paa'/>","scripts\client\build\build_farther.sqf","",-755,false,false,"","build_confirmed == 1"];
				_idactupper = player addAction ["<t color='#B0FF00'>" + localize "STR_MOVEUP" + "</t> <img size='1' image='R3F_LOG\icons\r3f_lift.paa'/>","scripts\client\build\build_up.sqf","",-756,false,false,"","build_confirmed == 1"];
				_idactlower = player addAction ["<t color='#B0FF00'>" + localize "STR_MOVEDOWN" + "</t> <img size='1' image='R3F_LOG\icons\r3f_release.paa'/>","scripts\client\build\build_down.sqf","",-757,false,false,"","build_confirmed == 1"];
				_idactcloser = player addAction ["<t color='#B0FF00'>" + localize "STR_MOVECLOSE" + "</t> <img size='1' image='R3F_LOG\icons\r3f_drop.paa'/>","scripts\client\build\build_closer.sqf","",-758,false,false,"","build_confirmed == 1"];
				_idactrotate = player addAction ["<t color='#B0FF00'>" + localize "STR_ROTATION" + "</t> <img size='1' image='res\ui_rotation.paa'/>","scripts\client\build\build_rotate.sqf","",-759,false,false,"","build_confirmed == 1"];
			};

			_idactplace = player addAction ["<t color='#B0FF00'>" + localize "STR_PLACEMENT" + "</t> <img size='1' image='res\ui_confirm.paa'/>","scripts\client\build\build_place.sqf","",-750,false,false,"","build_valid && build_confirmed == 1"];
			_idactcancel = player addAction ["<t color='#B0FF00'>" + localize "STR_CANCEL" + "</t> <img size='1' image='res\ui_cancel.paa'/>","scripts\client\build\build_cancel.sqf","",-760,false,false,"","build_confirmed == 1"];
		};

		// Create ghost vehicle
		_ghost_spot = (markerPos "ghost_spot") vectorAdd [0, 0, build_altitude];
		_ghost_name = _classname;
		if (_classname == FOB_carrier) then {
			_ghost_name = "VR_3DSelector_01_default_F";
		};
		_vehicle = _ghost_name createVehicleLocal _ghost_spot;
		_vehicle allowdamage false;
		_vehicle enableSimulation false;
		_vehicle setVehicleLock "LOCKED";
		_vehicle setVariable ["R3F_LOG_disabled", true];
		[_vehicle] call F_clearCargo;

		_radius = ((round((sizeOf _classname)/2) max 3.5) min 15);
		_dist = ((round(_radius / 2) + 1.5) min 3);

		// Customize by classname using switch-case
		switch _classname do {
			case FOB_carrier: {
				_dist = 35;
				build_rotation = 90;
			};
			case "Land_BagBunker_Tower_F": {
				build_rotation = 90;
				build_altitude = -0.2;
			};
			case "Land_vn_bunker_big_02": {
				build_rotation = 270;
			};
			case "Land_vn_b_trench_bunker_01_02": {
				build_rotation = 270;
				build_altitude = -0.2;
			};
			case "Land_BagBunker_Small_F": {
				build_rotation = 180;
			};
			case "Land_TrenchFrame_01_F";
			case "Land_Trench_01_grass_F";
			case "Land_Trench_01_forest_F": {
				build_rotation = 180;
				build_altitude = 2;
			};
			case "Land_ShellCrater_02_small_F": {
				build_altitude = 0.5;
			};
			case "Land_ShellCrater_02_large_F";
			case "Land_ShellCrater_02_extralarge_F": {
				build_altitude = 1;
			};
			default {
				if (_classname isKindOf "Slingload_base_F") then {
					_radius = 5;
				};
			};
		};
		if (!repeatbuild) then { build_distance = 3 max _dist };

		// Improved retexture for preview
		{
			_vehicle setObjectMaterial [_forEachIndex, "\a3\data_f\default.rvmat"];
			_vehicle setObjectTexture [_forEachIndex, '#(rgb,8,8,3)color(0,1,0,0.8)'];
		} forEach (getObjectTextures _vehicle);
		{ _x setObjectTexture [0, "#(rgb,8,8,3)color(0,1,0,1)"] } foreach GRLIB_preview_spheres;

		// Wait for building
		while { build_confirmed == 1 && alive player } do {
			_dir = getdir player;
			_pos = getPos player;
			_truedir = 90 - _dir;
			_truepos = [(_pos#0) + ((build_distance + _radius) * (cos _truedir)), (_pos#1) + ((build_distance + _radius) * (sin _truedir)), build_altitude];
			_actualdir = (_dir + build_rotation);
			if (_classname in GRLIB_build_force_mode) then { build_mode = 1 };
			switch _classname do {
				case "Land_Cargo_Patrol_V1_F": {
					_actualdir = _actualdir + 180;
				};
				case FOB_typename: {
					_actualdir = _actualdir + 270;
				};
				case FOB_box_typename: {
					_actualdir = _actualdir + 90;
				};
			};

			_actualdir = _actualdir - (floor(_actualdir / 360)) * 360;
			if ( (_buildtype in [GRLIB_BuildingBuildType,99,98]) && ((gridmode % 2) == 1) ) then {
				switch true do {
					case (_actualdir >= 22.5 && _actualdir <= 67.5): { _actualdir = 45 };
					case (_actualdir >= 67.5 && _actualdir <= 112.5): { _actualdir = 90 };
					case (_actualdir >= 112.5 && _actualdir <= 157.5): { _actualdir = 135 };
					case (_actualdir >= 157.5 && _actualdir <= 202.5): { _actualdir = 180 };
					case (_actualdir >= 202.5 && _actualdir <= 247.5): { _actualdir = 225 };
					case (_actualdir >= 247.5 && _actualdir <= 292.5): { _actualdir = 270 };
					case (_actualdir >= 292.5 && _actualdir <= 337.5): { _actualdir = 315 };
					case (_actualdir <= 22.5 || _actualdir >= 337.5): { _actualdir = 0 };
					default { };
				};
			};
			if ([] call is_admin) then { hintSilent format ["%1 - %2", _truepos, round _truedir] };
			_isWater = ((surfaceIsWater _truepos));
			{
				if (_isWater) then {
					_x setposASL (_truepos getPos [_radius, _foreachIndex * 10]);
				} else {
					_x setposATL (_truepos getPos [_radius, _foreachIndex * 10]);
				};
			} foreach GRLIB_preview_spheres;

			_near_objects = [];
			{
				_near_objects append (_truepos nearObjects _x);
			} forEach [
				["AllVehicles", _radius],
				[FOB_typename, 12],
				[FOB_outpost, 10],
				[Warehouse_typename, 12],
				[medic_heal_typename, 8]
			];

			if !(_buildtype in [GRLIB_BuildingBuildType, GRLIB_TrenchBuildType]) then {
				_near_objects append (_truepos nearobjects ["Static", 5]);
			};

			// Improved filter out objects that dont actually clip
			_near_objects = _near_objects select {
				!(_x isKindOf "Animal") &&
				!([_x, GRLIB_ignore_colisions] call F_itemIsInClass) &&
				!(_x isEqualTo player) &&
				!(_x isEqualTo _vehicle) &&
				{(_truepos distance2D _x < ((0.5 * (sizeOf (typeof _x))) max 1))}
			};

			if (_classname == land_cutter_typename) then {
				_near_objects append ((_truepos nearobjects [land_cutter_typename, 20]) select { (_x != _vehicle) });
			};

			//Remove redundant check, if its empty, it will set to empty array
			GRLIB_conflicting_objects = _near_objects;

			_noObjectsClip = (_near_objects isEqualTo []);
			_withinDistance = ((_truepos distance2D _pos) < _maxdist || _buildtype == GRLIB_BuildTypeDirect);
			_boatValid = ((_classname in boats_names || build_water == 1) && _isWater);
			_surfaceIsValid = (!_isWater || _boatValid);

			if (_noObjectsClip && _withinDistance && _surfaceIsValid) then {
				if (_boatValid) then {
					_vehicle setposASL _truepos;
				} else {
					_vehicle setposATL _truepos;
				};

				if (build_mode == 0) then {
					_vehicle setVectorDirAndUp [[-cos _actualdir, sin _actualdir, 0] vectorCrossProduct surfaceNormal _truepos, surfaceNormal _truepos];
				} else {
					_vehicle setVectorDirAndUp [[sin _actualdir, cos _actualdir, 0], [0, 0, 1]];
				};

				if (!build_valid) then {
					GRLIB_ui_notif = "";
					{ _x setObjectTexture [0, "#(rgb,8,8,3)color(0,1,0,1)"]; } foreach GRLIB_preview_spheres;
				};
				build_valid = true;
			} else {
				if (build_valid) then {
					{ _x setObjectTexture [0, "#(rgb,8,8,3)color(1,0,0,1)"]; } foreach GRLIB_preview_spheres;
				};
				_vehicle setposATL _ghost_spot;
				build_valid = false;

				//Improvement to show all errors at once
				_invalidText = localize "STR_PLACEMENT_IMPOSSIBLE";
				if(!_noObjectsClip) then {
					_invalidText = _invalidText + endl + format [localize "STR_BUILD_ERROR_COLLISION",count _near_objects, round _radius];

					if (_debug_colisions) then {
						private [ "_objs_classnames" ];
						_objs_classnames = _near_objects apply { typeof _x };
						hint format [ "Colisions : %1", _objs_classnames ];
					};
				};
				if(!_surfaceIsValid) then {
					_invalidText = _invalidText + endl + localize "STR_BUILD_ERROR_WATER";
				};
				if(!_withinDistance) then {
					_invalidText = _invalidText + endl + format [localize "STR_BUILD_ERROR_DISTANCE",_maxdist];
				};
				GRLIB_ui_notif = _invalidText;
			};
			sleep 0.05;
		};

		if ( !alive player ) then { build_confirmed = 3 };
		GRLIB_ui_notif = "";

		{ _x setpos [ 0,0,0 ] } foreach GRLIB_preview_spheres;

		// Cancel build
		if ( build_confirmed == 3 ) then {
			deleteVehicle _vehicle;
			dobuild = 0;
			sleep 2;	// time to trap build canceled
		};

		// Build done
		if ( build_confirmed == 2 ) then {
			if (!([_price, _price_fuel] call F_pay)) exitWith {deleteVehicle _vehicle};
			private _veh_dir = vectorDir _vehicle;
			private _veh_vup = vectorUp _vehicle;
			private _veh_pos = getPosATL _vehicle;
			deleteVehicle _vehicle;
			sleep 0.1;

			// FOB
			if(_buildtype in [99,98,97]) exitWith {
				[player, "Land_Carrier_01_blast_deflector_up_sound"] remoteExec ["sound_range_remote_call", 2];
				private _unit_list_redep = (units player - [player]) select { (_x distance2D player < 40) && lifestate _x != 'INCAPACITATED' };
				if (_classname == FOB_carrier) then {
					private _fob_text = ((["NavalFobType"] call lrx_getParamData) select 1) select (["NavalFobType"] call lrx_getParamValue);
					titleText [format ["Naval FOB (%1) Incoming...", _fob_text] ,"BLACK FADED", 30];
					{ _x allowDamage false } forEach _unit_list_redep;
					disableUserInput true;
				};
				[
					player,
					_classname,
					_veh_pos,
					_veh_dir,
					_veh_vup
				] remoteExec ["build_fob_remote_call", 2];
				sleep 3;
				if (_classname == FOB_carrier) then {
					[] spawn do_onboard;
					titleText ["" ,"BLACK IN", 3];
					{ _x allowDamage true } forEach _unit_list_redep;
					disableUserInput false;
					disableUserInput true;
					disableUserInput false;
				};
				[player, "Land_Carrier_01_blast_deflector_up_sound"] remoteExec ["sound_range_remote_call", 2];
			};

			// Building
			if (_buildtype == GRLIB_BuildingBuildType) exitWith {
				private _vehicle = createVehicle [_classname, _veh_pos, [], 0, "CAN_COLLIDE"];
				_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
				_vehicle setPosATL _veh_pos;

				// Magic ClutterCutter
				if (_classname == land_cutter_typename) then {
					[_veh_pos] remoteExec ["build_cutter_remote_call", 2];
					_vehicle allowdamage false;
				};
			};

			// Trench
			if (_buildtype == GRLIB_TrenchBuildType) exitWith {
				private _vehicle = createVehicle [_classname, zeropos, [], 0, "CAN_COLLIDE"];
				_vehicle enableSimulationGlobal false;
				_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
				disableUserInput true;
				player setDir (player getDir _veh_pos);
				private _zStart = -1;
				private _zEnd = round (_veh_pos select 2);
				private _steps = 15;
				private _stepHeight = (_zEnd - _zStart) / _steps;
				for "_i" from 0 to _steps do {
					if (_i % 3 == 0) then {
						playSound3D [getMissionPath "res\dig02.ogg", player, false, getPosASL player, 5, 1, 250];
						//player playMoveNow "AinvPknlMstpSlayWrflDnon_medicOther";
						player playMoveNow "AinvPknlMstpSnonWnonDnon_medicUp0";
					};
					_newZ = _zStart + (_stepHeight * _i);
					_vehicle setPosATL [_veh_pos select 0, _veh_pos select 1, _newZ];
					sleep 1;
				};
				sleep 1;
				disableUserInput false;
				disableUserInput true;
				disableUserInput false;
				if (lifeState player == 'INCAPACITATED') exitWith { deleteVehicle _vehicle };
				_vehicle setPosATL _veh_pos;
				_vehicle enableSimulationGlobal true;
				_vehicle setVariable ["GRLIB_counter_TTL", round(time + 600), true];
				_vehicle setVariable ["R3F_LOG_disabled", true, true];
				GRLIB_current_trenches = GRLIB_current_trenches + 1;
				_vehicle addEventHandler ["Killed", { GRLIB_current_trenches = GRLIB_current_trenches - 1 }];
			};

			private _owner = "";
			if ( _buildtype in [GRLIB_TransportVehicleBuildType, GRLIB_CombatVehicleBuildType, GRLIB_AerialBuildType, GRLIB_DefenceBuildType, GRLIB_SupportBuildType, GRLIB_BuildTypeDirect] ) then {
				_owner = PAR_Grp_ID;
			};

			// Server creation
			player setVariable ["GRLIB_player_vehicle_build", objNull, true];
			[
				player,
				_classname,
				_owner,
				manned,
				_veh_pos,
				_veh_dir,
				_veh_vup
			] remoteExec ["build_vehicle_remote_call", 2];
			waitUntil { sleep 0.5; !(isNull (player getVariable "GRLIB_player_vehicle_build")) };

			_vehicle = player getVariable "GRLIB_player_vehicle_build";
			if (isNil "_vehicle") exitWith {
				private _msg = format ["--- LRX Error: Cannot build vehicle (%1) at position %2", _classname, _veh_pos];
				systemchat _msg;
				diag_log _msg;
			};

			waitUntil { sleep 0.5; (!alive _vehicle || local _vehicle) };
			if (!alive _vehicle) exitWith {};

			// HandleDamage EH
			if (_classname in list_static_weapons) then {
				_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_static }];
			} else {
				_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
			};

			// MP fix pos
			if (_vehicle distance2D _veh_pos > 10) then {
				_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
				_vehicle setPosATL _veh_pos;
			};

			// Crewed vehicle
			if (manned) then {
				player hcSetGroup [group _vehicle];
			};

			// UAVs
			if (_classname in uavs_vehicles) then {
				_vehicle setVariable ["GRLIB_vehicle_manned", true, true];
				[_vehicle] spawn F_forceCrew;
				if ((player getSlotItemName 612) != uavs_terminal_typename) then {
					player linkItem uavs_terminal_typename;
				};
				[player] call F_correctUAVT;
			};

			// AI Static Weapon
			if (_classname in static_vehicles_AI) then { player disableUAVConnectability [_vehicle, true] };

			// Vehicles
			if (_classname isKindOf "LandVehicle" || _classname isKindOf "Air" || _classname isKindOf "Ship_F") then {
				// Color
				if !(_color isEqualTo []) then {
					[_vehicle, _color] call RPT_fnc_TextureVehicle;
				};
				// Composant
				if !(_compo isEqualTo []) then {
					[_vehicle, _compo] call RPT_fnc_CompoVehicle;
				};
				// Remaining Ammo
				if ( _ammo > 0) then {
					_vehicle setVehicleAmmo _ammo;
				};
			};

			// A3 / R3F Inventory
			if (!(_lst_a3 isEqualTo []) || !(_lst_r3f isEqualTo []) || !(_lst_grl isEqualTo [])) then {
				[_vehicle, _lst_a3, _lst_r3f, _lst_grl] remoteExec ["load_cargo_remote_call", 2];
			};

			build_vehicle = _vehicle;
			stats_blufor_vehicles_built = stats_blufor_vehicles_built + 1;
			publicVariable "stats_blufor_vehicles_built";
		};
	};

	if (repeatbuild) then {
		dobuild = 1;
		building_altitude = build_altitude;
	} else {
		dobuild = 0;
		build_rotation = 0;
		building_altitude = 0;
		build_distance = 0;
		build_mode = 0;
		build_water = 0;
		build_confirmed = 0;
		player removeAction _idactsnap;
		player removeAction _idactview;
		player removeAction _idactmode;
		player removeAction _idactupper;
		player removeAction _idactlower;
		player removeAction _idactcloser;
		player removeAction _idactfarther;
		player removeAction _idactrotate;
		player removeAction _idactcancel;
		player removeAction _idactplace;
		player removeAction _idactplacebis;
	};
	manned = false;
};
