params [ "_position", "_distance", "_side" ];
private [ "_infantrycount1", "_infantrycount2" ];

_infantrycount1 = {
    (alive _x) &&
    (!(captive _x) || isPlayer _x) &&
    ((getPosATL _x) select 2 < 200) &&
    (speed vehicle _x <= 100) &&
    !(typeOf (objectParent _x) in uavs) &&
    (_x distance2D lhd > GRLIB_fob_range) &&
    (_x distance2D _position <= _distance) &&
    !(_x getVariable ["GRLIB_mission_AI", false])
} count units _side;

_infantrycount2 = {
    (alive _x) &&
    (_x distance2D lhd > GRLIB_fob_range) &&
    (_x distance2D _position <= _distance) &&
    (_x getVariable ["PAR_Grp_ID", ""] != "")
} count units GRLIB_side_civilian;

(_infantrycount1 + _infantrycount2)
