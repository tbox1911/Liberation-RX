params ["_unit", "_selection", "_amountOfDamage", "_killer", "_projectile", "_hitPartIndex", "_instigator"];

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

private _ret = _amountOfDamage;
if (!isNull _killer && _unit != _killer) then {
	if ( _unit getVariable ["GRLIB_isProtected", 0] < time ) then {
		_ret = damage _unit + (_amountOfDamage min 0.25);
		_unit setVariable ["GRLIB_isProtected", round (time + 4), true];
	} else {
		_ret = damage _unit;
	};
};

_ret;
