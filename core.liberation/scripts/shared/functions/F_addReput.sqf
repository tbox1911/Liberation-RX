params ["_unit", "_rep"];
if (!isServer) exitWith {};
if (isNil "_unit") exitWith {};

private _old_rep = (_unit getVariable ["GREUH_reput_count", 0]);
private _new_rep = (_old_rep + _rep);
if (_new_rep > 100) then { _new_rep = 100 };
if (_new_rep < -100) then { _new_rep = -100 };
_unit setVariable ["GREUH_reput_count", _new_rep, true];
