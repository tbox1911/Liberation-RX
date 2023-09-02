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

if (isPlayer _killer) then {
	_unit setVariable ["GRLIB_last_killer", _killer, true];
};

private _ret = _amountOfDamage;
private _veh_unit = vehicle _unit;
private _veh_killer = vehicle _killer;

if (isPlayer _killer && _unit != _killer) then {
	// OpFor in vehicle
	if (_veh_unit != _unit && _veh_killer == _killer && round (_killer distance2D _unit) <= 2) then {
		if ( _unit getVariable ["GRLIB_isProtected", 0] < time ) then {
			private _msg = format ["%1 Stop Cheating !!", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", owner _killer];
			(group _unit) reveal _killer;
			(gunner _veh_unit) doTarget _killer;
			_veh_unit fireAtTarget [_killer];
			_unit setVariable ["GRLIB_isProtected", round(time + 3), true];
		};
		_ret = 0;
	};
};

if (_veh_unit isKindOf "AllVehicles" && damage _veh_unit >= 0.80) then {
	{ [_x, false] spawn F_ejectUnit} forEach (crew _veh_unit);	
};

_ret;
