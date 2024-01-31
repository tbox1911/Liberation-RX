params [ "_position", "_distance", "_side" ];

private _count = 0;

if (_side == GRLIB_side_friendly) then {
    _count = {
        (alive _x) &&
        (_x distance2D _position <= _distance) &&
        ((getPosATL _x) select 2 < 150) && (speed (vehicle _x) <= 80) &&
        ((vehicle _x) getVariable ["GRLIB_vehicle_owner", ""] != "server" || (getPosATL _x) select 2 < 100) &&
        (_x getVariable ["PAR_Grp_ID", ""] != "")
    } count (units GRLIB_side_friendly + units GRLIB_side_civilian);
};

if (_side == GRLIB_side_enemy) then {
    _count = {
        (alive _x) && !(captive _x) &&
        (_x distance2D _position <= _distance) &&
        ((getPosATL _x) select 2 < 200) && (speed (vehicle _x) <= 100) &&
        !(_x getVariable ["GRLIB_mission_AI", false])
    } count (units GRLIB_side_enemy);
};

_count;
