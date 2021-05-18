params ["_uid", "_score"];

private _p1 = _uid call BIS_fnc_getUnitByUID;
if (!isNull _p1) then {
    _p1 addScore _score;
};
{
    if ( (_x select 0) == _uid) exitWith {
        _cur_score = (_x select 1);
        _x set [1, (_cur_score + _score)];
    };
} forEach GRLIB_player_scores;
