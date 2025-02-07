params ["_unit", "_selection", "_damage", "_killer", "_projectile", "_hitPartIndex", "_instigator"];

if (isNull _unit) exitWith {};
if (!alive _unit) exitWith {};

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
if (!isNull _killer && _unit != _killer && _damage >= 1) then {
	if (_unit getVariable ["GRLIB_isProtected", 0] < time) then {
		_unit setVariable ["GRLIB_isProtected", round (time + 5), true];
		_ret = _ret + 0.34;
		_unit setDamage _ret;
	};
};
_ret;
