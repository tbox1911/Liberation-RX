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

private _veh_unit = objectParent _unit;

// Infantry
if (_unit isKindOf "CAManBase" && isNull _veh_unit) exitWith {
	private _newDamage = _unit getVariable ["GRLIB_unitDamage", 0];
	if (time > (_unit getVariable ["GRLIB_isProtected", 0])) then {
		private _lucky = _unit getVariable ["GRLIB_isLucky", (floor random 3)];
		if (alive _unit && _damage >= 1 && _damage <= 2 && _lucky == 0) then {
			_unit setVariable ["GRLIB_isProtected", round(time + 3)];
			[_unit] spawn F_unitSemiWounded;
			_newDamage = 0.85;
		} else {
			_newDamage = _damage;
		};
	} else {
		_newDamage = 0.85;
	};
	_unit setVariable ["GRLIB_unitDamage", _newDamage, true];
	_newDamage;
};

// Vehicle
if (isPlayer _killer) then {
	_unit setVariable ["GRLIB_last_killer", _killer, true];
};

if (count (crew _unit) > 0) then {
	// Eject crew
	private _evac_in_progress = (_unit getVariable ["GRLIB_vehicle_evac", false]);
	private _vehicle_damage = [_unit] call F_getVehicleDamage;
	if (_vehicle_damage >= 0.75 && !_evac_in_progress) then {
		_unit setVariable ["GRLIB_vehicle_evac", true, true];
		[crew _unit] spawn {
			params ["_units"];
			{ [_x, false] spawn F_ejectUnit; sleep 0.3 } forEach _units;
		};
	};
};

if (isPlayer _killer && _unit != _killer) then {
	private _veh_killer = objectParent _killer;
	// OpFor in vehicle
	if (!isNull _veh_unit && isNull _veh_killer && round (_killer distance2D _unit) <= 2) then {
		private _msg = format ["%1 Stop Cheating !!", name _killer];
		[gamelogic, _msg] remoteExec ["globalChat", owner _killer];
		[_unit, _killer] spawn {
			params ["_unit", "_killer"];
			_unit reveal [_killer, 4];
			sleep 0.5;
			private _veh_unit = objectParent _unit;
			(gunner _veh_unit) doTarget _killer;
			sleep 1.5;
			_veh_unit fireAtTarget [_killer];
		};
		_damage = 0;
	};
};

_damage;
