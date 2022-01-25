// Exit SoG tunnel with AI
private _unit_list = units group player;
//private _player_pos = getPos player;
//private _unit_list_redep = [_unit_list, { !(isPlayer _x) && vehicle _x == _x && (_x distance2D _player_pos) < 40 && lifestate _x != 'INCAPACITATED' }] call BIS_fnc_conditionalSelect;
private _unit_list_redep = [_unit_list, { !(isPlayer _x) && vehicle _x == _x && lifestate _x != 'INCAPACITATED' }] call BIS_fnc_conditionalSelect;

diag_log format ["DBG: %1 %2", player, _unit_list_redep];

[_unit_list_redep] spawn {
    params ["_list"];
    {
        sleep 0.3;
        _x setpos ([getPosATL player, 1, random 360] call BIS_fnc_relPos);
        _x doFollow leader player;
    } forEach _list;
};

