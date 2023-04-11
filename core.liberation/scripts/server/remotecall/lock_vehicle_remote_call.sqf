if (!isServer && hasInterface) exitWith {};
params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[_vehicle, {
    params ["_vehicle"];
    _vehicle setVehicleLock "LOCKED";
    _vehicle lockCargo true;
    _vehicle lockDriver true;
    _vehicle lockTurret [[0], true];
    _vehicle lockTurret [[0,0], true];
	_vehicle engineOn false;
}] remoteExec ["bis_fnc_call", owner _vehicle];
