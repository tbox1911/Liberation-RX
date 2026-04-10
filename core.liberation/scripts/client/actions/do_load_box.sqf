params ["_ammobox"];

private _transport = [player, typeOf _ammobox, 10] call F_getNearestTransport;
if (isNull _transport) exitWith { hint format [localize "STR_BOX_CANTLOAD", [_ammobox] call F_getLRXName] };

private _maxload = [typeOf _transport] call F_getVehicleMaxLoad;
private _truck_load = _transport getVariable ["GRLIB_ammo_vehicle_load", []];
if (count _truck_load < _maxload) then {
	[_transport, _ammobox, player] remoteExec ["load_truck_remote_call", 2];
} else {
 	hint format [localize "STR_BOX_CANTLOAD", [_ammobox] call F_getLRXName];
};
