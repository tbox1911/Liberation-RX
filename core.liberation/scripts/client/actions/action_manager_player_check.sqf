GRLIB_checkAdmin = {
	(GRLIB_player_is_menuok && GRLIB_admin_menu && GRLIB_player_admin)
};

GRLIB_checkOperator = {
	(GRLIB_player_is_menuok && GRLIB_admin_menu && (GRLIB_player_admin || PAR_Grp_ID in GRLIB_whitelisted_moderators))
};

GRLIB_checkSquad = {
	(GRLIB_player_is_menuok && !isNil {player getVariable ["my_squad", nil]});
};

GRLIB_check_Dog = {
	(GRLIB_player_is_menuok && !isNil {player getVariable ["my_dog", nil]});
};

GRLIB_check_DogOnDuty = {
	private _my_dog = player getVariable ["my_dog", nil];
	if (isNil "_my_dog") exitWith { false };
	(GRLIB_player_is_menuok && !isNil {_my_dog getVariable ["do_find", nil]} || stopped _my_dog);
};

GRLIB_check_DogRelax = {
	private _my_dog = player getVariable ["my_dog", nil];
	if (isNil "_my_dog") exitWith { false };
	(GRLIB_player_is_menuok && isNil {_my_dog getVariable ["do_find", nil]} && !(stopped _my_dog));
};

GRLIB_check_DogClose = {
	private _my_dog = player getVariable ["my_dog", nil];
	if (isNil "_my_dog") exitWith { false };
	(GRLIB_player_is_menuok && player distance2D _my_dog < 2);
};

GRLIB_checkHalo = {
	(GRLIB_player_is_menuok && GRLIB_player_near_spawn && GRLIB_halo_param > 0)
};

GRLIB_checkRedeploy = {
	if (GRLIB_allow_redeploy == 0) exitWith { false };
	if (GRLIB_allow_redeploy == 1) exitWith { (GRLIB_player_is_menuok && GRLIB_player_near_spawn) };
	if (GRLIB_allow_redeploy == 2) exitWith { (GRLIB_player_is_menuok && GRLIB_player_near_base) };
};

GRLIB_checkSendAmmo = {
	private _near_atm = [player, "ATM", GRLIB_ActionDist_5, false] call F_check_near;
	(GRLIB_player_is_menuok && (GRLIB_player_near_base || _near_atm) && count (AllPlayers - (entities "HeadlessClient_F")) > 1)
};

GRLIB_checkSendFuel = {
	(GRLIB_player_is_menuok && GRLIB_player_near_base && count (AllPlayers - (entities "HeadlessClient_F")) > 1)
};

GRLIB_checkBuyFuel = {
	private _near_fuel = [player, "FUEL", GRLIB_ActionDist_10, false] call F_check_near;
	private _near_repair = [player, "REPAIR", GRLIB_ActionDist_5, false] call F_check_near;
	(GRLIB_player_is_menuok && (_near_fuel || _near_repair))
};

GRLIB_checkHeal = {
	(GRLIB_player_is_menuok && GRLIB_player_near_base && damage player >= 0.02)
};

GRLIB_checkAirDrop = {
	(GRLIB_player_is_menuok && GRLIB_air_support && GRLIB_player_fobdistance >= (2 * GRLIB_fob_range) && !GRLIB_player_near_lhd)
};

GRLIB_checkArsenal = {
	if (GRLIB_filter_arsenal == 4 || GRLIB_arsenal_open) exitWith { false };
	private _near_arsenal = [player, "ARSENAL", GRLIB_ActionDist_5, false] call F_check_near;
	private _mode1 = (GRLIB_enable_arsenal == 1 && (_near_arsenal || GRLIB_player_near_base));
	private _mode2 = (GRLIB_enable_arsenal == 2 && GRLIB_player_near_base);
	(GRLIB_player_is_menuok && (_mode1 || _mode2))
};

GRLIB_checkArsenalPerso = {
	private _near_arsenal = [player, "ARSENAL", GRLIB_ActionDist_5, false] call F_check_near;
	(GRLIB_player_is_menuok && GRLIB_filter_arsenal == 4 && _near_arsenal)
};

GRLIB_checkGarage = {
	(GRLIB_player_is_menuok && GRLIB_garage_size > 0 && !(surfaceIsWater getPos player) && GRLIB_player_fobdistance > 15 && GRLIB_player_near_fob && !GRLIB_player_near_outpost && GRLIB_player_score >= GRLIB_perm_inf)
};

GRLIB_checkBuild = {
	(GRLIB_player_is_menuok && GRLIB_player_near_fob && ([player, 3] call fetch_permission) && side group player == GRLIB_side_friendly)
};

GRLIB_checkBuildTrench = {
	if (count blufor_trenches == 0) exitWith { false };
	if (GRLIB_current_trenches > 4) exitWith { false };
	(GRLIB_player_is_menuok && !(surfaceIsWater getPos player) && !GRLIB_player_near_fob && !GRLIB_player_near_lhd && ([player, 3] call fetch_permission))
};

