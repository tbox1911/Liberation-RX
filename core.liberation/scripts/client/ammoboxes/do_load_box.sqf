params [ "_ammobox" ];

private _max_transport_distance = 15;
private _neartransport = [ nearestObjects [player, transport_vehicles, _max_transport_distance], {
	 alive _x && speed vehicle _x < 5 &&
	 ((getpos _x) select 2) < 5 &&
	 ([player, _x] call is_owner || [_x] call is_public) &&
	 !(_x getVariable ['R3F_LOG_disabled', false]) 
}] call BIS_fnc_conditionalSelect;

if (count _neartransport == 0) exitWith { hint localize "STR_BOX_CANTLOAD" };
[(_neartransport select 0), _ammobox ] remoteExec ["load_truck_remote_call", 2];
