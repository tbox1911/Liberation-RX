params ["_unit", "_item", "_max"];

private _ret = 0;
private _magType = getArray (configFile >> "CfgWeapons" >> _item >> "magazines") select 0;
for "_i" from 1 to _max do {
    if (_unit canAdd _magType && loadAbs _unit < 980) then {
        _unit addMagazines [_magType, 1];
        _ret = _ret + 1;
    };
};
_ret;
