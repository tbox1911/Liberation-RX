private [ "_unit", "_pos", "_grp", "_classname", "_idx", "_unitrank", "_posfob", "_ghost_spot", "_vehicle", "_allow_damage", "_dist", "_actualdir", "_near_objects", "_near_objects_25"];

build_confirmed = 0;
build_unit = [];
build_mode = 0;

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
	build_vehicle = objNull;
	_classname = "";

	// Init build properties
	if ( buildtype == 6 ) then { build_altitude = building_altitude } else { build_altitude = 0.2 };

	if ( buildtype == 99 ) then {
		_classname = FOB_typename;
		_price = 0;
		_price_fuel = 0;
	};

	if ( buildtype == 98 ) then {
		_classname = FOB_outpost;
		_price = 0;
		_price_fuel = 0;
		buildtype = 99;
	};

	if ( buildtype in [9,10] ) then {
		_price = 0;
		_price_fuel = 0;
		_classname = build_unit select 0;
		_color = build_unit select 1;
		_ammo = build_unit select 2;
		_compo = build_unit select 3;
		_lst_a3 = build_unit select 4;
		_lst_r3f = build_unit select 5;
		_lst_grl = build_unit select 6;
		build_altitude = 0.6;
	};

	if ( buildtype in [1,2,3,4,5,6,7,8] ) then {
		_score = [player] call F_getScore;
		_build_list = [];
		{
			if ( _score >= (_x select 4) ) then {_build_list pushback _x};
		} forEach (build_lists select buildtype);

		_classname = (_build_list select buildindex) select 0;
		_price = (_build_list select buildindex) select 2;
		_price_fuel = (_build_list select buildindex) select 3;
		_color = [];
		_compo = [];
		_ammo = 0;
		_lst_a3 = [];
		_lst_r3f = [];
		_lst_grl = [];
	};

	// Build 
	if ( buildtype == 1 ) then {
		_pos = [(getpos player select 0) + 1,(getpos player select 1) + 1, 0];

		if (_classname isKindOf "Dog_Base_F" || _classname in MFR_Dogs_classname) then {
			_unit = createAgent [_classname, _pos, [], 5, "CAN_COLLIDE"];
			_unit setVariable ["BIS_fnc_animalBehaviour_disable", true];
			_unit allowDamage false;
			player setVariable ["my_dog", _unit, true];
			_dog_snd = selectRandom ["dog1.wss", "dog2.wss", "dog3.wss"];
			_tone = [_dog_snd, random [0.7, 1, 1.5]];
			_unit setVariable ["my_dog_tone", _tone];
			_unit setDir (_unit getDir player);
			[_unit, _tone] spawn dog_bark;
			_id = (findDisplay 12 displayCtrl 51) ctrlAddEventHandler [
				"Draw", 
				"
					private _map = _this select 0;
					private _icon = 'a3\animals_f\data\ui\map_animals_ca.paa';
					private _size = 16;
					private _my_dog = player getVariable ['my_dog', nil];
					if (!isNil '_my_dog') then {
						_map drawIcon [_icon, [0.85,0.4,0,1], (getPosATL _my_dog), _size, _size, 0];
					};
				"
			]; 
			_unit setVariable ["my_dog_marker", _id];
		} else {
			if (!([_price] call F_pay)) exitWith {};
			_grp = group player;
			_unit = _grp createUnit [_classname, _pos, [], 5, "NONE"];
			[_unit] joinSilent _grp;
			_unit setVariable ["PAR_Grp_ID", format["Bros_%1", PAR_Grp_ID], true];
			PAR_AI_bros = PAR_AI_bros + [_unit];
			[_unit] spawn PAR_fn_AI_Damage_EH;
			_unit enableIRLasers true;
			_unit enableGunLights "Auto";
			_unit setUnitRank "PRIVATE";
			_unit setSkill 0.6;

			if (GRLIB_opfor_english) then {
				//[_unit, _spk] remoteExec ["setSpeaker", 0];
				_unit setSpeaker (format ["Male0%1ENG",selectRandom [2,3,4,5,6,7,8,9]]);
			};

			[_unit, configOf _unit] call BIS_fnc_loadInventory;
			if (_classname in units_loadout_overide) then {
				private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, toLower _classname];
				[_path, _unit] call F_getTemplateFile;
			};

			stats_blufor_soldiers_recruited = stats_blufor_soldiers_recruited + 1; publicVariable "stats_blufor_soldiers_recruited";
		};
		sleep 1;
		build_confirmed = 0;
		build_refresh = true;
	};

	if ( buildtype == 8 ) then {
		if (!([_price] call F_pay)) exitWith {};
		_pos = [(getpos player select 0) + 1,(getpos player select 1) + 1, 0];
		_grp = createGroup [GRLIB_side_friendly, true];
		player setVariable ["my_squad", _grp, true];
		_grp setGroupId [format ["%1 %2",squads_names select buildindex, groupId _grp]];
		_idx = 0;
		{
			_unitrank = "PRIVATE";
			if(_idx == 0) then { _unitrank = "SERGEANT"; };
			if(_idx == 1) then { _unitrank = "CORPORAL"; };
			_unit = _grp createUnit [_x, _pos, [], 5, "NONE"];
			[_unit] joinSilent _grp;
			_unit setUnitRank _unitrank;
			_unit setSkill 0.6;
			_unit enableIRLasers true;
			_unit enableGunLights "Auto";
			_unit setVariable ["PAR_Grp_ID", format["AI_%1",PAR_Grp_ID], true];
			//_unit forceAddUniform (uniform player);
			[_unit] spawn PAR_fn_AI_Damage_EH;
			_idx = _idx + 1;
			sleep 0.1;
		} foreach _classname;
		_grp setCombatMode "GREEN";
		_grp setBehaviour "AWARE";

		stats_blufor_soldiers_recruited = stats_blufor_soldiers_recruited + count (units _grp); publicVariable "stats_blufor_soldiers_recruited";
		player hcSetGroup [_grp];
		build_confirmed = 0;
	};

	if ( buildtype in [2,3,4,5,6,7,9,10,99] ) then {
		_posfob = getpos player;
		if (buildtype != 99) then {
			_posfob = [] call F_getNearestFob;
		};

		// Add Actions
		_idactcancel = -1;
		_idactview = -1;
		_idactsnap = -1;
		_idactupper = -1;
		_idactlower = -1;
		_idactmode = -1;
		_idactplacebis = -1;

		if ( buildtype == 6 && !(_classname in GRLIB_build_force_mode) ) then {
			_idactplacebis = player addAction ["<t color='#B0FF00'>" + localize "STR_PLACEMENT_BIS" + "</t> <img size='1' image='res\ui_confirm.paa'/>","scripts\client\build\build_place_bis.sqf","",-752,false,false,"","build_invalid == 0 && build_confirmed == 1"];
			_idactmode = player addAction ["<t color='#B0FF00'>" + localize "STR_MODE" + "</t> <img size='1' image='R3F_LOG\icons\r3f_drop.paa'/>","scripts\client\build\build_mode.sqf","",-755,false,false,"","build_confirmed == 1"];
		};

		if ( buildtype in [6, 99] ) then {
			_idactview = player addAction ["<t color='#B0FF00'>" + "-- Build view" + "</t>","scripts\client\build\build_view.sqf","",-755,false,false,"","build_confirmed == 1"];
			_idactsnap = player addAction ["<t color='#B0FF00'>" + localize "STR_GRID" + "</t>","scripts\client\build\do_grid.sqf","",-755,false,false,"","build_confirmed == 1"];
			_idactupper = player addAction ["<t color='#B0FF00'>" + localize "STR_MOVEUP" + "</t> <img size='1' image='R3F_LOG\icons\r3f_lift.paa'/>","scripts\client\build\build_up.sqf","",-755,false,false,"","build_confirmed == 1"];
			_idactlower = player addAction ["<t color='#B0FF00'>" + localize "STR_MOVEDOWN" + "</t> <img size='1' image='R3F_LOG\icons\r3f_release.paa'/>","scripts\client\build\build_down.sqf","",-755,false,false,"","build_confirmed == 1"];
		};

		_idactplace = player addAction ["<t color='#B0FF00'>" + localize "STR_PLACEMENT" + "</t> <img size='1' image='res\ui_confirm.paa'/>","scripts\client\build\build_place.sqf","",-750,false,true,"","build_invalid == 0 && build_confirmed == 1"];
		_idactrotate = player addAction ["<t color='#B0FF00'>" + localize "STR_ROTATION" + "</t> <img size='1' image='res\ui_rotation.paa'/>","scripts\client\build\build_rotate.sqf","",-756,false,false,"","build_confirmed == 1"];
		_idactcancel = player addAction ["<t color='#B0FF00'>" + localize "STR_CANCEL" + "</t> <img size='1' image='res\ui_cancel.paa'/>","scripts\client\build\build_cancel.sqf","",-760,false,true,"","build_confirmed == 1"];
		_ghost_spot = (markerPos "ghost_spot") findEmptyPosition [1,150,"B_Heli_Transport_03_unarmed_F"];
		_ghost_spot = _ghost_spot vectorAdd [0, 0, build_altitude];

		_vehicle = _classname createVehicleLocal _ghost_spot;
		_vehicle allowdamage false;
		_vehicle setVehicleLock "LOCKED";
		_vehicle enableSimulationGlobal false;
		_vehicle setVariable ["R3F_LOG_disabled", true];
		clearWeaponCargoGlobal _vehicle;
		clearMagazineCargoGlobal _vehicle;
		clearItemCargoGlobal _vehicle;
		clearBackpackCargoGlobal _vehicle;

		_dist = 0.5 * (sizeOf _classname);
		if (_dist < 3.5) then { _dist = 3.5 };
		_dist = _dist + 1.5;

		for [{_i=0}, {_i<5}, {_i=_i+1}] do {
			_vehicle setObjectTextureGlobal [_i, '#(rgb,8,8,3)color(0,1,0,0.8)'];
		};

		{ _x setObjectTexture [0, "#(rgb,8,8,3)color(0,1,0,1)"]; } foreach GRLIB_preview_spheres;


		// Wait for building
		while { build_confirmed == 1 && alive player } do {
			_truedir = 90 - (getdir player);
			_truepos = [((getpos player) select 0) + (_dist * (cos _truedir)), ((getpos player) select 1) + (_dist * (sin _truedir)), build_altitude];
			_actualdir = ((getdir player) + build_rotation);
			if (_classname == "Land_Cargo_Patrol_V1_F") then { _actualdir = _actualdir + 180 };
			if (_classname == FOB_typename) then { _actualdir = _actualdir + 270 };
			if (_classname in GRLIB_build_force_mode) then { build_mode = 1 };

			while { _actualdir > 360 } do { _actualdir = _actualdir - 360 };
			while { _actualdir < 0 } do { _actualdir = _actualdir + 360 };
			if ( ((buildtype == 6) || (buildtype == 99)) && ((gridmode % 2) == 1) ) then {
				if ( _actualdir >= 22.5 && _actualdir <= 67.5 ) then { _actualdir = 45 };
				if ( _actualdir >= 67.5 && _actualdir <= 112.5 ) then { _actualdir = 90 };
				if ( _actualdir >= 112.5 && _actualdir <= 157.5 ) then { _actualdir = 135 };
				if ( _actualdir >= 157.5 && _actualdir <= 202.5 ) then { _actualdir = 180 };
				if ( _actualdir >= 202.5 && _actualdir <= 247.5 ) then { _actualdir = 225 };
				if ( _actualdir >= 247.5 && _actualdir <= 292.5 ) then { _actualdir = 270 };
				if ( _actualdir >= 292.5 && _actualdir <= 337.5 ) then { _actualdir = 315 };
				if ( _actualdir <= 22.5 || _actualdir >= 337.5 ) then { _actualdir = 0 };
			};

			_sphere_idx = 0;
			{
				_x setpos ( [ _truepos, _dist, _sphere_idx * 10 ] call BIS_fnc_relPos );
				_sphere_idx = _sphere_idx + 1;
			} foreach GRLIB_preview_spheres;

			_near_objects = (_truepos nearobjects ["AllVehicles", _dist]) ;
			_near_objects = _near_objects + (_truepos nearobjects [FOB_box_typename, _dist]);
			_near_objects = _near_objects + (_truepos nearobjects [FOB_box_outpost, _dist]);

			_near_objects_25 = (_truepos nearobjects ["AllVehicles", 50]) ;
			_near_objects_25 = _near_objects_25 + (_truepos nearobjects [FOB_box_typename, 50]);
			_near_objects_25 = _near_objects_25 + (_truepos nearobjects [FOB_box_outpost, 50]);

			if(	buildtype != 6 ) then {
				_near_objects = _near_objects + (_truepos nearobjects ["Static", _dist]);
				_near_objects_25 = _near_objects_25 + (_truepos nearobjects ["Static", 50]);
			};

			private _remove_objects = [];
			{
				if ((_x isKindOf "Animal") || ([_x, GRLIB_ignore_colisions] call F_itemIsInClass) || (_x == player) || (_x == _vehicle )) then {
					_remove_objects pushback _x;
				};
			} foreach _near_objects;

			private _remove_objects_25 = [];
			{
				if ((_x isKindOf "Animal") || ([_x, GRLIB_ignore_colisions] call F_itemIsInClass) || (_x == player) || (_x == _vehicle ))  then {
					_remove_objects_25 pushback _x;
				};
			} foreach _near_objects_25;

			_near_objects = _near_objects - _remove_objects;
			_near_objects_25 = _near_objects_25 - _remove_objects_25;

			if (_classname == land_cutter_typename) then {
				_near_objects = _near_objects + ([(_truepos nearobjects [land_cutter_typename, 20]), {(_x != _vehicle)}] call BIS_fnc_conditionalSelect);
			};

			if ( count _near_objects == 0 ) then {
				{
					_dist22 = 0.5 * (sizeOf (typeof _x));
					if ( _dist22 < 1 ) then { _dist22 = 1 };
					if (_truepos distance _x < _dist22) then {
						_near_objects pushback _x;
					};
				} foreach _near_objects_25;
			};

			if ( count _near_objects != 0 ) then {
				GRLIB_conflicting_objects = _near_objects;
			} else {
				GRLIB_conflicting_objects = [];
			};

			if ( count _near_objects == 0 && ((_truepos distance _posfob) < _maxdist || buildtype == 9) && (((!surfaceIsWater _truepos) && (!surfaceIsWater getpos player)) || (_classname in boats_names)) ) then {
				if ( _classname isKindOf "Ship" && surfaceIsWater _truepos ) then {
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
					GRLIB_ui_notif = format [localize "STR_PLACEMENT_IMPOSSIBLE",count _near_objects, round _dist];

					if (_debug_colisions) then {
						private [ "_objs_classnames" ];
						_objs_classnames = [];
						{ _objs_classnames pushback (typeof _x) } foreach _near_objects;
						hint format [ "Colisions : %1", _objs_classnames ];
					};
				};
				if( ((surfaceIsWater _truepos) || (surfaceIsWater getpos player)) && !(_classname in boats_names)) then {
					GRLIB_ui_notif = localize "STR_BUILD_ERROR_WATER";
				};
				if( (_truepos distance _posfob) > _maxdist && buildtype != 9) then {
					GRLIB_ui_notif = format [localize "STR_BUILD_ERROR_DISTANCE",_maxdist];
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

			_vehicle = _classname createVehicle _truepos;
			_vehicle allowDamage false;
			_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
			_vehicle setPosWorld _veh_pos;
			_allow_damage = true;

			if ( _classname isKindOf "Ship" && surfaceIsWater _truepos ) then {
				_vehicle setposASL _truepos;
			};

			// Ammo Box clean inventory
			if ( !(_classname in GRLIB_Ammobox_keep + GRLIB_disabled_arsenal) ) then {
				clearWeaponCargoGlobal _vehicle;
				clearMagazineCargoGlobal _vehicle;
				clearItemCargoGlobal _vehicle;
				clearBackpackCargoGlobal _vehicle;
			};

			// Vehicle owner
			if ( buildtype in [2,3,4,5,7,9,10] ) then {
				if (!([typeOf _vehicle, GRLIB_vehicle_blacklist] call F_itemIsInClass)) then {
					_vehicle setVariable ["GRLIB_vehicle_owner", getPlayerUID player, true];
					_vehicle allowCrewInImmobile [true, false];
					_vehicle setUnloadInCombat [true, false];
				};
			};

			// Crewed vehicle
			if ( (_classname in uavs) || manned ) then {
				[ _vehicle ] call F_forceBluforCrew;
				_vehicle setVariable ["GRLIB_vehicle_manned", true, true];
				player hcSetGroup [group _vehicle];
				player linkItem "B_UavTerminal";
			};

			if (_classname isKindOf "LandVehicle" || _classname isKindOf "Air" || _classname isKindOf "Ship") then {
				// Give real truck horn to APC,Truck,Tank
				if ( _vehicle isKindOf "Wheeled_APC_F" || _vehicle isKindOf "Tank_F" || _vehicle isKindOf "Truck_F" ) then {
					_vehicle removeWeaponTurret ["TruckHorn", [-1]];
					_vehicle removeWeaponTurret ["TruckHorn2", [-1]];
					_vehicle addWeaponTurret ["TruckHorn3", [-1]];
				};

				// CUP remove tank panel
				if (GRLIB_CUPV_enabled) then {
					[_vehicle, false, ["hide_front_ti_panels",1,"hide_cip_panel_rear",1,"hide_cip_panel_bustle",1]] call BIS_fnc_initVehicle;
				};

				// RHS remove tank panel
				if (GRLIB_RHS_enabled) then {
					[_vehicle, false, ["IFF_Panels_Hide",1,"Miles_Hide",1]] call BIS_fnc_initVehicle;
				};

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
					[_vehicle, ["EAF",1], true ] call BIS_fnc_initVehicle;
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
				_vehicle setMaxLoad playerbox_cargospace;
				_allow_damage = false;
			};

			// A3 / R3F Inventory
			if ( count _lst_a3 > 0 ) then {
				[_vehicle, _lst_a3] call F_setCargo;
			};

			if ( count _lst_r3f > 0 && !GRLIB_ACE_enabled ) then {
				[_vehicle, _lst_r3f] call R3F_LOG_FNCT_transporteur_charger_auto;
			};

			if ( count _lst_grl > 0 ) then {
				{[_vehicle, _x] call attach_object_direct} forEach _lst_grl;
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
			if (_classname in (list_static_weapons - static_vehicles_AI)) then {
				_allow_damage = false;
			};

			// AI Static Weapon
			if (_classname in static_vehicles_AI) then {
				_vehicle setMass 5000;
				[ _vehicle ] call F_forceBluforCrew;
				_vehicle setVariable ["GRLIB_vehicle_manned", true, true];
				_vehicle setVehicleLock "LOCKEDPLAYER";
				_vehicle addEventHandler ["Fired", { (_this select 0) setVehicleAmmo 1 }];
				_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_static }];
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

			// FOB
			if(buildtype == 99) then {
				playsound "Land_Carrier_01_blast_deflector_up_sound";
				[_vehicle, getPlayerUID player] remoteExec ["build_fob_remote_call", 2];
				_allow_damage = false;
			};

			sleep 0.3;
			if (_allow_damage) then { _vehicle allowDamage true };
			_vehicle setDamage 0;
			build_vehicle = _vehicle;

			if(buildtype != 6) then {
				_vehicle addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
			};

			stats_blufor_vehicles_built = stats_blufor_vehicles_built + 1; publicVariable "stats_blufor_vehicles_built";
		};

		// Remove Actions
		if ( _idactcancel != -1 ) then { player removeAction _idactcancel };
		if ( _idactsnap != -1 ) then { player removeAction _idactsnap };
		if ( _idactview != -1 ) then { player removeAction _idactview };
		if ( _idactplacebis != -1 ) then { player removeAction _idactplacebis };
		if ( _idactmode != -1 ) then { player removeAction _idactmode };
		if ( _idactupper != -1 ) then {
			player removeAction _idactupper;
			player removeAction _idactlower;
		};
		player removeAction _idactrotate;
		player removeAction _idactplace;
	};
	
	build_confirmed = 0;

	if ( repeatbuild ) then {
		dobuild = 1;
		repeatbuild = false;
		building_altitude = build_altitude;
	} else {
		dobuild = 0;
		build_rotation = 0;
		building_altitude = 0;
		build_mode = 0;
	};
	manned = false;
};
