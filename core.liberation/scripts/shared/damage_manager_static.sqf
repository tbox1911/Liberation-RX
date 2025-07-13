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

private _currentDamage = damage _unit;
private _newDamage = _currentDamage;
private _now = serverTime;
if (_damage >= 0.8 && (_now >= (_unit getVariable ["GRLIB_isProtected", 0]))) then {
    _unit setVariable ["GRLIB_isProtected", round(_now + 5), true];
    _newDamage = (_currentDamage + 0.25) min 1;
	if (hasInterface) then {
		systemchat format ["%1 damaged to %2%%.", [_unit] call F_getLRXName, (_newDamage * 100)];
	};
};
_newDamage;