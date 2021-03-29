private [ "_maxdist", "_truepos", "_built_object_remote", "_unit", "_pos", "_grp", "_classname", "_idx", "_unitrank", "_posfob", "_ghost_spot", "_vehicle", "_dist", "_actualdir", "_near_objects", "_near_objects_25", "_debug_colisions" ];
_isInClass = {
	params ["_unit"];
	private _ret = false;
  	{ if (_unit isKindOf _x) then { _ret = true } } forEach GRLIB_ignore_colisions_classes;
	_ret;
};

build_confirmed = 0;
_maxdist = GRLIB_fob_range;
_truepos = [];
_debug_colisions = false;
_price = 0;
_color = [];
_ammo = 0;
_lst_a3 = [];
_lst_r3f = [];
build_unit = [];
_list_static = [] + opfor_statics;
{_list_static pushBack ( _x select 0 )} foreach (static_vehicles);

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

waitUntil { sleep 0.2; !isNil "dobuild" };

while { true } do {
	waitUntil { sleep 0.2; dobuild != 0 };

	build_confirmed = 1;
	build_invalid = 0;
	_classname = "";
	if ( buildtype == 99 ) then {
		_classname = FOB_typename;
		_price = 0;
	} else {
		if (buildtype == 9) then {
			_price = 0;
			_classname = build_unit select 0;
			_color = build_unit select 1;
			_ammo = build_unit select 2;
			_lst_a3 = build_unit select 3;
			_lst_r3f = build_unit select 4;
		} else {
			_score = [player] call F_getScore;
			_build_list = [];
			{
				if ( _score >= (_x select 4) ) then {_build_list pushback _x};
			} forEach (build_lists select buildtype);

			_classname = (_build_list select buildindex) select 0;
			_price = (_build_list select buildindex) select 2;
			_color = [];
			_ammo = 0;
		};
	};

	if(buildtype == 1) then {
		_pos = [(getpos player select 0) + 1,(getpos player select 1) + 1, 0];

		if (_classname isKindOf "Dog_Base_F") then {
			if (isNil {player getVariable ["my_dog", nil]} ) then {
				_unit = createAgent [_classname, _pos, [], 5, "CAN_COLLIDE"];
				_unit setVariable ["BIS_fnc_animalBehaviour_disable", true];
				_unit allowDamage false;
				player setVariable ["my_dog", _unit, true];
				playSound3D ["a3\sounds_f\ambient\animals\dog1.wss", _unit, false, getPosASL _unit, 2, 0.8, 0];
				_unit setDir (_unit getDir player);
				_unit playMoveNow "Dog_Idle_Bark";
			} else {
				hint "Only One Dog Allowed !!";
				sleep 3;
			};
		} else {
			_grp = group player;
			_unit = _grp createUnit [_classname, _pos, [], 5, "NONE"];
			_unit addUniform uniform player;
			_unit setMass 10;
			_unit setUnitRank "PRIVATE";
			_unit setSkill 0.6;
			_grp = group player;
			_unit setVariable ["PAR_Grp_ID", format["Bros_%1",PAR_Grp_ID], true];
			_unit enableIRLasers true;
			_unit enableGunLights "Auto";
			[_unit] call player_EVH;

			if (typeOf _unit in units_loadout_overide) then {
				_loadouts_folder = format ["scripts\loadouts\%1\%2.sqf", GRLIB_side_friendly, typeOf _unit];
				[_unit] call compileFinal preprocessFileLineNUmbers _loadouts_folder;
			};

			stats_blufor_soldiers_recruited = stats_blufor_soldiers_recruited + 1; publicVariable "stats_blufor_soldiers_recruited";
		};
		if (!([_price] call F_pay)) exitWith {};
		build_confirmed = 0;
	} else {
		if ( buildtype == 8 ) then {
			if (isNil {player getVariable ["my_squad", nil]} ) then {
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
					_unit setUnitRank _unitrank;
					_unit setSkill 0.6;
					_unit enableIRLasers true;
					_unit enableGunLights "Auto";
					_unit setVariable ["PAR_Grp_ID", format["AI_%1",PAR_Grp_ID], true];
					_unit addUniform uniform player;
					[_unit] call PAR_fn_AI_Damage_EH;
					_idx = _idx + 1;
				} foreach _classname;
				_grp setCombatMode "GREEN";
				_grp setBehaviour "AWARE";

				if (!([_price] call F_pay)) exitWith {};
				stats_blufor_soldiers_recruited = stats_blufor_soldiers_recruited + count (units _grp); publicVariable "stats_blufor_soldiers_recruited";
				player hcSetGroup [_grp];
			} else {
				hint "Only One Squad Allowed !!";
				sleep 3;
			};
			build_confirmed = 0;
		} else {
			_posfob = getpos player;
			if (buildtype != 99) then {
				_posfob = [] call F_getNearestFob;
			};

			_idactcancel = -1;
			_idactsnap = -1;
			_idactupper = -1;
			_idactlower = -1;
			_idactplacebis = -1;

			if (buildtype == 6 ) then {
				_idactplacebis = player addAction ["<t color='#B0FF00'>" + localize "STR_PLACEMENT_BIS" + "</t> <img size='1' image='res\ui_confirm.paa'/>","scripts\client\build\build_place_bis.sqf","",-752,false,false,"","build_invalid == 0 && build_confirmed == 1"];
			};
			if (buildtype == 6 || buildtype == 99) then {
				_idactsnap = player addAction ["<t color='#B0FF00'>" + localize "STR_GRID" + "</t>","scripts\client\build\do_grid.sqf","",-755,false,false,"","build_confirmed == 1"];
				_idactupper = player addAction ["<t color='#B0FF00'>" + localize "STR_MOVEUP" + "</t> <img size='1' image='R3F_LOG\icons\r3f_lift.paa'/>","scripts\client\build\build_up.sqf","",-755,false,false,"","build_confirmed == 1"];
				_idactlower = player addAction ["<t color='#B0FF00'>" + localize "STR_MOVEDOWN" + "</t> <img size='1' image='R3F_LOG\icons\r3f_release.paa'/>","scripts\client\build\build_down.sqf","",-755,false,false,"","build_confirmed == 1"];
			};
			_idactplace = player addAction ["<t color='#B0FF00'>" + localize "STR_PLACEMENT" + "</t> <img size='1' image='res\ui_confirm.paa'/>","scripts\client\build\build_place.sqf","",-750,false,true,"","build_invalid == 0 && build_confirmed == 1"];
			_idactrotate = player addAction ["<t color='#B0FF00'>" + localize "STR_ROTATION" + "</t> <img size='1' image='res\ui_rotation.paa'/>","scripts\client\build\build_rotate.sqf","",-756,false,false,"","build_confirmed == 1"];
			_idactcancel = player addAction ["<t color='#B0FF00'>" + localize "STR_CANCEL" + "</t> <img size='1' image='res\ui_cancel.paa'/>","scripts\client\build\build_cancel.sqf","",-760,false,true,"","build_confirmed == 1 && buildtype != 9"];
			_ghost_spot = (getmarkerpos "ghost_spot") findEmptyPosition [1,50,_classname];

			_vehicle = _classname createVehicleLocal _ghost_spot;
			_vehicle allowdamage false;
			_vehicle setVehicleLock "LOCKED";
			_vehicle enableSimulationGlobal false;
			_vehicle setVariable ["R3F_LOG_disabled", true];

			_dist = 0.6 * (sizeOf _classname);
			if (_dist < 3.5) then { _dist = 3.5 };
			_dist = _dist + 0.5;

			for [{_i=0}, {_i<5}, {_i=_i+1}] do {
				_vehicle setObjectTextureGlobal [_i, '#(rgb,8,8,3)color(0,1,0,0.8)'];
			};

			{ _x setObjectTexture [0, "#(rgb,8,8,3)color(0,1,0,1)"]; } foreach GRLIB_preview_spheres;

			while { build_confirmed == 1 && alive player } do {
				_truedir = 90 - (getdir player);
				_truepos = [((getpos player) select 0) + (_dist * (cos _truedir)), ((getpos player) select 1) + (_dist * (sin _truedir)), build_altitude];
				_actualdir = ((getdir player) + build_rotation);
				if ( _classname == "Land_Cargo_Patrol_V1_F" || _classname == "Land_PortableLight_single_F" ) then { _actualdir = _actualdir + 180 };
				if ( _classname == FOB_typename ) then { _actualdir = _actualdir + 270 };

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

				_vehicle setdir _actualdir;

				_near_objects = (_truepos nearobjects ["AllVehicles", _dist]) ;
				_near_objects = _near_objects + (_truepos nearobjects [FOB_box_typename, _dist]);
				_near_objects = _near_objects + (_truepos nearobjects [Arsenal_typename, _dist]);

				_near_objects_25 = (_truepos nearobjects ["AllVehicles", 50]) ;
				_near_objects_25 = _near_objects_25 + (_truepos nearobjects [FOB_box_typename, 50]);
				_near_objects_25 = _near_objects_25 + (_truepos nearobjects [Arsenal_typename, 50]);

				if(	buildtype != 6 ) then {
					_near_objects = _near_objects + (_truepos nearobjects ["Static", _dist]);
					_near_objects_25 = _near_objects_25 + (_truepos nearobjects ["Static", 50]);
				};

				private _remove_objects = [];
				{
					if ((_x isKindOf "Animal") || ((typeof _x) in GRLIB_ignore_colisions_objects) || ([_x] call _isInClass) || (_x == player) || (_x == _vehicle )) then {
						_remove_objects pushback _x;
					};
				} foreach _near_objects;

				private _remove_objects_25 = [];
				{
					if ((_x isKindOf "Animal") || ((typeof _x) in GRLIB_ignore_colisions_objects) || ([_x] call _isInClass) || (_x == player) || (_x == _vehicle ))  then {
						_remove_objects_25 pushback _x;
					};
				} foreach _near_objects_25;

				_near_objects = _near_objects - _remove_objects;
				_near_objects_25 = _near_objects_25 - _remove_objects_25;

				if ( count _near_objects == 0 ) then {
					{
						_dist22 = 0.6 * (sizeOf (typeof _x));
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

				if (count _near_objects == 0 && ((_truepos distance _posfob) < _maxdist || buildtype == 9) && (  ((!surfaceIsWater _truepos) && (!surfaceIsWater getpos player)) || (_classname in boats_names) ) ) then {

					_vehicle setposATL _truepos;

					if(build_invalid == 1) then {
						GRLIB_ui_notif = "";
						{ _x setObjectTexture [0, "#(rgb,8,8,3)color(0,1,0,1)"]; } foreach GRLIB_preview_spheres;
					};
					build_invalid = 0;

				} else {
					if ( build_invalid == 0 ) then {
						{ _x setObjectTexture [0, "#(rgb,8,8,3)color(1,0,0,1)"]; } foreach GRLIB_preview_spheres;
					};
					_vehicle setpos _ghost_spot;
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

			GRLIB_ui_notif = "";

			{ _x setpos [ 0,0,0 ] } foreach GRLIB_preview_spheres;

			if ( !alive player || build_confirmed == 3 ) then {
				deleteVehicle _vehicle;
				buildtype = 1;
			};

			if ( build_confirmed == 2 ) then {
				_vehdir = getdir _vehicle;
				deleteVehicle _vehicle;
				sleep 0.1;
				_vehicle = _classname createVehicle _truepos;
				_vehicle allowDamage false;
				_vehicle setdir _vehdir;
				_vehicle setposATL _truepos;

				// Ammo Box
				if (!(_classname in  GRLIB_Ammobox)) then {
					clearWeaponCargoGlobal _vehicle;
					clearMagazineCargoGlobal _vehicle;
					clearItemCargoGlobal _vehicle;
					clearBackpackCargoGlobal _vehicle;
				};

				// Vehicle owner
				if(buildtype in [2,3,4,7,9]) then {
					if (!(typeOf _vehicle in GRLIB_vehicle_blacklist) ) then {
						_vehicle setVariable ["GRLIB_vehicle_owner", getPlayerUID player, true];
						_vehicle allowCrewInImmobile true;
						_vehicle setUnloadInCombat [true, false];
					};
				};

				// Crewed vehicle
				if ( (_classname in uavs) || manned ) then {
					[ _vehicle ] call F_forceBluforCrew;
					_vehicle setVariable ["GRLIB_vehicle_manned", true, true];
					player hcSetGroup [group _vehicle];
				};

				// set mass heavy Static
				if ( _classname in ["B_AAA_System_01_F","B_Ship_Gun_01_F"] ) then {
					_vehicle setMass 5000;
				};

				// Default Paint
				if ( _classname in ["I_E_Truck_02_MRL_F"] ) then {
					[_vehicle, ["EAF",1], true ] call BIS_fnc_initVehicle;
				};

				// Color
				if (count _color > 0) then {
					[_vehicle, _color, "N/A", []] call RPT_fnc_TextureVehicle;
				};

				// Remaining Ammo
				if (_ammo > 0) then {
					_vehicle setVehicleAmmoDef _ammo;
				};

				// Automatic ReAmmo
				if (_classname in vehicle_rearm_sources) then {
					_vehicle setAmmoCargo 0;
				};

				// Give real truck horn to APC,Truck,Tank
				if ( _vehicle isKindOf "Wheeled_APC_F" || _vehicle isKindOf "Tank_F" || _vehicle isKindOf "Truck_F" ) then {
					_vehicle removeWeaponTurret ["TruckHorn", [-1]];
					_vehicle removeWeaponTurret ["TruckHorn2", [-1]];
					_vehicle addWeaponTurret ["TruckHorn3", [-1]];
				};

				// Mobile respawn
				if (_classname == mobile_respawn) then {
					[_vehicle, "add"] remoteExec ["addel_beacon_remote_call", 2];
				};

				// A3 / R3F Inventory
				if (buildtype == 9 && !(_classname in GRLIB_vehicle_whitelist) ) then {
					{_vehicle addWeaponWithAttachmentsCargoGlobal [ _x, 1] } forEach _lst_a3;
					[_vehicle, _lst_r3f] call R3F_LOG_FNCT_transporteur_charger_auto;
				};

				// Static Weapon
				if (_classname in _list_static) then {
					[_vehicle] spawn protect_static;
				};

				sleep 0.3;
				_vehicle allowDamage true;
				_vehicle setDamage 0;

				if(buildtype == 99) then {
					_vehicle addEventHandler ["HandleDamage", { 0 }];
				};

				if(buildtype != 6) then {
					_vehicle addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
				};

				if (!([_price] call F_pay)) exitWith {};
				stats_blufor_vehicles_built = stats_blufor_vehicles_built + 1; publicVariable "stats_blufor_vehicles_built";
			};

			if ( _idactcancel != -1 ) then {
				player removeAction _idactcancel;
			};
			if ( _idactsnap != -1 ) then {
				player removeAction _idactsnap;
			};
			if ( _idactplacebis != -1 ) then {
				player removeAction _idactplacebis;
			};
			if ( _idactupper != -1 ) then {
				player removeAction _idactupper;
				player removeAction _idactlower;
			};
			player removeAction _idactrotate;
			player removeAction _idactplace;

			if(buildtype == 99 && build_confirmed != 3) then {
				[_vehicle, false] remoteExec ["allowDamage", 0];
				[(getpos _vehicle), false] remoteExec ["build_fob_remote_call", 0];
				buildtype = 1;
			};

			build_confirmed = 0;
		};
	};

	if ( repeatbuild ) then {
		dobuild = 1;
		repeatbuild = false;
	} else {
		dobuild = 0;
		build_rotation = 0;
		build_altitude = 0;
	};
	manned = false;
};
