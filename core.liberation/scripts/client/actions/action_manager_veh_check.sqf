GRLIB_checkAction_Lock = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && count (crew _target) == 0 && [_unit, _target] call is_owner && locked _target < 2 && GRLIB_vehicle_lock)
};

GRLIB_checkAction_Unlock = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && [_unit, _target] call is_owner && locked _target == 2 && GRLIB_vehicle_lock)
};

GRLIB_checkAction_Abandon = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && [_unit, _target] call is_owner && locked _target == 2 && GRLIB_vehicle_lock)
};

GRLIB_checkAction_Paint = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && ([_target, 'REPAINT', 30] call F_check_near || [_target, 'FOB', GRLIB_fob_range] call F_check_near) && [_unit, _target] call is_owner && locked _target < 2)
};

GRLIB_checkAction_Eject = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && !(typeOf _target in uavs) && count (crew _target) > 0 && [_unit, _target] call is_owner)
};

GRLIB_checkAction_Unload = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && ([_unit, _target] call is_owner || [_target] call is_public) && locked _target < 2 && isNull (_target getVariable ['R3F_LOG_remorque', objNull]) && count (_target getVariable ['GRLIB_ammo_truck_load', []]) > 0)
};

GRLIB_checkAction_Flip = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && !(typeOf _target in uavs) && side group _target != GRLIB_side_enemy && locked _target < 2)
};

GRLIB_checkAction_DeFuel = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && [_unit, _target] call is_owner && locked _target < 2 && fuel _target >= 0.25)
};

GRLIB_checkAction_ReFuel = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && [_target, 'REFUEL', 15, false] call F_check_near && locked _target < 2 && fuel _target <= 0.75)
};

GRLIB_checkAction_Halo = {
	params ["_target", "_unit"];
	private _not_tracted = (isNull (_target getVariable ["R3F_LOG_est_transporte_par", objNull]));
	private _not_tractor = (isNull (_target getVariable ["R3F_LOG_remorque", objNull]));
	(GRLIB_player_is_menuok && alive _target && [_unit, _target] call is_owner && [_target, 'FOB', GRLIB_fob_range] call F_check_near && ([_target, ['LandVehicle','Ship']] call F_itemIsInClass) && _not_tracted && _not_tractor && locked _target < 2)
};

GRLIB_checkAction_Wreck = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && !(_target getVariable ['wreck_in_use', false]) && ({alive _x} count (crew _target) == 0) && !(player getVariable ['salvage_wreck', false]))
};

GRLIB_checkAction_Box = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && [] call is_neartransport && [_unit, _target] call is_owner && !(_target getVariable ['R3F_LOG_disabled', false]))
};

GRLIB_checkAction_SendArsenal = {
	params ["_target", "_unit"];
	(GRLIB_filter_arsenal == 4 && loadAbs _target > 0 && [_unit, "ARSENAL", GRLIB_ActionDist_10, false] call F_check_near)
};