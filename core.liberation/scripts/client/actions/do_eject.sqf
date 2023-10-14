params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

private _crew = crew _vehicle;
if (count _crew == 0) exitWith {};
{
	if (local _x) then {
		[_x, false] spawn F_ejectUnit;
	} else {
		[_x, false] remoteExec ["F_ejectUnit", 2];
	};
	sleep 0.1;
} forEach _crew;