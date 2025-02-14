params ["_static", ["_dist", 120]];

private _blufor_nearby = [_static, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount;
private _gunner_nearby = (units GRLIB_side_enemy) select {
    (_x distance2D _static < _dist) &&
    (alive _x) && (isNull objectParent _x) &&
    (isNil {_x getVariable "GRLIB_is_prisoner"}) &&
    (secondaryWeapon _x == "") &&
    isNil {_x getVariable "PAR_Grp_ID"}
};

if (_blufor_nearby > 0 && count _gunner_nearby > 0) then {
    private _gunner_sorted = _gunner_nearby apply {[_x distance2D _static, _x]};
    _gunner_sorted sort true;
    _gunner = (_gunner_sorted select 0 select 1);
    [_gunner] spawn F_fixPosUnit;
    _gunner assignAsGunner _static;
    [_gunner] orderGetIn true;
    //_gunner moveInGunner _static;
};
