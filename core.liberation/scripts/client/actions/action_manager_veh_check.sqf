GRLIB_DALE_actionCond = {
	params ["_target", "_unit"];
    ((round (getPos _target select 2) <= 0) && (_unit == driver _target) && (speed vehicle _target < 1) && GRLIB_player_near_reammo)
};

GRLIB_checkAction_Lock = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && count (crew _target) == 0 && (GRLIB_permission_vehicles && [_unit, _target] call is_owner) && locked _target < 2 && GRLIB_vehicle_lock)
};

GRLIB_checkAction_Unlock = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && (!GRLIB_permission_vehicles || [_unit, _target] call is_owner) && locked _target == 2 && isNull (attachedTo _target) && GRLIB_vehicle_lock)
};

GRLIB_checkAction_Abandon = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && (GRLIB_permission_vehicles && [_unit, _target] call is_owner) && locked _target == 2 && isNull (attachedTo _target) && GRLIB_vehicle_lock)
};

GRLIB_checkAction_Paint = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && (GRLIB_player_near_repaint || GRLIB_player_near_fob) && [_unit, _target] call is_owner && locked _target < 2)
};

GRLIB_checkAction_Flip = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && side group _target != GRLIB_side_enemy && locked _target < 2 && !(typeOf _target in uavs_vehicles) && isNull (attachedTo _target))
};

GRLIB_checkAction_DeFuel = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && [_unit, _target] call is_owner && locked _target < 2 && fuel _target >= 0.25 && !(typeOf _target in uavs_vehicles))
};

GRLIB_checkAction_ReFuel = {
	params ["_target", "_unit"];
	private _need_fuel = (fuel _target <= 0.75);
	if (!_need_fuel) exitWith { false };
	(GRLIB_player_is_menuok && alive _target && GRLIB_player_near_fuelbarrel)
};

GRLIB_checkAction_Repair = {
	params ["_target", "_unit"];
	private _need_repair = ([_target] call F_vehicleNeedRepair);
	if (!_need_repair) exitWith { false };
	(GRLIB_player_is_menuok && alive _target && GRLIB_player_near_repairbox)
};

GRLIB_checkAction_Halo = {
	params ["_target", "_unit"];
	private _not_tracted = (isNull (_target getVariable ["R3F_LOG_est_transporte_par", objNull]));
	private _not_tractor = (isNull (_target getVariable ["R3F_LOG_remorque", objNull]));
	(GRLIB_player_is_menuok && alive _target && [_unit, _target] call is_owner && GRLIB_player_near_fob && _not_tracted && _not_tractor && locked _target < 2)
};

GRLIB_checkAction_Wreck = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && !(_target getVariable ["wreck_in_use", false]) && ({alive _x} count (crew _target) == 0) && !(player getVariable ["salvage_wreck", false]))
};

GRLIB_checkAction_SendArsenal = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && GRLIB_filter_arsenal == 4 && alive _target && [_unit, _target] call is_owner && loadAbs _target > 0 && [_unit, "ARSENAL", GRLIB_ActionDist_10, false] call F_check_near)
};

GRLIB_checkAction_Pickup_Weapons = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && [_unit, _target] call is_owner && load _target < 0.8 && !(_target getVariable ["R3F_LOG_disabled", false]))
};

GRLIB_checkAction_UnpackInventory = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && [_unit, _target] call is_owner && load _target > 0.2)
};

GRLIB_checkAction_Speak = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && _target getVariable ["GRLIB_civ_incd", 0] > 0)
};

GRLIB_checkAction_Sticky = {
	params ["_target", "_unit"];
	if (count attachedObjects _target > 0) exitWith { false };
	private _explosive = false;
	{
		if (_x in sticky_bombs_typename) exitWith { _explosive = true };
	} forEach (vestItems _unit + backpackItems _unit);
	(GRLIB_player_is_menuok && !GRLIB_player_near_fob && alive _target && _explosive && [_unit, _target] call is_owner )
};

GRLIB_checkPackBeacon = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && [_unit, _target] call is_owner && !(_target getVariable ["tent_in_use", false]))
};

GRLIB_checkAction_LockWall = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && GRLIB_player_near_fob && PAR_Grp_ID == [GRLIB_player_nearest_fob] call F_getFobOwner && !(_target getVariable ["R3F_LOG_disabled", false]) && (typeOf _target) in all_buildings_classnames)
};
