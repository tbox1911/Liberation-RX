params ["_unit", "_item", "_min"];
private ["_magType", "_magCnt"];
private _ret = false;

if ( isClass( configFile >> "CfgWeapons" >> _item ) && !( getArray( configFile >> "CfgWeapons" >> _item >> "magazines" ) isEqualTo []) ) then {
    _magType = getArray( configFile >> "CfgWeapons" >> _item >> "magazines" ) select 0;
    _magCnt = {_x == _magType} count magazines _unit;
    if (_magCnt < _min) then {_ret = true};
};
_ret;
