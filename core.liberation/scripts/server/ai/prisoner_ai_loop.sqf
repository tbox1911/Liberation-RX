params ["_unit", "_friendly"];

private _fleeing = false;
private _captured = false;
private _blufor_near = 0;
private _timeout = time + (30 * 60);

while { alive _unit && !_captured } do {
	// Captured
	if ([_unit, "FOB", 30] call F_check_near && (round (getPos _unit select 2) <= 0) && (round (speed vehicle _unit) == 0)) exitWith {
		_unit setVariable ["GRLIB_can_speak", false, true];
		_captured = true;
	};

	// Stopped
	if !(_unit getVariable ["GRLIB_is_prisoner", true]) then {
		_fleeing = false;
	};

	if (!_captured && isNull objectParent _unit) then {
		// Flee
		_blufor_near = [_unit, GRLIB_capture_size, GRLIB_side_friendly] call F_getUnitsCount;
		if (!_friendly && !_fleeing) then {
			private _player = _unit getVariable ["GRLIB_prisoner_owner", objNull];
			private _player_in_action = _player getVariable ["GRLIB_action_inuse", false];

			if (_blufor_near == 0 && !_player_in_action) then {
				_unit setVariable ["GRLIB_is_prisoner", true, true];
				_fleeing = true;
				if (side group _unit == GRLIB_side_friendly) then {
					private _text = format ["Alert! %1 prisoner %2 is escaping!", name _player, name _unit];
					[gamelogic, _text] remoteExec ["globalChat", 0];
				};
				_grp = createGroup [GRLIB_side_enemy, true];
				[_unit] joinSilent _grp;
				[_unit, "flee"] remoteExec ["remote_call_prisoner", 0];
				sleep 3;
				[_unit] spawn escape_ai;
				_timeout = time + (30 * 60);
			};
		};

		// Timeout
		if (!_friendly && _blufor_near == 0 && time > _timeout) then {
			deleteVehicle _unit;
		};
	};

	sleep (3 + floor random 4);
};

if (alive _unit && _captured) then {
	sleep 3;
	private _leader = leader group _unit;
	private _grp = createGroup [GRLIB_side_civilian, true];
	[_unit] joinSilent _grp;
	_unit setVariable ["GRLIB_is_prisoner", nil, true];
	sleep 1;
	[_unit, "stop"] remoteExec ["remote_call_prisoner", 0];
	sleep 3;
	[_unit, _leader, _friendly] spawn prisoner_captured;
};
