params ["_target", "_caller", "_actionId", "_arguments"];

private _vehicle = objectParent _target;
if (isNull _vehicle) exitWith {};

gamelogic globalChat format [localize "STR_EJECT_ALL_CREW", [_vehicle] call F_getLRXName];
_vehicle setVehicleLock "UNLOCKED";
_vehicle lockCargo false;

{
	if (objectParent _x == _vehicle) then {
		if (local _x) then {
			[_x, false] spawn F_ejectUnit;
		} else {
			[_x, false] remoteExec ["F_ejectUnit", 2];
		};
		sleep 0.2;
	};
} forEach (units _target);
