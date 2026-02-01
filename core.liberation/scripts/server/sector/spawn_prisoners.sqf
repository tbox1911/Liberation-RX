params ["_sector_pos", "_max_prisoners", "_managed_units"];

if (_max_prisoners == 0) exitWith {[]};


private _enemy_left = [];

if (isNil "_managed_units") then {
    _managed_units = (_sector_pos nearEntities ["CAManBase", GRLIB_capture_size * 0.8]);
};

private _enemy_left = _managed_units select {
    (alive _x && isNull objectParent _x && !captive _x) &&
    (side _x == GRLIB_side_enemy) && (_x skill "courage" <= 0.8) &&
    !(_x getVariable ["GRLIB_mission_AI", false])
};

private _prisoners = [];
{
    if (_max_prisoners > 0 && ((floor random 100) <= GRLIB_surrender_chance)) then {
        _max_prisoners = _max_prisoners - 1;
        [_x] spawn prisoner_ai;
        _prisoners pushBack _x;
    } else {
        if ((floor random 100) <= 50) then { [_x] spawn bomber_ai };
    };
    sleep 0.1;
} foreach _enemy_left;

_prisoners;
