params ["_uid", "_ammo"];

private _p1 = _uid call BIS_fnc_getUnitByUID;
if (!isNull _p1) then {
    _cur_ammo = _p1 getVariable ['GREUH_ammo_count', 0];
    _p1 setVariable ['GREUH_ammo_count', (_cur_ammo + _ammo), true];
};
{
    if ( (_x select 0) == _uid) exitWith {
        _cur_ammo = (_x select 2);
        _x set [2, (_cur_ammo + _ammo)];
    };
} forEach GRLIB_player_scores;
