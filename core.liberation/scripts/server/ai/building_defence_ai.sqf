params ["_unit"];

if (isNull _unit) exitWith {};

private _move_is_disabled = true;
private _resume_movement = false;
private _target = objNull;
private _hostilecount = 0;

sleep (10 + floor random 50);
while { _move_is_disabled && alive _unit && !(captive _unit) } do {
	_hostilecount = count ([_unit, 80] call F_getNearbyPlayers);

	if ( _hostilecount > 0 || damage _unit > 0.25 ) then {
		_resume_movement = true;
	};

	if ( _resume_movement ) then {
		if ( _move_is_disabled ) then {
			_move_is_disabled = false;
			_unit enableAI "PATH";
			_unit setUnitPos "AUTO";
			_unit switchMove "AmovPercMwlkSrasWrflDf";
			_unit playMoveNow "AmovPercMwlkSrasWrflDf";
			(group _unit) setCombatMode "RED";
			(group _unit) setCombatBehaviour "COMBAT";
		};
	};

	if ( _move_is_disabled ) then {
		_target = assignedTarget _unit;
		if(!(isNull _target)) then {
			_unit setDir (getDir _target);
		};
	};

	sleep 5;
};
