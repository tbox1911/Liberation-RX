params [ "_position", "_distance", "_side" ];

private _count = 0;
if (_side == GRLIB_side_friendly) then {
    _count = {
        (_x distance2D _position < _distance) &&
        ((getPosATL _x) select 2 < 150) && (speed (vehicle _x) <= 80) &&
        !(isNil {_x getVariable "PAR_Grp_ID"})
    } count (units GRLIB_side_friendly);
};

if (_side == GRLIB_side_enemy) then {
    _count = {
        (_x distance2D _position < _distance) &&
        ((getPosATL _x) select 2 < 150) && (speed (vehicle _x) <= 80) &&
        !(_x getVariable ["GRLIB_mission_AI", false]) &&
        !(_x getVariable ["GRLIB_is_prisoner", false]) &&
        !(_x getVariable ["ACE_isUnconscious", false])
    } count (units GRLIB_side_enemy);    
};

_count;
