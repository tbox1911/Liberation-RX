params [ "_ammobox" ];

private _neartransport = (nearestObjects [player, transport_vehicles, 20]) select {
	alive _x && speed vehicle _x < 5 &&
	((getpos _x) select 2) < 5 &&
	([player, _x] call is_owner || [_x] call is_public || typeOf _x == storage_medium_typename) &&
	!(_x getVariable ['R3F_LOG_disabled', false])
};

if (count _neartransport == 0) exitWith { hint localize "STR_BOX_CANTLOAD" };
_neartransport = _neartransport select 0;
private _maxload = 0;
{
	if ((_x select 0) == typeof _neartransport) exitWith { _maxload = (count _x) - 2 };
} foreach box_transport_config;

private _truck_load = _neartransport getVariable ["GRLIB_ammo_truck_load", []];
if ( count _truck_load < _maxload ) then {
	[_neartransport, _ammobox, player] remoteExec ["load_truck_remote_call", 2];
} else {
 	hint localize "STR_BOX_CANTLOAD";
};
