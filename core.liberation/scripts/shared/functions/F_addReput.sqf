params ["_unit", "_rep"];
if (!isServer) exitWith {};

private _old_rep = (_unit getVariable ["GREUH_reput_count", 0]);
_unit setVariable ["GREUH_reput_count", (_old_rep + _rep), true];
