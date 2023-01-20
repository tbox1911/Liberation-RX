params ["_unit", "_selection", "_amountOfDamage", "_killer", "_projectile", "_hitPartIndex", "_instigator"];

if (isNull _unit) exitWith {0};
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
	private _veh_unit = vehicle _unit;
	private _veh_killer = vehicle _killer;

	// Friendly fires penalty AI
	if (isPlayer _killer && !(isPlayer _unit) && side group _unit == GRLIB_side_friendly && _unit != _killer && _veh_unit != _veh_killer && lifeState _unit != "INCAPACITATED" && _amountOfDamage > 0.15 ) then {
		if ( _unit getVariable ["GRLIB_isProtected", 0] < time ) then {
			private _msg = format ["%1 - %2 Watch your fire !! ", localize "STR_FRIENDLY_FIRE", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			[_killer, -5] remoteExec ["F_addScore", 2];
			_unit setVariable ["GRLIB_isProtected", round(time + 3), true];
		};
		if (GRLIB_revive != 0) then { _ret = _amountOfDamage min 0.86 };
	};
};

_ret;