GRLIB_checkBuildFOB = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && (GRLIB_player_fobdistance > GRLIB_sector_size && !GRLIB_player_near_lhd) && !(_target getVariable ['box_in_use', false]))
};

GRLIB_checkBuildFOBWater = {
	if (GRLIB_naval_type == 0) exitWith { false };
	(alive player && surfaceIsWater getPos player && (GRLIB_player_fobdistance > GRLIB_sector_size && !GRLIB_player_near_lhd) && (typeOf (vehicle player) == FOB_boat_typename) && driver (vehicle player) == player && round (speed vehicle player) == 0 && !((vehicle player) getVariable ["box_in_use", false]))
};

GRLIB_checkBuildDef = {
	params ["_target"];
	(GRLIB_player_is_menuok && alive _target && (GRLIB_player_owner_fob || _target getVariable ["GRLIB_vehicle_owner", ""] == "lrx") && ([] call F_getFobType) in [0,1])
};

GRLIB_checkSquadMgmt = {
	(GRLIB_player_is_menuok && (leader group player == player) && (count units group player > 1) && (GRLIB_player_near_fob || GRLIB_player_near_lhd))
};

GRLIB_checkSecObj = {
	(GRLIB_player_is_menuok && (GRLIB_player_fobdistance <= GRLIB_ActionDist_5) && (!GRLIB_player_near_outpost) && (GRLIB_player_score >= GRLIB_perm_air || GRLIB_player_admin))
};

GRLIB_checkOnboardShip = {
	(alive player && ((surfaceIsWater GRLIB_player_nearest_fob && GRLIB_player_near_fob) || (GRLIB_player_near_lhd && surfaceIsWater getPos lhd)) && (getPosASL player select 2) < 2)
};

GRLIB_checkPackFOB = {
	(GRLIB_player_is_menuok && GRLIB_player_fobdistance <= GRLIB_ActionDist_10 && (!GRLIB_player_near_outpost) && (GRLIB_player_owner_fob || GRLIB_player_admin))
};

GRLIB_checkUnpackBeacon = {
	(GRLIB_player_is_menuok && !GRLIB_player_near_lhd && (backpackContainer player) getVariable ["GRLIB_mobile_respawn_bag", false])
};

GRLIB_checkDelOutpost = {
	(GRLIB_player_is_menuok && GRLIB_player_fobdistance <= GRLIB_ActionDist_10 && GRLIB_player_near_outpost && (GRLIB_player_owner_fob || GRLIB_player_admin))
};

GRLIB_checkUpgradeOutpost = {
	(GRLIB_player_is_menuok && GRLIB_player_fobdistance <= GRLIB_ActionDist_10 && GRLIB_player_near_outpost && ((GRLIB_player_owner_fob && GRLIB_player_score >= GRLIB_perm_max) || GRLIB_player_admin))
};

GRLIB_checkSpeak = {
	params ["_target"];
	(GRLIB_player_is_menuok && alive _target && _target getVariable ['GRLIB_can_speak', false] && side group _target != GRLIB_side_enemy)
};

GRLIB_checkCapture = {
	params ["_target"];
	(GRLIB_player_is_menuok && alive _target && _target getVariable ['GRLIB_is_prisoner', false])
};

GRLIB_checkRemoveHelipad = {
	(
		GRLIB_player_is_menuok && GRLIB_player_score >= GRLIB_perm_inf && GRLIB_player_near_fob &&
		({ getObjectType _x >= 8 && player distance2D _x <= GRLIB_ActionDist_3 } count (nearestObjects [player, ["Helipad_base_F"], 20]) >= 1)
	);
};

GRLIB_checkVehicleSupport = { (count GRLIB_vehicle_need_support > 0) };

GRLIB_checkEjectCrew = {
	params ["_target"];
	if (!alive _target || captive _target) exitWith { false };
	private _vehicle = objectParent _target;
	if (isNull _vehicle) exitWith { false };
	if (count crew _vehicle == 1) exitWith { false };
	if (_vehicle isKindOf "ParachuteBase") exitWith { false };
	if !([_target, _vehicle] call is_owner) exitWith { false };
	if (_vehicle isKindOf "Air") exitWith { true };
	((getPosATL _vehicle select 2 <= 10) && (abs (speed vehicle _vehicle) < 5))
};

GRLIB_checkOnboardCrew = {
	params ["_target"];
	if (!alive _target || captive _target) exitWith { false };
	private _vehicle = objectParent _target;
	if (isNull _vehicle) exitWith { false };
	if (getPos _vehicle select 2 >= 5) exitWith { false };
	if (abs (speed vehicle _vehicle) >= 5) exitWith { false };
	if (_vehicle isKindOf "ParachuteBase") exitWith { false };
	if !([_target, _vehicle] call is_owner) exitWith { false };
	private _onboard_list = { !isPlayer _x && isNull objectParent _x && _x distance2D player <= 30 } count (units player);
	if (_onboard_list == 0) exitWith { false };
	true;
}