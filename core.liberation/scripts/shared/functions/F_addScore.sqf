params ["_unit", "_score"];

private _old_score = [_unit] call F_getScore;
_unit setVariable ["GREUH_score_count", (_old_score + _score), true];
