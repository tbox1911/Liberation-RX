params ["_sector_pos", "_max_prisonners"];

private _enemy_left = (_sector_pos nearEntities ["CAManBase", GRLIB_capture_size * 0.8]) select {
    (side _x == GRLIB_side_enemy) && (_x skill "courage" < 0.8) &&
    !(_x getVariable ["GRLIB_mission_AI", false])
};
{
    if (_max_prisonners > 0 && ((floor random 100) <= GRLIB_surrender_chance)) then {
        [_x] spawn prisoner_ai;
        _max_prisonners = _max_prisonners - 1;
    } else {
        if ((floor random 100) <= 50) then { [_x] spawn bomber_ai };
    };
} foreach _enemy_left;
