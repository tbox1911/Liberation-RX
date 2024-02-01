params [ "_position", "_distance", "_side" ];

private _list = (_position nearEntities ["CAManBase", _distance]);

if (_side == GRLIB_side_friendly) then {
   _list = _list select {
        (side _x == GRLIB_side_friendly || side _x == GRLIB_side_civilian) &&
        ((getPosATL _x) select 2 < 150) && (speed (vehicle _x) <= 80) &&
        (_x getVariable ["PAR_Grp_ID", ""] != "")
    };
};

if (_side == GRLIB_side_enemy) then {
    _list = _list select {
        (side _x == GRLIB_side_enemy) &&
        ((getPosATL _x) select 2 < 150) && (speed (vehicle _x) <= 80) &&
        !(_x getVariable ["GRLIB_mission_AI", false])
    };
};

(count _list);
