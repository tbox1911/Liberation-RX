private _distarsenal = 10;
private _distredeploy = 20;
private _distvehclose = 5;
private _icon_dog = (getText (configFile >> "CfgVehicleIcons" >> "iconAnimal"));
private _icon_grp = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
private _icon_tuto = "\a3\ui_f\data\map\markers\handdrawn\unknown_ca.paa";

private _id_actions = [
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,	
	-1, -1
];

private [
	"_fobdistance",	"_near_outpost", "_outpost_owner", "_near_arsenal", "_near_spawn",
	"_near_fobbox",	"_near_fuel", "_near_repair", "_near_atm", "_near_lhd", "_my_dog", "_my_squad",
	"_idact_id", "_idact_num"
];

is_DogOnDuty = {
	private _my_dog = player getVariable ["my_dog", nil];
    (!isNil {_my_dog getVariable ["do_find", nil]} || stopped _my_dog);
};

waitUntil { sleep 1; !isNil "build_confirmed" };
waituntil { sleep 1; GRLIB_player_spawned; (player getVariable ["GRLIB_score_set", 0] == 1)};
waitUntil { sleep 1; !isNil "GRLIB_mobile_respawn" };
waituntil { sleep 1; !isNil "GRLIB_marker_init" };
if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {};

while { true } do {
	GRLIB_player_is_menuok = [] call is_menuok;
	if (GRLIB_player_is_menuok) then {
		_fobdistance = round (player distance2D ([] call F_getNearestFob));
		_near_outpost = ([player, "OUTPOST", GRLIB_fob_range] call F_check_near);
		_outpost_owner = [getPosATL player] call F_getFobOwner;
		_near_arsenal = [player, "ARSENAL", _distarsenal, true] call F_check_near;
		_near_spawn = ([player, "SPAWNT", _distarsenal, true] call F_check_near || [player, "SPAWNV", _distvehclose, true] call F_check_near);
		_near_fobbox = player nearEntities [[FOB_box_typename, FOB_truck_typename, FOB_box_outpost], _distvehclose];
		_near_fuel = [player, "FUEL", _distvehclose, false] call F_check_near;
		_near_repair = [player, "REPAIR", _distvehclose, false] call F_check_near;
		_near_atm = [player, "ATM", _distvehclose, true] call F_check_near;
		//_near_medic = [player, "MEDIC", _distvehclose, true] call F_check_near;
		_near_lhd = (player distance2D lhd < GRLIB_fob_range);
		_my_dog = player getVariable ["my_dog", nil];
		_my_squad = player getVariable ["my_squad", nil];
		_idact_id = 0;

		// Tuto
		_idact_num = _id_actions select _idact_id;
		if (_near_lhd ) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_TUTO_ACTION" + "</t> <img size='1' image='" + _icon_tuto + "'/>","[] execVM 'scripts\client\ui\tutorial_manager.sqf'","",-740,false,true,"",""];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Admin Menu
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if (([] call is_admin || getPlayerUID player in GRLIB_whitelisted_moderators) && GRLIB_admin_menu ) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#0000F8'>" + localize "STR_ADMIN_MENU" + "</t>","scripts\client\commander\admin_menu.sqf","",999,false,true,"",""];
				_id_actions set [_idact_id, _idact];
				_idact = player addAction ["<t color='#008080'>-- CONFIGURE MISSION</t>","scripts\client\commander\open_params.sqf","",998,false,true,"",""];
				_id_actions set [_idact_id+1, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
				_idact_num = _id_actions select _idact_id+1;
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Dog - Actions
		_idact_id = _idact_id + 2;
		_idact_num = _id_actions select _idact_id;
		if (!isNil "_my_dog") then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_DOG_FIND" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","find",-640,false,true,"","!call is_DogOnDuty"];
				_id_actions set [_idact_id, _idact];
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_DOG_RECALL" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","recall",-640,false,true,"","call is_DogOnDuty"];
				_id_actions set [_idact_id+1, _idact];
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_DOG_STOP" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","stop",-641,false,true,"","!call is_DogOnDuty"];
				_id_actions set [_idact_id+2, _idact];
				_idact = player addAction ["<t color='#FF8080'>" + localize "STR_DOG_DISMISS" + "</t> <img size='1' image='" + _icon_dog + "'/>","scripts\client\actions\do_dog.sqf","del",-642,false,true,"",""];
				_id_actions set [_idact_id+3, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
				_idact_num = _id_actions select _idact_id+1;
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
				_idact_num = _id_actions select _idact_id+2;
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
				_idact_num = _id_actions select _idact_id+3;
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Squad - Actions
		_idact_id = _idact_id + 4;
		_idact_num = _id_actions select _idact_id;
		if (!isNil "_my_squad") then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_SQUAD_MOVE" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","move",-635,false,true,"",""];
				_id_actions set [_idact_id, _idact];
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_SQUAD_FOLLOW" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","follow",-635,false,true,"",""];
				_id_actions set [_idact_id+1, _idact];
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_SQUAD_STOP" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","stop",-635,false,true,"",""];
				_id_actions set [_idact_id+2, _idact];
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_SQUAD_DISMISS" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\actions\do_squad.sqf","del",-635,false,true,"",""];
				_id_actions set [_idact_id+3, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
				_idact_num = _id_actions select _idact_id+1;
				player removeAction _idact_num;
				_id_actions set [_idact_id+1, -1];
				_idact_num = _id_actions select _idact_id+2;
				player removeAction _idact_num;
				_id_actions set [_idact_id+2, -1];
				_idact_num = _id_actions select _idact_id+3;
				player removeAction _idact_num;
				_id_actions set [_idact_id+3, -1];
			};
		};

		// Halo Jump
		_idact_id = _idact_id + 4;
		_idact_num = _id_actions select _idact_id;
		if ((_near_spawn || _near_lhd) && GRLIB_halo_param > 0) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_HALO_ACTION" + "</t> <img size='1' image='res\ui_redeploy.paa'/>","scripts\client\spawn\do_halo.sqf","",-749,false,true,"","build_confirmed == 0"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Send Ammo
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if  (( _near_lhd || _near_atm ) && count (AllPlayers - (entities "HeadlessClient_F")) > 1) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#80FF00'>" + localize "STR_SEND_AMMO" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\misc\send_ammo.sqf","",-981,true,true,"","build_confirmed == 0"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Fuel
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if (!_near_lhd && (_near_fuel || _near_repair) ) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#00F080'>" + localize "STR_BUY_FUEL" + "</t> <img size='1' image='R3F_LOG\icons\r3f_fuel.paa'/>", "scripts\client\actions\do_buyfuel.sqf","",-900,true,true,"",""];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Heal Self
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if ((_fobdistance < _distarsenal || _near_lhd) && damage player >= 0.02) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<img size='1' image='\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca'/> Heal self", { (_this select 1) playMove "AinvPknlMstpSlayWnonDnon_medic"; (_this select 1) setDamage 0;},"",999,true,true,"", ""];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Take Leadrship
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if (!(isPlayer (leader (group player))) && (local (group player)) ) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_TAKE_LEADRSHIP" + "</t> <img size='1' image='" + _icon_grp + "'/>", {(group player) selectLeader player}, [],0,true,true,"", "build_confirmed == 0"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Air Drop
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if ((player distance2D ([] call F_getNearestFob)) >= (2 * GRLIB_fob_range) && !_near_lhd ) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#00F0F0'>" + localize "STR_AIR_SUPPORT" + "</t> <img size='1' image='R3F_LOG\icons\r3f_drop.paa'/>","scripts\client\misc\drop_support.sqf","",-980,false,true];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Redeploy
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if ((_near_spawn || _near_lhd) ) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_DEPLOY_ACTION" + "</t> <img size='1' image='res\ui_redeploy.paa'/>","scripts\client\spawn\redeploy_manager.sqf","",-750,false,true,"","build_confirmed == 0"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Arsenal
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if (GRLIB_enable_arsenal && (_near_arsenal || _near_lhd) && LRX_arsenal_init_done) then {
			if (_idact_num == -1) then {
				_idact = player addAction ["<t color='#FFFF00'>" + localize "STR_ARSENAL_ACTION" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\open_arsenal.sqf","",-500,true,true,"","build_confirmed == 0"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Virtual Garage
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if (_fobdistance > 15 && _fobdistance < GRLIB_fob_range && !_near_outpost && !_near_lhd && [player] call F_getScore >= GRLIB_perm_inf ) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#0080FF'>" + localize "STR_VIRTUAL_GARAGE" + "</t> <img size='1' image='res\ui_veh.paa'/>","addons\VIRT\virtual_garage.sqf","",-984,false,true,"","build_confirmed == 0"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Build Menu
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if (_fobdistance < GRLIB_fob_range && !_near_lhd && ( ([player, 3] call fetch_permission) || (player == ([] call F_getCommander) || [] call is_admin)) ) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#FFFF00'>" + localize "STR_BUILD_ACTION" + "</t> <img size='1' image='res\ui_build.paa'/>","scripts\client\build\open_build_menu.sqf","",-985,false,true,"","build_confirmed == 0"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Squad Management
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if ((leader group player == player) && (count units group player > 1) && (_fobdistance < GRLIB_fob_range || _near_lhd) ) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#80FF80'>" + localize "STR_SQUAD_MANAGEMENT_ACTION" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\ui\squad_management.sqf","",-760,false,true,"","build_confirmed == 0"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Commander Menu
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if (( player == ( [] call F_getCommander ) || [] call is_admin ) && GRLIB_permissions_param ) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#FF8000'>" + localize "STR_COMMANDER_ACTION" + "</t> <img size='1' image='" + _icon_grp + "'/>","scripts\client\commander\open_permissions.sqf","",-996,false,true,"","build_confirmed == 0"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Secondary Objectives
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if (count GRLIB_all_fobs > 0 && ( GRLIB_endgame == 0 ) && (_fobdistance < _distvehclose || _near_lhd) && (!_near_outpost) && ([player] call F_getScore >= GRLIB_perm_air ||  player == ( [] call F_getCommander ) || [] call is_admin) ) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#FFFF00'>" + localize "STR_SECONDARY_OBJECTIVES" + "</t>","scripts\client\ui\secondary_ui.sqf","",-995,false,true,"","build_confirmed == 0"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Pack FOB
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if ((_fobdistance < _distarsenal && !_near_lhd) && (!_near_outpost) && ( ([player] call F_getScore >= GRLIB_perm_max) || (player == ( [] call F_getCommander ) || [] call is_admin) )) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#FF6F00'>" + localize "STR_FOB_REPACKAGE" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_repackage_fob.sqf",([] call F_getNearestFob),-981,false,true,"","build_confirmed == 0"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Build FOB
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if ((_fobdistance > GRLIB_sector_size && !_near_lhd) && cursorObject in _near_fobbox ) then {
			if ( _idact_num == -1 ) then {
				_str = localize "STR_FOB_ACTION";
				if (typeOf cursorObject == FOB_box_outpost) then {
					_str = localize "STR_OUTPOST_ACTION";
				};
				_idact = player addAction ["<t color='#FF6F00'>" + _str + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_build_fob.sqf",cursorObject,-981,false,true,"","build_confirmed == 0 && !(cursorObject getVariable ['box_in_use', false])"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Pack Beacon
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if (!_near_lhd && typeOf cursorObject == mobile_respawn && ([player, cursorObject] call is_owner) ) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#FFFF00'>" + localize "STR_PACK_BEACON" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_beacon_pack.sqf",cursorObject,-950,true,true,"","!(cursorObject getVariable ['tent_in_use', false])"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// UnPack Beacon
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if (!_near_lhd && (backpackContainer player) getVariable ["GRLIB_mobile_respawn_bag", false]) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#FFFF00'>" + localize "STR_UNPACK_BEACON" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_beacon_unpack.sqf","",-950,true,true,"",""];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// Options
		// private _idact_options = _id_actions select 26;
		// if ( (_fobdistance < _distredeploy || _near_lhd) ) then {
		// 	if ( _idact_options == -1 ) then {
		// 		_idact = player addAction ["<t color='#FF8000'>" + localize "STR_EXTENDED_OPTIONS" + "</t>","GREUH\scripts\GREUH_dialog.sqf","",-997,false,true];
		// 		_id_actions set [26, _idact];
		// 	};
		// } else {
		// 	if ( _idact_options != -1 ) then {
		// 		player removeAction _idact_options;
		// 		_id_actions set [26, -1];
		// 	};
		// };

		// Destroy Outpost
		_idact_id = _idact_id + 1;
		_idact_num = _id_actions select _idact_id;
		if ((_fobdistance < _distarsenal && !_near_lhd) && _near_outpost && ( (getPlayerUID player == _outpost_owner) || (player == ( [] call F_getCommander ) || [] call is_admin) )) then {
			if ( _idact_num == -1 ) then {
				_idact = player addAction ["<t color='#FF6F00'>" + localize "STR_DESTROY_OUTPOST" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_destroy_fob.sqf",([] call F_getNearestFob),-981,false,true,"","build_confirmed == 0"];
				_id_actions set [_idact_id, _idact];
			};
		} else {
			if ( _idact_num != -1 ) then {
				player removeAction _idact_num;
				_id_actions set [_idact_id, -1];
			};
		};

		// FOB Sign Actions
		if (!_near_lhd && _fobdistance < GRLIB_fob_range && cursorObject isKindof FOB_sign) then {
			if (count (actionIDs cursorObject) == 0) then {
				cursorObject addAction ["<t color='#FFFFFF'>" + "-= Hall of Fame =-" + "</t>",{([] call F_hof_msg) spawn BIS_fnc_dynamicText},"",999,true,true,"","GRLIB_player_is_menuok",5];
				cursorObject addAction ["<t color='#FFFFFF'>" + localize "STR_READ_ME" + "</t>",{createDialog "liberation_notice"},"",998,true,true,"","GRLIB_player_is_menuok",5];
				cursorObject addAction ["<t color='#FFFFFF'>" + localize "STR_TIPS" + "</t>",{createDialog "liberation_tips"},"",997,true,true,"","GRLIB_player_is_menuok",5];
			};
		};
	} else {
		{
			if (_x != -1) then {
				player removeAction _x;
				_id_actions set [_forEachIndex, -1];
			};
		} forEach _id_actions;
	};

	sleep 1;
};
