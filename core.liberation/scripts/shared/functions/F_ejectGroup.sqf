params ["_group", ["_vehicle", objNull]];

if (_vehicle getVariable ["GRLIB_vehicle_evac", false]) exitWith {};

private _delay = 1;
if (_vehicle isKindOf "Plane_Base_F") then { _delay = 0.5 };
if (!isNull _vehicle) then { _vehicle setVariable ["GRLIB_vehicle_evac", true, true] };
{ [_x, false] spawn F_ejectUnit; sleep _delay } forEach (units _group);
if (!isNull _vehicle) then { _vehicle setVariable ["GRLIB_vehicle_evac", false, true] };
