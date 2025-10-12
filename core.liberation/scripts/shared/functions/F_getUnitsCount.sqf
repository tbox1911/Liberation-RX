params [ "_position", "_distance", "_side" ];

if (_side == GRLIB_side_friendly) exitWith {
    {
        (alive _x) && (_x distance2D _position < _distance) &&
        !(isNil {_x getVariable "PAR_Grp_ID"}) &&
        !(_x getVariable ["GRLIB_mission_AI", false]) &&
        (getPosATL _x select 2 < 150) && (speed vehicle _x < 100)
    } count (units GRLIB_side_friendly + units GRLIB_side_civilian);
};

if (_side == GRLIB_side_enemy) exitWith {
    {
        (alive _x) && (_x distance2D _position < _distance) && !(captive _x) &&
        (getPosATL _x select 2 < 150) && (speed vehicle _x < 100) &&
        !(typeOf (objectParent _x) in uavs_vehicles) &&
        !(_x getVariable ["GRLIB_mission_AI", false]) &&
        !(_x getVariable ["GRLIB_is_prisoner", false]) &&
        !(_x getVariable ["ACE_isUnconscious", false])
    } count (units GRLIB_side_enemy);
};

if (_side == GRLIB_side_civilian) exitWith {
    {
        (alive _x) && (_x distance2D _position < _distance) && !(captive _x) &&
        (isNil {_x getVariable "GRLIB_vehicle_owner"}) &&
        (isNil {_x getVariable "PAR_Grp_ID"})
    } count (units GRLIB_side_civilian);
};

0;
