params ["_unit", ["_keep_position", false]];

_unit setUnitPos "UP";
_unit disableAI "PATH";

private _sector = [GRLIB_sector_size, _unit] call F_getNearestSector;

[_unit, _keep_position, _sector] spawn {
	params ["_unit", "_keep_position", "_sector"];

	while {
		sleep 5;
		local _unit && alive _unit && !(captive _unit)
	} do {

		private _targets = _unit nearTargets 100;
		private _enemyNearby = _targets findIf { side (_x select 4) == WEST } != -1;

		private _target = assignedTarget _unit;
		private _knowsAbout = if (!isNull _target) then { _unit knowsAbout _target } else { 0 };

		if (_enemyNearby || { _knowsAbout > 1.5 }) exitWith {
			_unit enableAI "PATH";
			_unit setUnitPos "AUTO";

			if (!isNull _target) then {
				_unit doWatch _target;
				_unit doSuppressiveFire _target;
			};

			(group _unit) setCombatMode "RED";
			(group _unit) setBehaviourStrong "AWARE";
		};

		if (!_keep_position && _sector in blufor_sectors) exitWith {
			_unit enableAI "PATH";
			_unit setUnitPos "AUTO";
			_unit switchMove "AmovPercMwlkSrasWrflDf";
			_unit playMoveNow "AmovPercMwlkSrasWrflDf";

			(group _unit) setCombatMode "RED";
			(group _unit) setBehaviourStrong "COMBAT";
		};
	};

	if (alive _unit) then {
		_unit enableAI "PATH";
		_unit setUnitPos "AUTO";
	};
};
