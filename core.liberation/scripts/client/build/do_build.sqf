private ["_unit", "_pos", "_grp", "_classname", "_fob_box",
		"_idx", "_unitrank", "_ghost_spot", "_vehicle", "_allow_damage",
		"_dist", "_radius", "_actualdir", "_near_objects"
];

build_confirmed = 0;
buildindex = 0;
build_unit = [];
build_vehicle = objNull;
build_mode = 0;
build_water = 0;

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

if (isNil "manned") then { manned = false };
if (isNil "gridmode" ) then { gridmode = 0 };
if (isNil "repeatbuild" ) then { repeatbuild = false };
if (isNil "build_rotation" ) then { build_rotation = 0 };
if (isNil "build_altitude" ) then { build_altitude = 0 };
if (isNil "building_altitude" ) then { building_altitude = 0 };
waitUntil { sleep 0.2; !isNil "dobuild" };

while { true } do {
	waitUntil { sleep 0.2; dobuild != 0 };

	build_confirmed = 1;
	build_invalid = 0;
	_classname = "";
	_fob_box = objNull;
	_buildtype = buildtype;
	_buildindex = buildindex;

	// Init build properties
	if ( _buildtype == 6 ) then { build_altitude = building_altitude } else { build_altitude = 0.2 };

	if ( _buildtype == 99 ) then {
		_classname = FOB_typename;
		_price = 0;
		_price_fuel = 0;
		_fob_box = build_vehicle;
	};

	if ( _buildtype == 98 ) then {
		_classname = FOB_outpost;
		_price = 0;
		_price_fuel = 0;
		_fob_box = build_vehicle;
	};

	if ( _buildtype == 97 ) then {
		_classname = FOB_carrier;
		_price = 0;
		_price_fuel = 0;
		_fob_box = build_vehicle;
	};

	if ( _buildtype in [9,10] ) then {
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

	if ( _buildtype in [1,2,3,4,5,6,7,8] ) then {
		_score = [player] call F_getScore;
		_build_list = [];
		{
			if ( _score >= (_x select 4) ) then {_build_list pushback _x};
		} forEach (build_lists select _buildtype);

		_classname = (_build_list select _buildindex) select 0;
		_price = (_build_list select _buildindex) select 2;
		_price_fuel = (_build_list select _buildindex) select 3;
		_color = [];
		_compo = [];
		_ammo = 0;
		_lst_a3 = [];
		_lst_r3f = [];
		_lst_grl = [];
	};

	// Build
	_pos = getPosATL player;
	if (surfaceIsWater _pos) then { _pos = getPosASL player };

	//diag_log format ["--- LRX: Build Called: %1 bt:%2 bi:%3 pos:%4", _classname, _buildtype, _buildindex, _pos];

	if ( _buildtype == 1 ) then {
		if (_classname isKindOf "Dog_Base_F" || _classname in MFR_Dogs_classname) then {
			[0,0,0, "add", _classname] call do_dog;
		} else {
			if (!([_price] call F_pay)) exitWith {};
			[_classname] call do_build_unit;
		};
	};

	if ( _buildtype == 8 ) then {
		if (!([_price] call F_pay)) exitWith {};
		[_classname] call do_build_squad;
	};

	if ( _buildtype in [2,3,4,5,6,7,9,10,99,98,97] ) then {
		if !(_buildtype in [99,98,97]) then {
			_pos = [] call F_getNearestFob;
			if (player distance2D _pos < GRLIB_fob_range && surfaceIsWater _pos && (getPosASL player select 2) > 2) then {
				build_altitude = (getPosASL player select 2) + 0.5;
				build_mode = 1;
				build_water = 1;
			};
		};

		// Add Actions
		_idactview = -1;
		_idactsnap = -1;
		_idactupper = -1;
		_idactlower = -1;
		_idactrotate = -1;
		_idactmode = -1;
		_idactplacebis = -1;

		if (build_water == 0) then {
			if ( _buildtype == 6 && !(_classname in GRLIB_build_force_mode) ) then {
				_idactplacebis = player addAction ["<t color='#B0FF00'>" + localize "STR_PLACEMENT_BIS" + "</t> <img size='1' image='res\ui_confirm.paa'/>","scripts\client\build\build_place_bis.sqf","",-752,false,false,"","build_invalid == 0 && build_confirmed == 1"];
				_idactmode = player addAction ["<t color='#B0FF00'>" + localize "STR_MODE" + "</t> <img size='1' image='R3F_LOG\icons\r3f_drop.paa'/>","scripts\client\build\build_mode.sqf","",-755,false,false,"","build_confirmed == 1"];
			};

			if ( _buildtype in [6,99,98] ) then {
				_idactview = player addAction ["<t color='#B0FF00'>" + "-- Build view" + "</t>","scripts\client\build\build_view.sqf","",-755,false,false,"","build_confirmed == 1"];
				_idactsnap = player addAction ["<t color='#B0FF00'>" + localize "STR_GRID" + "</t>","scripts\client\build\do_grid.sqf","",-755,false,false,"","build_confirmed == 1"];
			};
		};

		if ( _buildtype in [2,3,4,5,6,7,9,10,99,98] ) then {
			_idactupper = player addAction ["<t color='#B0FF00'>" + localize "STR_MOVEUP" + "</t> <img size='1' image='R3F_LOG\icons\r3f_lift.paa'/>","scripts\client\build\build_up.sqf","",-755,false,false,"","build_confirmed == 1"];
			_idactlower = player addAction ["<t color='#B0FF00'>" + localize "STR_MOVEDOWN" + "</t> <img size='1' image='R3F_LOG\icons\r3f_release.paa'/>","scripts\client\build\build_down.sqf","",-755,false,false,"","build_confirmed == 1"];
			_idactrotate = player addAction ["<t color='#B0FF00'>" + localize "STR_ROTATION" + "</t> <img size='1' image='res\ui_rotation.paa'/>","scripts\client\build\build_rotate.sqf","",-756,false,false,"","build_confirmed == 1"];
		};

		_idactplace = player addAction ["<t color='#B0FF00'>" + localize "STR_PLACEMENT" + "</t> <img size='1' image='res\ui_confirm.paa'/>","scripts\client\build\build_place.sqf","",-750,false,true,"","build_invalid == 0 && build_confirmed == 1"];
		_idactcancel = player addAction ["<t color='#B0FF00'>" + localize "STR_CANCEL" + "</t> <img size='1' image='res\ui_cancel.paa'/>","scripts\client\build\build_cancel.sqf","",-760,false,true,"","build_confirmed == 1"];
		_ghost_spot = (markerPos "ghost_spot") findEmptyPosition [1,150,"B_Heli_Transport_03_unarmed_F"];
		_ghost_spot = _ghost_spot vectorAdd [0, 0, build_altitude];

		if (_classname == FOB_carrier) then {
			_vehicle = "VR_3DSelector_01_default_F" createVehicleLocal _ghost_spot;
		} else {
			_vehicle = _classname createVehicleLocal _ghost_spot;
		};
		_vehicle allowdamage false;
		_vehicle setVehicleLock "LOCKED";
		_vehicle enableSimulationGlobal false;
		_vehicle setVariable ["R3F_LOG_disabled", true];
		[_vehicle] call F_clearCargo;

		_radius = (sizeOf _classname)/2;
		if (_radius < 3.5) then { _radius = 3.5 };
		if (_radius > 20) then { _radius = 20 };
		_dist = (_radius / 2) + 1.5;
		if (_dist > 5) then { _dist = 5 };
		if (_classname == FOB_carrier) then { _dist = 35; build_rotation = 90 };
		if (_classname isKindOf "Slingload_base_F") then { _radius = 5 };
		_dist = 3 max _dist;

		for "_i" from 0 to 5 do { _vehicle setObjectTextureGlobal [_i, '#(rgb,8,8,3)color(0,1,0,0.8)'] };
		{ _x setObjectTexture [0, "#(rgb,8,8,3)color(0,1,0,1)"]; } foreach GRLIB_preview_spheres;

		// Wait for building
		while { build_confirmed == 1 && alive player } do {
			_truedir = 90 - (getdir player);
			_truepos = [((getpos player) select 0) + ((_dist + _radius) * (cos _truedir)), ((getpos player) select 1) + ((_dist + _radius) * (sin _truedir)), build_altitude];
			_actualdir = ((getdir player) + build_rotation);
			if (_classname == "Land_Cargo_Patrol_V1_F") then { _actualdir = _actualdir + 180 };
			if (_classname == FOB_typename) then { _actualdir = _actualdir + 270 };
			if (_classname == FOB_box_typename) then { _actualdir = _actualdir + 90 };
			if (_classname in GRLIB_build_force_mode) then { build_mode = 1 };

			while { _actualdir > 360 } do { _actualdir = _actualdir - 360 };
			while { _actualdir < 0 } do { _actualdir = _actualdir + 360 };
			if ( (_buildtype in [6,99,98]) && ((gridmode % 2) == 1) ) then {
				if ( _actualdir >= 22.5 && _actualdir <= 67.5 ) then { _actualdir = 45 };
				if ( _actualdir >= 67.5 && _actualdir <= 112.5 ) then { _actualdir = 90 };
				if ( _actualdir >= 112.5 && _actualdir <= 157.5 ) then { _actualdir = 135 };
				if ( _actualdir >= 157.5 && _actualdir <= 202.5 ) then { _actualdir = 180 };
				if ( _actualdir >= 202.5 && _actualdir <= 247.5 ) then { _actualdir = 225 };
				if ( _actualdir >= 247.5 && _actualdir <= 292.5 ) then { _actualdir = 270 };
				if ( _actualdir >= 292.5 && _actualdir <= 337.5 ) then { _actualdir = 315 };
				if ( _actualdir <= 22.5 || _actualdir >= 337.5 ) then { _actualdir = 0 };
			};
			if ([] call is_admin) then { hintSilent format ["%1 - %2", _truepos, round _truedir] };

			_sphere_idx = 0;
			{
				if ( surfaceIsWater _truepos ) then {
					_x setposASL (_truepos getPos [_radius, _sphere_idx * 10]);
				} else {
					_x setposATL (_truepos getPos [_radius, _sphere_idx * 10]);
				};
				_sphere_idx = _sphere_idx + 1;
			} foreach GRLIB_preview_spheres;

			_near_objects = (_truepos nearobjects ["AllVehicles", _radius]);
			_near_objects = _near_objects + (_truepos nearObjects [FOB_typename, 12]);
			_near_objects = _near_objects + (_truepos nearObjects [FOB_outpost, 10]);
			_near_objects = _near_objects + (_truepos nearObjects [Warehouse_typename, 12]);
			_near_objects = _near_objects + (_truepos nearObjects [medic_heal_typename, 8]);

			if(	_buildtype != 6 ) then {
				_near_objects = _near_objects + (_truepos nearobjects ["Static", 5]);
			};

			private _remove_objects = [];
			{
				if ((_x isKindOf "Animal") || ([_x, GRLIB_ignore_colisions] call F_itemIsInClass) || (_x == player) || (_x == _vehicle )) then {
					_remove_objects pushback _x;
				};
			} foreach _near_objects;

			_near_objects = _near_objects - _remove_objects;

			if (_classname == land_cutter_typename) then {
				_near_objects = _near_objects + ((_truepos nearobjects [land_cutter_typename, 20]) select { (_x != _vehicle) });
			};

			if ( count _near_objects == 0 ) then {
				{
					_dist22 = 0.5 * (sizeOf (typeof _x));
					if ( _dist22 < 1 ) then { _dist22 = 1 };
					if (_truepos distance2D _x < _dist22) then {
						_near_objects pushback _x;
					};
				} foreach _near_objects;
			};

			if ( count _near_objects != 0 ) then {
				GRLIB_conflicting_objects = _near_objects;
			} else {
				GRLIB_conflicting_objects = [];
			};

			if ( count _near_objects == 0 && ((_truepos distance2D _pos) < _maxdist || _buildtype == 9) && (((!surfaceIsWater _truepos) && (!surfaceIsWater getpos player)) || _classname in boats_names || build_water == 1) ) then {
				if ( (_classname in boats_names || build_water == 1) && surfaceIsWater _truepos ) then {
					_vehicle setposASL _truepos;
				} else {
					_vehicle setposATL _truepos;
				};

				if (build_mode == 0) then {
					_vehicle setVectorDirAndUp [[-cos _actualdir, sin _actualdir, 0] vectorCrossProduct surfaceNormal _truepos, surfaceNormal _truepos];
				} else {
					_vehicle setVectorDirAndUp [[sin _actualdir, cos _actualdir, 0], [0, 0, 1]];
				};

				if ( build_invalid == 1 ) then {
					GRLIB_ui_notif = "";
					{ _x setObjectTexture [0, "#(rgb,8,8,3)color(0,1,0,1)"]; } foreach GRLIB_preview_spheres;
				};
				build_invalid = 0;
			} else {
				if ( build_invalid == 0 ) then {
					{ _x setObjectTexture [0, "#(rgb,8,8,3)color(1,0,0,1)"]; } foreach GRLIB_preview_spheres;
				};
				_vehicle setposATL _ghost_spot;
				build_invalid = 1;
				if(count _near_objects > 0) then {
					GRLIB_ui_notif = format [localize "STR_PLACEMENT_IMPOSSIBLE",count _near_objects, round _radius];

					if (_debug_colisions) then {
						private [ "_objs_classnames" ];
						_objs_classnames = [];
						{ _objs_classnames pushback (typeof _x) } foreach _near_objects;
						hint format [ "Colisions : %1", _objs_classnames ];
					};
				} else {
					if( ((surfaceIsWater _truepos) || (surfaceIsWater getpos player)) && !(_classname in boats_names)) then {
						GRLIB_ui_notif = localize "STR_BUILD_ERROR_WATER";
					};
					if( (_truepos distance2D _pos) > _maxdist && _buildtype != 9) then {
						GRLIB_ui_notif = format [localize "STR_BUILD_ERROR_DISTANCE",_maxdist];
					};
				};
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
			private _veh_pos = getPosWorld _vehicle;
			deleteVehicle _vehicle;
			sleep 0.1;

			// FOB
			if(_buildtype in [99,98,97]) exitWith {
				[player, "Land_Carrier_01_blast_deflector_up_sound"] remoteExec ["sound_range_remote_call", 2];
				private _unit_list_redep = (units player) select { !(isPlayer _x) && (_x distance2D player < 40) && lifestate _x != 'INCAPACITATED' };
				if (_classname == FOB_carrier) then {
					titleText ["Naval FOB Incoming..." ,"BLACK FADED", 30];
					{ _x allowDamage false } forEach _unit_list_redep;
					disableUserInput true;
				};

				[_classname, _veh_pos, _veh_dir, _veh_vup, player] remoteExec ["build_fob_remote_call", 2];
				sleep 2;

				if (_classname == FOB_carrier) then {
					[([] call F_getNearestFob)] call do_onboard;
					titleText ["" ,"BLACK IN", 3];
					{ _x allowDamage true } forEach _unit_list_redep;
					disableUserInput false;
					disableUserInput true;
					disableUserInput false;
				};
				[player, "Land_Carrier_01_blast_deflector_up_sound"] remoteExec ["sound_range_remote_call", 2];
			};

			_vehicle = _classname createVehicle _truepos;
			if (isNull _vehicle) exitWith {};
			_vehicle allowDamage false;
			_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
			_vehicle setPosWorld _veh_pos;

			if ( _classname in boats_names && surfaceIsWater _truepos ) then {
				_vehicle setposASL _truepos;
			};

			_allow_damage = true;
			sleep 0.1;

			// ACE Support
			[_vehicle] call F_aceInitVehicle;

			// Ammo Box clean inventory
			if ( !(_classname in GRLIB_Ammobox_keep + GRLIB_disabled_arsenal) ) then {
				[_vehicle] call F_clearCargo;
			};

			// Vehicle owner
			if ( _buildtype in [2,3,4,5,7,9,10] ) then {
				if (!([_vehicle, GRLIB_vehicle_blacklist] call F_itemIsInClass)) then {
					_vehicle setVariable ["GRLIB_vehicle_owner", PAR_Grp_ID, true];
					_vehicle allowCrewInImmobile [true, false];
					_vehicle setUnloadInCombat [true, false];
				};
			};

			// Crewed vehicle
			if ( ([_classname, uavs] call F_itemIsInClass) || manned ) then {
				[_vehicle] call F_forceCrew;
				_vehicle setVariable ["GRLIB_vehicle_manned", true, true];
				player hcSetGroup [group _vehicle];
				player linkItem "B_UavTerminal";
			};

			if (_classname isKindOf "LandVehicle" || _classname isKindOf "Air") then {
				// Give real truck horn to APC,Truck,Tank
				if ( _vehicle isKindOf "Wheeled_APC_F" || _vehicle isKindOf "Tank_F" || _vehicle isKindOf "Truck_F" ) then {
					_vehicle removeWeaponTurret ["TruckHorn", [-1]];
					_vehicle removeWeaponTurret ["TruckHorn2", [-1]];
					_vehicle addWeaponTurret ["TruckHorn3", [-1]];
				};

				// CUP/RHS remove panel
				[_vehicle] call F_fixModVehicle;
		
				// Color
				if ( count _color > 0 ) then {
					[_vehicle, _color] call RPT_fnc_TextureVehicle;
				};

				// Composant
				if ( count _compo > 0 ) then {
					[_vehicle, _compo] call RPT_fnc_CompoVehicle;
				};

				// Remaining Ammo
				if ( _ammo > 0 ) then {
					_vehicle setVehicleAmmo _ammo;
				};

				// Default Paint
				if ( _classname in ["I_E_Truck_02_MRL_F"] ) then {
					[_vehicle, ["EAF",1], true ] spawn BIS_fnc_initVehicle;
				};

				_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
			};

			// Automatic ReAmmo
			if ( _classname in vehicle_rearm_sources ) then {
				_vehicle setAmmoCargo 0;
			};

			// Mobile respawn
			if ( _classname == mobile_respawn ) then {
				[_vehicle, "add"] remoteExec ["addel_beacon_remote_call", 2];
			};

			// Personal Box
			if ( _classname == playerbox_typename ) then {
				[_vehicle, playerbox_cargospace] remoteExec ["setMaxLoad", 2];
				_allow_damage = false;
			};

			// A3 / R3F Inventory
			if ( count _lst_a3 > 0 ) then {
				[_vehicle, _lst_a3] call F_setCargo;
			};

			if ( count _lst_r3f > 0 ) then {
				[_vehicle, _lst_r3f] call load_object_direct;
			};

			if ( count _lst_grl > 0 ) then {
				{[_vehicle, _x] call attach_object_direct} forEach _lst_grl;
			};

			// Arsenalbox
			if ( _classname == Arsenal_typename ) then {
				[_vehicle, 0] remoteExec ["setMaxLoad", 2];
			};

			// Ammobox (add Charge)
			if ( _classname == Box_Ammo_typename ) then {
				_vehicle addItemCargoGlobal ["SatchelCharge_Remote_Mag", 2];
			};

			// Helipad lights
			if ( _classname isKindOf "Land_PortableHelipadLight_01_F" ) then {
				[_vehicle, false] remoteExec ["enableSimulationGlobal", 2];
				_allow_damage = false;
			};

			// Static Weapon
			if (_classname in list_static_weapons) then {
				_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_static }];
				// AI Static Weapon
				if (_classname in static_vehicles_AI) then {
					[_vehicle] call F_forceCrew;
					_vehicle setVariable ["GRLIB_vehicle_manned", true, true];
					_vehicle setVehicleLock "LOCKEDPLAYER";
					_vehicle addEventHandler ["Fired", { (_this select 0) setVehicleAmmo 1 }];
				};
			};

			// Magic ClutterCutter
			if (_classname == land_cutter_typename) then {
				[_truepos] remoteExec ["build_cutter_remote_call", 2];
			};

			// WareHouse
			if (_classname == Warehouse_typename) then {
				[_vehicle] remoteExec ["warehouse_init_remote_call", 2];
				_allow_damage = false;
			};

			sleep 0.3;
			if (_allow_damage) then { _vehicle allowDamage true };
			_vehicle setDamage 0;
			build_vehicle = _vehicle;

			if ( !(_classname in (all_buildings_classnames + fob_buildings_classnames))) then { 
				_vehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
			};

			stats_blufor_vehicles_built = stats_blufor_vehicles_built + 1;
			publicVariable "stats_blufor_vehicles_built";
		};

		// Remove Actions
		if ( _idactsnap != -1 ) then { player removeAction _idactsnap };
		if ( _idactview != -1 ) then { player removeAction _idactview };
		if ( _idactplacebis != -1 ) then { player removeAction _idactplacebis };
		if ( _idactmode != -1 ) then { player removeAction _idactmode };
		if ( _idactupper != -1 ) then {
			player removeAction _idactupper;
			player removeAction _idactlower;
			player removeAction _idactrotate;
		};
		player removeAction _idactcancel;
		player removeAction _idactplace;
	};

	build_confirmed = 0;
	sleep 1;

	if ( repeatbuild ) then {
		dobuild = 1;
		repeatbuild = false;
		building_altitude = build_altitude;
	} else {
		dobuild = 0;
		build_rotation = 0;
		building_altitude = 0;
		build_mode = 0;
		build_water = 0;
	};
	manned = false;
};
