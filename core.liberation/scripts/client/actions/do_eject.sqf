params ["_vehicle"];

if (isPlayer _vehicle) then { _vehicle = objectParent _vehicle };
if (isNull _vehicle) exitWith {};

gamelogic globalChat format [localize "STR_EJECT_ALL_CREW", [_vehicle] call F_getLRXName];

_vehicle setVehicleLock "UNLOCKED";
_vehicle lockCargo false;

private _eject_list = (crew _vehicle - (_vehicle getVariable ["GRLIB_taxi_crew", []]));
if (count _eject_list == 0) exitWith {};

{
	[_x, false] spawn F_ejectUnit;
	sleep 0.2;
} forEach _eject_list;
