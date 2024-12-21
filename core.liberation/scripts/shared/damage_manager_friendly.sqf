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

private _damage = _amountOfDamage;

if ((_unit isKindOf "CAManBase") && (isPlayer _killer) && !(isPlayer _unit) && (lifeState _unit != "INCAPACITATED")) then {
	// Friendly fires penalty
	if (vehicle _unit != vehicle _killer && _killer distance2D _unit > 5 && _damage > 0.15) then {
		if ( _unit getVariable ["GRLIB_isProtected", 0] < time ) then {
			private _msg = format ["%1 (%2)", localize "STR_FRIENDLY_FIRE", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			[_killer, -5] remoteExec ["F_addScore", 2];
			_unit setVariable ["GRLIB_isProtected", round(time + 3), true];
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