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
if (_unit getVariable ["GRLIB_isProtected", 0] > serverTime) exitWith {};
if (_damage >= 0.80) exitWith {
	_unit setVariable ["GRLIB_isProtected", round (serverTime + 5), true];
	_ret = _ret + 0.25;
	// if (!isDedicated) then {diag_log ["static damage", typeOf _unit, round serverTime, (_unit getVariable ["GRLIB_isProtected", 0]), _damage, _ret]};
	_ret;
};
