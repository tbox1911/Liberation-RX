params [
    ["_unit", objNull],
    ["_reloadSpeed",     0.5],
    ["_courage",         0.5],
    ["_aimingSpeed",     0.4],
    ["_spotDistance",    0.4],
    ["_aimingAccuracy",  0.4],
    ["_aimingShake",     0.4],
    ["_spotTime",        0.5],
    ["_commanding",      0.99],
    ["_general",         0.99]
];

if (isNull _unit) exitWith {};

_unit setSkill ["reloadSpeed",    _reloadSpeed];
_unit setSkill ["courage",        _courage];
_unit setSkill ["aimingSpeed",    _aimingSpeed];
_unit setSkill ["spotDistance",   _spotDistance];
_unit setSkill ["aimingAccuracy", _aimingAccuracy];
_unit setSkill ["aimingShake",    _aimingShake];
_unit setSkill ["spotTime",       _spotTime];
_unit setSkill ["commanding",     _commanding];
_unit setSkill ["general",        _general];
