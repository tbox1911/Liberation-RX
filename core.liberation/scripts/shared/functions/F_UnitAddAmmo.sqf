params ["_unit", "_item", "_max"];

private _ret = 0;
if (_item == "") exitWith { _ret };

if ( isClass (configFile >> "CfgWeapons" >> _item) && count (getArray (configFile >> "CfgWeapons" >> _item >> "magazines")) > 0 ) then {
    private _magType = getArray (configFile >> "CfgWeapons" >> _item >> "magazines") select 0;
    for "_i" from 1 to _max do {
        if (_unit canAdd _magType && loadAbs _unit < 980) then {
            _unit addMagazines [_magType, 1];
            _ret = _ret + 1;
        };
    };
} else {
    diag_log format ["--- LRX Error : Check Magazines - soldier %1 - weapon %2", typeOf _unit, _item];
};
_ret;
