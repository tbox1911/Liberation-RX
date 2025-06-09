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

private _ret = damage _unit;
if (_unit getVariable ["GRLIB_isProtected", 0] > time) exitWith {};
if (_damage >= 1) then {
	_unit setVariable ["GRLIB_isProtected", round (time + 10), true];
	_ret = _ret + 0.25;
};

_ret;
