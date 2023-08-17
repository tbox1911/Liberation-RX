GRLIB_checkAdmin = {
	(GRLIB_player_is_menuok && ([] call is_admin || getPlayerUID player in GRLIB_whitelisted_moderators) && GRLIB_admin_menu)
};

GRLIB_checkSquad = {
	(GRLIB_player_is_menuok && !isNil {player getVariable ["my_squad", nil]});
};

GRLIB_check_Dog = {
	(GRLIB_player_is_menuok && !isNil {player getVariable ["my_dog", nil]});
};

GRLIB_check_DogOnDuty = {
	private _my_dog = player getVariable ["my_dog", nil];
	(!isNil {_my_dog getVariable ["do_find", nil]} || stopped _my_dog);
};

GRLIB_check_DogRelax = {
	private _my_dog = player getVariable ["my_dog", nil];
	(isNil {_my_dog getVariable ["do_find", nil]} && !(stopped _my_dog));
};

GRLIB_checkHalo = {
	(GRLIB_player_is_menuok && (GRLIB_player_near_spawn || GRLIB_player_near_lhd) && GRLIB_halo_param > 0)
};

GRLIB_checkRedeploy = {
	private _ret = false;
	if (GRLIB_allow_redeploy == 0) then {
		_ret = (GRLIB_player_is_menuok && (GRLIB_player_fobdistance < GRLIB_ActionDist_10 || GRLIB_player_near_lhd));
	} else {
		_ret = (GRLIB_player_is_menuok && (GRLIB_player_near_spawn || GRLIB_player_near_lhd));
	};
	_ret;
};

GRLIB_checkSendAmmo = {
	private _near_atm = [player, "ATM", GRLIB_ActionDist_5, true] call F_check_near;
	(GRLIB_player_is_menuok && ( GRLIB_player_near_lhd || _near_atm ) && count (AllPlayers - (entities "HeadlessClient_F")) > 1)
};

GRLIB_checkFuel = {
	private _near_fuel = [player, "FUEL", GRLIB_ActionDist_10, false] call F_check_near;
	private _near_repair = [player, "REPAIR", GRLIB_ActionDist_5, false] call F_check_near;
	(GRLIB_player_is_menuok && (_near_fuel || _near_repair))
};

GRLIB_checkHeal = {
	(GRLIB_player_is_menuok && (GRLIB_player_fobdistance < GRLIB_ActionDist_15 || GRLIB_player_near_lhd) && damage player >= 0.02)
};

GRLIB_checkLeader = {
	(!(isPlayer (leader (group player))) && (local (group player)))
};

GRLIB_checkAirDrop = {
	(GRLIB_player_is_menuok && (player distance2D ([] call F_getNearestFob)) >= (2 * GRLIB_fob_range) && !GRLIB_player_near_lhd)
};

GRLIB_checkArsenal = {
	private _near_arsenal = [player, "ARSENAL", GRLIB_ActionDist_15, true] call F_check_near;
	private _mode1 = (GRLIB_enable_arsenal == 1 && (_near_arsenal || GRLIB_player_near_lhd));
	private _mode2 = (GRLIB_enable_arsenal == 2 && (GRLIB_player_fobdistance < GRLIB_ActionDist_15 || GRLIB_player_near_lhd));
	(GRLIB_player_is_menuok && (_mode1 || _mode2) && LRX_arsenal_init_done)
};

GRLIB_checkGarage = {
	(GRLIB_player_is_menuok && GRLIB_player_fobdistance > 15 && GRLIB_player_fobdistance < GRLIB_fob_range && !GRLIB_player_near_outpost && !GRLIB_player_near_lhd && GRLIB_player_score >= GRLIB_perm_inf)
};

GRLIB_checkBuild = {
	(GRLIB_player_is_menuok && GRLIB_player_fobdistance < GRLIB_fob_range && !GRLIB_player_near_lhd && (([player, 3] call fetch_permission) || GRLIB_player_admin))
};

GRLIB_checkSquadMgmt = {
	(GRLIB_player_is_menuok && (leader group player == player) && (count units group player > 1) && (GRLIB_player_fobdistance < GRLIB_fob_range || GRLIB_player_near_lhd))
};

GRLIB_checkCommander = {
	(GRLIB_player_is_menuok && GRLIB_player_admin && GRLIB_permissions_param)
};

GRLIB_checkSecObj = {
	(GRLIB_player_is_menuok && (GRLIB_player_fobdistance <= GRLIB_ActionDist_5) && (!GRLIB_player_near_outpost) && (GRLIB_player_score >= GRLIB_perm_air || GRLIB_player_admin))
};

GRLIB_checkBuildFOB = {
	(GRLIB_player_is_menuok && (GRLIB_player_fobdistance > GRLIB_sector_size && !GRLIB_player_near_lhd) && (player distance2D cursorObject < GRLIB_ActionDist_5) && (typeOf cursorObject in [FOB_box_typename, FOB_truck_typename]) && !(cursorObject getVariable ['box_in_use', false]))
};

GRLIB_checkPackFOB = {
	(GRLIB_player_is_menuok && (GRLIB_player_fobdistance < GRLIB_ActionDist_10 && !GRLIB_player_near_lhd) && (!GRLIB_player_near_outpost) && ((GRLIB_player_score >= GRLIB_perm_max) || GRLIB_player_admin))
};

GRLIB_checkPackBeacon = {
	(GRLIB_player_is_menuok && !GRLIB_player_near_lhd && (player distance2D cursorObject < GRLIB_ActionDist_3) && (typeOf cursorObject == mobile_respawn) && ([player, cursorObject] call is_owner) && !(cursorObject getVariable ['tent_in_use', false]))
};

GRLIB_checkUnpackBeacon = {
	(GRLIB_player_is_menuok && !GRLIB_player_near_lhd && (backpackContainer player) getVariable ["GRLIB_mobile_respawn_bag", false])
};

GRLIB_checkBuildOutpost = {
	(GRLIB_player_is_menuok && (GRLIB_player_fobdistance > GRLIB_sector_size && !GRLIB_player_near_lhd) && (player distance2D cursorObject < GRLIB_ActionDist_5) && (typeOf cursorObject == FOB_box_outpost) && !(cursorObject getVariable ['box_in_use', false]))
};

GRLIB_checkDelOutpost = {
	(GRLIB_player_is_menuok && (GRLIB_player_fobdistance < GRLIB_ActionDist_10 && !GRLIB_player_near_lhd) && GRLIB_player_near_outpost && (GRLIB_player_owner_fob || GRLIB_player_admin))
};

GRLIB_checkUpgradeOutpost = {
	(GRLIB_player_is_menuok && (GRLIB_player_fobdistance < GRLIB_ActionDist_10 && !GRLIB_player_near_lhd) && GRLIB_player_near_outpost && ((GRLIB_player_owner_fob && (GRLIB_player_score >= GRLIB_perm_max)) || GRLIB_player_admin))
};
