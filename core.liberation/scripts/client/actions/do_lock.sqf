params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

GRLIB_vehicle_lock = false;
private _uid = getPlayerUID player;
private _prev_owner = _vehicle getVariable ["GRLIB_vehicle_owner", ""];

if (local _vehicle) then {
    [_vehicle, "lock", _uid] call F_vehicleLock;
} else {
	[_vehicle, "lock", _uid] remoteExec ["vehicle_lock_remote_call", 2];
    sleep 1;
};

{
    if !(_x getVariable ["GRLIB_vehicle_owner", ""] in ["public", "server"]) then {
        _x setVariable ["GRLIB_vehicle_owner", _uid, true];
    };
} forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]) + (_vehicle getVariable ["GRLIB_ammo_truck_load", []]);

hintSilent format [localize "STR_DO_LOCK", [typeOf _vehicle] call F_getLRXName];
if (_prev_owner != _uid) then {
    gamelogic globalChat localize "STR_DO_LOCK_MSG";
};

sleep 0.5;
GRLIB_vehicle_lock = true;
