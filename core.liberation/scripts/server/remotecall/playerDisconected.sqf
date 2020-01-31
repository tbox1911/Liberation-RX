if (!isServer) exitWith {};
params [ "_unit" ];

private _my_dog = _unit getVariable ["my_dog", nil];
if (!isNil "_my_dog") then { deleteVehicle _my_dog };

// unlock car Far
_cleanveh = [vehicles, {
	_x getVariable ["GRLIB_vehicle_owner", ""] == (getplayerUID _unit) &&
	((getPos _x) distance2D ([_x] call F_getNearestFob)) >= 500
}] call BIS_fnc_conditionalSelect;

{
	_x setVariable ["GRLIB_vehicle_owner", "", true];
	_x setVariable ["R3F_LOG_disabled", false, true];
} forEach _cleanveh;
