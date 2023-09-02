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
private _veh_unit = vehicle _unit;
private _veh_killer = vehicle _killer;

if ( (isPlayer _killer) && !(isPlayer _unit) && (lifeState _unit != "INCAPACITATED") ) then {
	// Friendly fires penalty AI
	if (_veh_unit != _veh_killer && !(typeOf _veh_unit in uavs) && _amountOfDamage > 0.15) then {
		if ( _unit getVariable ["GRLIB_isProtected", 0] < time ) then {
			private _msg = format ["%1 - Hey %2! Watch your fire!", localize "STR_FRIENDLY_FIRE", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			[_killer, -5] remoteExec ["F_addScore", 2];
			_unit setVariable ["GRLIB_isProtected", round(time + 3), true];
		};
		if (GRLIB_revive != 0) then { _ret = _amountOfDamage min 0.86 };
	};
};

if (_veh_unit isKindOf "AllVehicles" && damage _veh_unit >= 0.80) then {
	{ [_x, false] spawn F_ejectUnit} forEach (crew _veh_unit);	
};

_ret;
