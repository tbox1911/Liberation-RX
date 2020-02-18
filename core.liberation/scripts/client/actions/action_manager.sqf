
private [ "_idact_build","_idact_arsenal", "_idact_redeploy", "_idact_tutorial",
		  "_distfob", "_distarsenal","_distspawn","_distredeploy", "_idact_commander",
		  "_idact_halo", "_idact_heal", "_idact_lead","_idact_drop", "_idact_squad",
		  "_idact_send", "_idact_packfob", "_idact_unpackfob", "_idact_packtent", "_idact_unpacktent",
		  "_idact_dog_del", "_idact_dog_find", "_idact_dog_recall"];

_idact_build = -1; _idact_arsenal = -1; _idact_redeploy = -1; _idact_tutorial = -1; _idact_squad = -1;
_idact_commander = -1; _idact_repackage = -1; _idact_halo = -1; _idact_heal = -1; _idact_lead = -1;
_idact_drop = -1; _idact_send = -1; _idact_secondary = -1; _idact_packfob = -1; _idact_unpackfob = -1;
_idact_packtent = -1; _idact_unpacktent = -1; _idact_buyfuel = -1; _idact_dog_del = -1; _idact_dog_find = -1;
_idact_dog_recall = -1;

_distfob = 100;
_distarsenal = 10;
_distspawn = 10;
_distredeploy = 20;
_distveh = 15;
_distvehclose = 5;

is_DogOnDuty = {
	private _ret = false;
	private _my_dog = player getVariable ["my_dog", nil];

	if (!isNil {_my_dog getVariable ["do_find", nil]}) then { _ret = true };
	_ret;
};

waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };
waituntil {sleep 1; GRLIB_player_spawned; (player getVariable ["GRLIB_score_set", 0] == 1)};

