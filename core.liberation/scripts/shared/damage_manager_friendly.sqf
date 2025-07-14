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

if ((_unit isKindOf "CAManBase") && (isPlayer _killer) && !(isPlayer _unit) && (lifeState _unit != "INCAPACITATED")) then {
	// Friendly fires penalty
	if (vehicle _unit != vehicle _killer && _killer distance2D _unit >= 5 && _damage >= 0.35) then {
		if (_unit getVariable ["GRLIB_isProtected", 0] < serverTime) then {
			_unit setVariable ["GRLIB_isProtected", round(serverTime + 10), true];
			private _msg = format ["%1 (%2)", localize "STR_FRIENDLY_FIRE", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			[_killer, -5] remoteExec ["F_addScore", 2];
		};
	};
};

if ((_unit isKindOf "AllVehicles") && (damage _unit >= 0.80)) then {
	private _evac_in_progress = (_unit getVariable ["GRLIB_vehicle_evac", false]);
	if (!_evac_in_progress) then {
		_unit setVariable ["GRLIB_vehicle_evac", true, true];
		{ [_x, false] spawn F_ejectUnit} forEach (crew _unit);
	};
};

_damage;