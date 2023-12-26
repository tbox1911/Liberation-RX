params ["_group", ["_vehicle", objNull]];

private _delay = 1;
if (_vehicle isKindOf "Plane_Base_F") then { _delay = 0.5 };
{ [_x, false] spawn F_ejectUnit; sleep _delay } forEach (units _group);
