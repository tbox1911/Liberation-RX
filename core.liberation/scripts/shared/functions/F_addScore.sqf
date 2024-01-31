params ["_unit", "_score"];
if (!isServer) exitWith {};

private _old_score = (_unit getVariable ["GREUH_score_count", 0]);
_unit setVariable ["GREUH_score_count", (_old_score + _score), true];
