params ["_unit", "_friendly"];

private _fleeing = false;
private _captured = false;
private _can_flee = false;
private _timeout = time + (15 * 60);

private _unit_can_flee = {
	params ["_unit", "_friendly"];
	if (_friendly) exitWith { false };
	({
		(alive _x) && !(captive _x) &&
		(_x distance2D _unit) <= 100  &&
		!isNil {_x getVariable "PAR_Grp_ID"}
	} count (units GRLIB_side_friendly) == 0);
};

while { alive _unit && !_captured } do {
	// Captured
	if ([_unit, "FOB", 30] call F_check_near && (isNull objectParent _unit) && (round (speed vehicle _unit) == 0)) exitWith {
		_unit setVariable ["GRLIB_can_speak", false, true];
		_captured = true;
	};

	// Stopped
	if !(_unit getVariable ["GRLIB_is_prisoner", true]) then {
		_fleeing = false;
		_timeout = time + (15 * 60);
	};

	// Flee
	_can_flee = [_unit, _friendly] call _unit_can_flee;
	if (_can_flee && !_fleeing) then {
		private _player = _unit getVariable ["GRLIB_prisoner_owner", objNull];
		private _not_in_action = !(_player getVariable ["GRLIB_action_inuse", false]);
		if (_not_in_action) then {
			_unit setVariable ["GRLIB_is_prisoner", true, true];
			_fleeing = true;
			if (side group _unit == GRLIB_side_friendly) then {
				private _text = format ["Alert! %1 prisoner %2 is escaping!", name _player, name _unit];
				[gamelogic, _text] remoteExec ["globalChat", 0];
			};
			[_unit, _friendly] spawn escape_ai;
			_timeout = time + (15 * 60);
		};
	};

	// Timeout
	if (_can_flee && time > _timeout) then {
		deleteVehicle _unit;
	};
	sleep 5;
};

if (alive _unit && _captured) then {
	[_unit] spawn F_ejectUnit;
	unAssignVehicle _unit;
	[_unit] orderGetIn false;
	[_unit] allowGetIn false;
	sleep (3 + floor random 4);
	private _leader = leader group _unit;
	private _grp = createGroup [GRLIB_side_civilian, true];
	[_unit] joinSilent _grp;
	_unit setVariable ["GRLIB_is_prisoner", nil, true];
	[_unit, "stop"] remoteExec ["remote_call_prisoner", 0];
	[_unit, _leader, _friendly] spawn prisoner_captured;
};
