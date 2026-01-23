params ["_unit", "_selection", "_damage", "_killer", "_projectile", "_hitPartIndex", "_instigator"];

if (!isNull _instigator) then {
	if (isNull (getAssignedCuratorLogic _instigator)) then {
	   	_killer = _instigator;
	};
} else {
	if (!(_killer isKindOf "CAManBase")) then {
		_killer = effectiveCommander _killer;
	};
};

private _newDamage = _unit getVariable ["GRLIB_unitDamage", 0];
if (_damage >= 0.8 && (time >= (_unit getVariable ["GRLIB_isProtected", 0]))) then {
    _unit setVariable ["GRLIB_isProtected", round(time + 5)];
    _newDamage = (_newDamage + 0.25) min 1;
	if (_damage >= 10) then {
		_newDamage = 1;
	};
	if (hasInterface) then {
		systemchat format ["%1 damaged to %2%%.", [_unit] call F_getLRXName, (_newDamage * 100)];
	};
	_unit setVariable ["GRLIB_unitDamage", _newDamage, true];
};
_newDamage;