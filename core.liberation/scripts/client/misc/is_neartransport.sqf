private _neartruck = (player nearEntities [transport_vehicles, 20]) select {
	(_x distance2D lhd > GRLIB_fob_range) &&
	([player, _x] call is_owner || [_x] call is_public) &&
	!(_x getVariable ['R3F_LOG_disabled', false])
};

(count _neartruck > 0);
