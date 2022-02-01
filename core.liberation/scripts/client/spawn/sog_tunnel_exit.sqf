// Exit SoG tunnel with AI

private _unit_list = player getVariable ["SOG_unit_list", []];
private _unit_list_redep = [_unit_list, { vehicle _x == _x && lifestate _x != 'INCAPACITATED' }] call BIS_fnc_conditionalSelect;

[_unit_list_redep] spawn {
    params ["_list"];
    sleep 1;
    {
        _x setpos ([getPosATL player, 1, random 360] call BIS_fnc_relPos);
        _x doFollow leader player;
        sleep 0.3;
    } forEach _list;
};

showMap true;
player setVariable ["SOG_exit_tunnel", round (time + 300)];
