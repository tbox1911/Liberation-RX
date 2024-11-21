params ["_unit", "_item", "_min"];

private _ret = false;
private _weapons_blacklist = [
    "",
    "SPE_PzFaust_30m",
    "SPE_PzFaust_60m"
];
if (_item in _weapons_blacklist) exitWith { _ret };

if ( isClass (configFile >> "CfgWeapons" >> _item) && count (getArray (configFile >> "CfgWeapons" >> _item >> "magazines")) > 0 ) then {
    private _magType = getArray (configFile >> "CfgWeapons" >> _item >> "magazines") select 0;
    private _magCnt = {_x == _magType} count magazines _unit;
    if (_magCnt < _min) then { _ret = true };
} else {
    diag_log format ["--- LRX Error : Check Magazines - soldier %1 - weapon %2", typeOf _unit, _item];
};
_ret;
