params ["_ammobox"];

private _transport = [player, typeOf _ammobox, 10] call F_getNearestTransport;
if (isNull _transport) exitWith { hint format [localize "STR_BOX_CANTLOAD", [_ammobox] call F_getLRXName] };

private _maxload = [typeOf _transport] call F_getVehicleMaxLoad;
private _truck_load = _transport getVariable ["GRLIB_ammo_vehicle_load", []];
if (count _truck_load < _maxload) then {
	if (local _transport && local _ammobox) then {
		[_transport, _ammobox, false] call attach_object_direct;
	} else {
		if (count crew _transport > 0) then { [_transport] call do_eject };
		[_transport, _ammobox, player] remoteExec ["load_truck_remote_call", 2];
	};
} else {
 	hint format [localize "STR_BOX_CANTLOAD", [_ammobox] call F_getLRXName];
};
