params [ "_position", "_distance", "_side" ];

private _count = 0;

if (_side == GRLIB_side_friendly) then {
    private _units = (units GRLIB_side_friendly + units GRLIB_side_civilian);
    if (!isNil "GRLIB_SHOP_Group") then { _units = _units - units GRLIB_SHOP_Group};
    if (!isNil "GRLIB_SELL_Group") then { _units = _units - units GRLIB_SELL_Group};
    if (!isNil "GRLIB_FOB_Group") then { _units = _units - units GRLIB_FOB_Group};
    if (!isNil "GRLIB_WHS_Group") then { _units = _units - units GRLIB_WHS_Group};

    _count = {
        (alive _x) &&
        (_x distance2D _position <= _distance) &&
        ((getPosATL _x) select 2 < 200) &&
        (speed vehicle _x <= 100) &&
        (_x getVariable ["PAR_Grp_ID", ""] != "")
    } count _units;
};

if (_side == GRLIB_side_enemy) then {
    _count = {
        (alive _x) && !(captive _x) &&
        (_x distance2D _position <= _distance) &&
        ((getPosATL _x) select 2 < 200) &&
        (speed vehicle _x <= 100) &&
        !(_x getVariable ["GRLIB_mission_AI", false])
    } count (units GRLIB_side_enemy);
};

_count;
