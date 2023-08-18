GRLIB_checkAction_Lock = {
	params ["_target", "_unit"];
	([_target] call is_menuok_veh && (count (crew _target) == 0 || typeOf _target in uavs) && [_unit, _target] call is_owner && locked _target < 2 && GRLIB_vehicle_lock)
};

GRLIB_checkAction_Unlock = {
	params ["_target", "_unit"];
	([_target] call is_menuok_veh && [_unit, _target] call is_owner && locked _target == 2 && GRLIB_vehicle_lock)
};

GRLIB_checkAction_Abandon = {
	params ["_target", "_unit"];
	([_target] call is_menuok_veh && [_unit, _target] call is_owner && locked _target == 2 && GRLIB_vehicle_lock)
};

GRLIB_checkAction_Paint = {
	params ["_target", "_unit"];
	([_target] call is_menuok_veh && ([_target, 'REPAINT', 30] call F_check_near || [_target, 'FOB', GRLIB_fob_range] call F_check_near) && [_unit, _target] call is_owner && locked _target < 2)
};

GRLIB_checkAction_Eject = {
	params ["_target", "_unit"];
	([_target] call is_menuok_veh && !(typeOf _target in uavs) && count (crew _target) > 0 && [_unit, _target] call is_owner && vehicle _unit == _unit)
};

GRLIB_checkAction_Unload = {
	params ["_target", "_unit"];
	([_target] call is_menuok_veh && ([_unit, _target] call is_owner || [_target] call is_public) && locked _target < 2 && isNull (_target getVariable ['R3F_LOG_remorque', objNull]) && count (_target getVariable ['GRLIB_ammo_truck_load', []]) > 0)
};

GRLIB_checkAction_Flip = {
	params ["_target", "_unit"];
	([_target] call is_menuok_veh && !(typeOf _target in uavs) && side group _target != GRLIB_side_enemy && locked _target < 2)
};

GRLIB_checkAction_DeFuel = {
	params ["_target", "_unit"];
	([_target] call is_menuok_veh && [_unit, _target] call is_owner && locked _target < 2 && fuel _target >= 0.25)
};

GRLIB_checkAction_ReFuel = {
	params ["_target", "_unit"];
	([_target] call is_menuok_veh && [_target, 'REFUEL', 15, false] call F_check_near && locked _target < 2 && fuel _target <= 0.75)
};

GRLIB_checkAction_Halo = {
	params ["_target", "_unit"];
	([_target] call is_menuok_veh && count (_target getVariable ["GRLIB_ammo_truck_load", []]) == 0 && [_unit, _target] call is_owner && [_target, 'FOB', GRLIB_fob_range] call F_check_near && ([_target, ['LandVehicle','Ship']] call F_itemIsInClass) && locked _target < 2)
};

GRLIB_checkAction_Wreck = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && !(_target getVariable ['wreck_in_use', false]) && !(player getVariable ['salvage_wreck', false]))
};

GRLIB_checkAction_Box = {
	params ["_target", "_unit"];
	([_target] call is_menuok_veh && [] call is_neartransport && [_unit, _target] call is_owner && !(_target getVariable ['R3F_LOG_disabled', false]))
};
