params ["_unit", ["_keep_position", false]];

private _resume_movement = false;
private _target = objNull;

private _sector = [GRLIB_sector_size, _unit] call F_getNearestSector;

sleep 20;

while { alive _unit && !(captive _unit) } do {
	_target = ([getPos _unit, 50] call F_getNearbyPlayers) select 0;
	if (!isNil "_target") then {
		_unit doWatch _target;
		_unit setDir (_unit getDir _target);
		if (_unit distance2D _target <= 20 && (floor random 3 == 0)) then {
			_unit doSuppressiveFire _target;
			_resume_movement = true;
		};
	};

	if (_keep_position) then { _resume_movement = false } else {
		if (_sector in blufor_sectors && (floor random 5 == 0)) then { _resume_movement = true };
	};

	if (_resume_movement) exitWith {
		_unit enableAI "PATH";
		_unit setUnitPos "UP";
		_unit switchMove "AmovPercMwlkSrasWrflDf";
		_unit playMoveNow "AmovPercMwlkSrasWrflDf";
		(group _unit) setCombatMode "YELLOW";
		(group _unit) setBehaviourStrong "COMBAT";
	};

	sleep 15;
};
