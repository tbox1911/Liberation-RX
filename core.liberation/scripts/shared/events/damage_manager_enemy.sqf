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

if (_unit isKindOf "AllVehicles") then {
	if (isPlayer _killer) then {
		_unit setVariable ["GRLIB_last_killer", _killer, true];
	};

	if (count (crew _unit) > 0) then {
		// Eject crew
		private _vehicle_damage = [_unit] call F_getVehicleDamage;
		if (_vehicle_damage >= 0.75) then {
			private _evac_in_progress = (_unit getVariable ["GRLIB_vehicle_evac", false]);
			if (!_evac_in_progress) then {
				_unit setVariable ["GRLIB_vehicle_evac", true, true];
				{ [_x, false] spawn F_ejectUnit } forEach (crew _unit);
			};
		};
	};
};

if (_unit isKindOf "CAManBase") then {
	if (isPlayer _killer && _unit != _killer) then {
		private _veh_unit = vehicle _unit;
		private _veh_killer = vehicle _killer;
		// OpFor in vehicle
		if (_veh_unit != _unit && _veh_killer == _killer && round (_killer distance2D _unit) <= 2) then {
			private _msg = format ["%1 Stop Cheating !!", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", owner _killer];
			[_unit, _killer] spawn {
				params ["_unit", "_killer"];
				_unit reveal [_killer, 4];
				sleep 0.5;
				(gunner _veh_unit) doTarget _killer;
				sleep 1.5;
				_veh_unit fireAtTarget [_killer];
			};
			_damage = 0;
		};
	};
};

_damage;