while { true } do {
	_fobdistance = round (player distance2D ([] call F_getNearestFob));
	_near_arsenal = (player nearEntities [Arsenal_typename, _distarsenal]) + (player nearObjects [FOB_typename, _distredeploy]);
	_near_tent = nearestObjects [player, ["Land_TentDome_F"], _distvehclose];
	_near_spawn = (player nearEntities [[Respawn_truck_typename, huron_typename], _distspawn]) + _near_tent;
	_near_fobbox = player nearEntities [[FOB_box_typename, FOB_truck_typename], _distspawn];
	_near_fuel = [player, "FUEL", _distvehclose, false] call F_check_near;
	_near_atm = [player, "ATM", _distvehclose, true] call F_check_near;
	_my_dog = player getVariable ["my_dog", objNull];

	// Tuto
	if ( [] call is_menuok && (player distance lhd) <= 200 ) then {
		if ( _idact_tutorial == -1 ) then {
			_idact_tutorial = player addAction ["<t color='#80FF80'>" + localize "STR_TUTO_ACTION" + "</t>","howtoplay = 1","",-740,false,true,"",""];
		};
	} else {
		if ( _idact_tutorial != -1 ) then {
			player removeAction _idact_tutorial;
			_idact_tutorial = -1;
		};
	};

	// Dog - Find
	if ( [] call is_menuok && !isNull _my_dog ) then {
		if ( _idact_dog_find == -1 ) then {
			_icon = (getText (configFile >> "CfgVehicleIcons" >> "iconAnimal"));
			_idact_dog_find = player addAction ["<t color='#80FF80'>" + "-- DOG FIND."+ "</t> <img size='1' image='" + _icon + "'/>","scripts\client\actions\do_dog.sqf","find",-640,false,true,"","!call is_DogOnDuty"];
		};
	} else {
		if ( _idact_dog_find != -1 ) then {
			player removeAction _idact_dog_find;
			_idact_dog_find = -1;
		};
	};

	// Dog - Recall
	if ( [] call is_menuok && !isNull _my_dog ) then {
		if ( _idact_dog_recall == -1 ) then {
			_icon = (getText (configFile >> "CfgVehicleIcons" >> "iconAnimal"));
			_idact_dog_recall = player addAction ["<t color='#80FF80'>" + "-- DOG RECALL."+ "</t> <img size='1' image='" + _icon + "'/>","scripts\client\actions\do_dog.sqf","recall",-640,false,true,"","call is_DogOnDuty"];
		};
	} else {
		if ( _idact_dog_recall != -1 ) then {
			player removeAction _idact_dog_recall;
			_idact_dog_recall = -1;
		};
	};

	// Dog - Delete
	if ( [] call is_menuok && !isNull _my_dog ) then {
		if ( _idact_dog_del == -1 ) then {
			_icon = (getText (configFile >> "CfgVehicleIcons" >> "iconAnimal"));
			_idact_dog_del = player addAction ["<t color='#FF8080'>" + "-- DOG DISMISS." + "</t> <img size='1' image='" + _icon + "'/>","scripts\client\actions\do_dog.sqf","del",-641,false,true,"",""];
		};
	} else {
		if ( _idact_dog_del != -1 ) then {
			player removeAction _idact_dog_del;
			_idact_dog_del = -1;
		};
	};

	// Halo Jump
	if ( [] call is_menuok && (_fobdistance < _distredeploy || count _near_spawn != 0 || (player distance lhd) <= 200) && GRLIB_halo_param > 0) then {
		if ( _idact_halo == -1 ) then {
			_idact_halo = player addAction ["<t color='#80FF80'>" + localize "STR_HALO_ACTION" + "</t> <img size='1' image='res\ui_redeploy.paa'/>","scripts\client\spawn\do_halo.sqf","",-749,false,true,"","build_confirmed == 0"];
		};
	} else {
		if ( _idact_halo != -1 ) then {
			player removeAction _idact_halo;
			_idact_halo = -1;
		};
	};

	// Send Ammo
	if  ([] call is_menuok && score player > 20 && ( (player distance lhd) <= 200 || _near_atm ) ) then {
		if ( _idact_send == -1 ) then {
			_idact_send = player addAction ["<t color='#80FF00'>-- SEND AMMO</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\misc\send_ammo.sqf","",-981,true,true,"","build_confirmed == 0"];
		};
	} else {
		if ( _idact_send != -1 ) then {
			player removeAction _idact_send;
			_idact_send = -1;
		};
	};

	// Fuel
	if ( [] call is_menuok && (player distance lhd) >= 1000 && _near_fuel ) then {
		if ( _idact_buyfuel == -1 ) then {
			_idact_buyfuel = player addAction ["<t color='#00F080'>-- BUY FUEL</t> <img size='1' image='R3F_LOG\icons\r3f_fuel.paa'/>", "scripts\client\actions\do_buyfuel.sqf","",-900,true,true,"",""];
		};
	} else {
		if ( _idact_buyfuel != -1 ) then {
			player removeAction _idact_buyfuel;
			_idact_buyfuel = -1;
		};
	};

	// Heal Self
	if ( [] call is_menuok && (_fobdistance < _distarsenal || (player distance lhd) <= 200) && (damage player) >= 0.023) then {
		if ( _idact_heal == -1 ) then {
			_idact_heal = player addAction ["<img size='1' image='\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca'/>", { (_this select 1) playMove "AinvPknlMstpSlayWnonDnon_medic"; (_this select 1) setDamage 0;},"",999,true,true,"", ""];
		};
	} else {
		if ( _idact_heal != -1 ) then {
			player removeAction _idact_heal;
			_idact_heal = -1;
		};
	};

	// Take Leadrship
	if ( [] call is_menuok && !(isPlayer (leader (group player))) && (local (group player)) ) then {
		if ( _idact_lead == -1 ) then {
			_idact_lead = player addAction ["<t color='#80FF80'>-- TAKE LEADRSHIP</t> <img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/>", {(group player) selectLeader player}, [],0,true,true,"", "build_confirmed == 0"];
		};
	} else {
		if ( _idact_lead != -1 ) then {
			player removeAction _idact_lead;
			_idact_lead = -1;
		};
	};

	// Air Drop
	if ( [] call is_menuok && (player distance ([] call F_getNearestFob)) >= (2 * GRLIB_fob_range) && (player distance lhd >= 1000) ) then {
		if ( _idact_drop == -1 ) then {
			_idact_drop = player addAction ["<t color='#00F0F0'>-- AIR SUPPORT --</t> <img size='1' image='R3F_LOG\icons\r3f_drop.paa'/>","scripts\client\misc\drop_support.sqf","",-980,false,true];
		};
	} else {
		if ( _idact_drop != -1 ) then {
			player removeAction _idact_drop;
			_idact_drop = -1;
		};
	};

	// Redeploy
	if ( [] call is_menuok && (_fobdistance < _distredeploy || count _near_spawn != 0 || (player distance lhd) <= 200) ) then {
		if ( _idact_redeploy == -1 ) then {
			_idact_redeploy = player addAction ["<t color='#80FF80'>" + localize "STR_DEPLOY_ACTION" + "</t> <img size='1' image='res\ui_redeploy.paa'/>","scripts\client\actions\do_redeploy.sqf","",-750,false,true,"","build_confirmed == 0"];
		};
	} else {
		if ( _idact_redeploy != -1 ) then {
			player removeAction _idact_redeploy;
			_idact_redeploy = -1;
		};
	};

	// Arsenal
	if ( [] call is_menuok && ( count _near_arsenal != 0 || (player distance lhd) <= 200) ) then {
		if (_idact_arsenal == -1) then {
			_idact_arsenal = player addAction ["<t color='#FFFF00'>" + localize "STR_ARSENAL_ACTION" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\open_arsenal.sqf","",-980,true,true,"","build_confirmed == 0"];
		};
	} else {
		if ( _idact_arsenal != -1 ) then {
			player removeAction _idact_arsenal;
			_idact_arsenal = -1;
		};
	};

	// Build Menu
	if ( [] call is_menuok && _fobdistance < _distfob && (player distance lhd) >= 1000 && ( ([player, 3] call fetch_permission) || (player == ([] call F_getCommander) || [] call F_isAdmin)) ) then {
		if ( _idact_build == -1 ) then {
			_idact_build = player addAction ["<t color='#FFFF00'>" + localize "STR_BUILD_ACTION" + "</t> <img size='1' image='res\ui_build.paa'/>","scripts\client\build\open_build_menu.sqf","",-985,false,true,"","build_confirmed == 0"];
		};
	} else {
		if ( _idact_build != -1 ) then {
			player removeAction _idact_build;
			_idact_build = -1;
		};
	};

	// Squad Management
	if ( [] call is_menuok && (leader group player == player) && (count units group player > 1) ) then {
		if ( _idact_squad == -1 ) then {
			_idact_squad = player addAction ["<t color='#80FF80'>" + localize "STR_SQUAD_MANAGEMENT_ACTION" + "</t> <img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/>","scripts\client\ui\squad_management.sqf","",-760,false,true,"","build_confirmed == 0"];
		};
	} else {
		if ( _idact_squad != -1 ) then {
			player removeAction _idact_squad;
			_idact_squad = -1;
		};
	};

	// Commander Menu
	if ( [] call is_menuok && ( player == ( [] call F_getCommander ) || [] call F_isAdmin ) && GRLIB_permissions_param ) then {
		if ( _idact_commander == -1 ) then {
			_idact_commander = player addAction ["<t color='#FF8000'>" + localize "STR_COMMANDER_ACTION" + "</t> <img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/>","scripts\client\commander\open_permissions.sqf","",-996,false,true,"","build_confirmed == 0"];
		};
	} else {
		if ( _idact_commander != -1 ) then {
			player removeAction _idact_commander;
			_idact_commander = -1;
		};
	};

	// Secondary Objectives
	if ( [] call is_menuok && count GRLIB_all_fobs > 0 && ( GRLIB_endgame == 0 ) && (_fobdistance < _distredeploy || (player distance lhd) <= 200) && (score player >= GRLIB_perm_air ||  player == ( [] call F_getCommander ) || [] call F_isAdmin) ) then {
		if ( _idact_secondary == -1 ) then {
			_idact_secondary = player addAction ["<t color='#FFFF00'>" + localize "STR_SECONDARY_OBJECTIVES" + "</t>","scripts\client\ui\secondary_ui.sqf","",-995,false,true,"","build_confirmed == 0"];
		};
	} else {
		if ( _idact_secondary != -1 ) then {
			player removeAction _idact_secondary;
			_idact_secondary = -1;
		};
	};

	// Pack FOB
	if ( [] call is_menuok && (_fobdistance < _distarsenal && (player distance lhd) >= 1000) && ( (score player >= GRLIB_perm_max) || (player == ( [] call F_getCommander ) || [] call F_isAdmin) )) then {
		if ( _idact_packfob == -1 ) then {
			_idact_packfob = player addAction ["<t color='#FF6F00'>" + localize "STR_FOB_REPACKAGE" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_repackage_fob.sqf",([] call F_getNearestFob),-981,false,true,"","build_confirmed == 0 && !(cursorObject getVariable ['fob_in_use', false])"];
		};
	} else {
		if ( _idact_packfob != -1 ) then {
			player removeAction _idact_packfob;
			_idact_packfob = -1;
		};
	};

	// Build FOB
	if ( [] call is_menuok && (_fobdistance > GRLIB_sector_size && (player distance lhd) >= 1000) && cursorObject in _near_fobbox ) then {
		if ( _idact_unpackfob == -1 ) then {
			_idact_unpackfob = player addAction ["<t color='#FF6F00'>" + localize "STR_FOB_ACTION" + "</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_build_fob.sqf",cursorObject,-981,false,true,"","build_confirmed == 0 && !(cursorObject getVariable ['box_in_use', false])"];
		};
	} else {
		if ( _idact_unpackfob != -1 ) then {
			player removeAction _idact_unpackfob;
			_idact_unpackfob = -1;
		};
	};

	// Pack Beacon
	if ( [] call is_menuok && (player distance lhd) >= 1000 && cursorObject in _near_tent ) then {
		if ( _idact_packtent == -1 ) then {
			_idact_packtent = player addAction ["<t color='#FFFF00'>-- PACK BEACON</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_beacon_pack.sqf",cursorObject,-950,true,true,"","!(cursorObject getVariable ['tent_in_use', false])"];
		};
	} else {
		if ( _idact_packtent != -1 ) then {
			player removeAction _idact_packtent;
			_idact_packtent = -1;
		};
	};

	// UnPack Beacon
	if ( [] call is_menuok && (player distance lhd) >= 1000 && backpack player == 'B_Kitbag_Base' ) then {
		if ( _idact_unpacktent == -1 ) then {
			_idact_unpacktent = player addAction ["<t color='#FFFF00'>-- UNPACK BEACON</t> <img size='1' image='res\ui_deployfob.paa'/>","scripts\client\actions\do_beacon_unpack.sqf","",-950,true,true,"",""];
		};
	} else {
		if ( _idact_unpacktent != -1 ) then {
			player removeAction _idact_unpacktent;
			_idact_unpacktent = -1;
		};
	};

	sleep 1;
};
