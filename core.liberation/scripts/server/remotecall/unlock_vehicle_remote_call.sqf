if (!isServer && hasInterface) exitWith {};
params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[_vehicle, {
    params ["_vehicle"];
    _vehicle setVehicleLock "UNLOCKED";
    _vehicle lockCargo false;
    _vehicle lockDriver false;
    _vehicle lockTurret [[0], false];
    _vehicle lockTurret [[0,0], false];
}] remoteExec ["bis_fnc_call", owner _vehicle];
