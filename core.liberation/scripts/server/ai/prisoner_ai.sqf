params [ "_unit", ["_friendly", false], ["_canmove", false] ];

if (isNull _unit) exitWith {};
if !(isNull objectParent _unit) exitWith {};
if (_unit getVariable ["GRLIB_mission_AI", false]) exitWith {};
if (_unit getVariable ["GRLIB_is_prisoner", false]) exitWith {};
if (surfaceIsWater (getPosATL _unit)) exitWith {};
if (_unit skill "courage" == 1) exitWith {};
if (!isDedicated && !hasInterface && isMultiplayer) exitWith { [_unit, _friendly, _canmove] remoteExec ["prisoner_ai", 2] };

sleep 10;
if (!alive _unit) exitWith {};

// Init priso
private _grp = createGroup [GRLIB_side_enemy, true];
[_unit] joinSilent _grp;

doStop _unit;
removeAllWeapons _unit;
//removeHeadgear _unit;
removeBackpack _unit;
removeVest _unit;
private _hmd = (hmd _unit);
_unit unassignItem _hmd;
_unit removeItem _hmd;
_unit setVariable ["GRLIB_can_speak", true, true];
_unit removeAllEventHandlers "HandleDamage";
_unit setCaptive true;
[_unit] spawn F_fixPosUnit;

// Wait
if (!_canmove) then {
	// Halt
	[_unit, "init"] remoteExec ["remote_call_prisoner", 0];
	sleep 3;
	_unit setVariable ["GRLIB_is_prisoner", true, true];
	if (_friendly) then {
		waitUntil { sleep 1; (!alive _unit || side group _unit == GRLIB_side_friendly) };
	} else {
		private _timeout = time + (30 * 60);
		waitUntil { sleep 1; (!alive _unit || side group _unit == GRLIB_side_friendly || time > _timeout) };
	};
	// Follow
	[_unit, "move"] remoteExec ["remote_call_prisoner", 0];
	sleep 3;
} else {
	_unit setVariable ["GRLIB_is_prisoner", true, true];
};

private _fleeing = false;
private _captured = false;
private _timeout = time + (30 * 60);

while { alive _unit && !_captured } do {
	// Captured
	if ([_unit, "FOB", 30] call F_check_near && (round (getPos _unit select 2) <= 0) && (round (speed vehicle _unit) == 0)) then {
		_unit setVariable ["GRLIB_can_speak", false, true];
		_captured = true;
	};

	// Stopped
	if !(_unit getVariable ["GRLIB_is_prisoner", true]) then {
		_fleeing = false;
	};

	if (!_captured) then {
		// Flee
		if (!_friendly && !_fleeing) then {
			private _blufor = (units GRLIB_side_friendly) select { (alive _x) && !(captive _x) && (_x getVariable ["PAR_Grp_ID", ""] != "") };
			private _no_blufor_near = ({ (_x distance2D _unit) <= 100 } count _blufor == 0);
			private _player = _unit getVariable ["GRLIB_prisoner_owner", objNull];
			private _player_in_action = _player getVariable ["GRLIB_action_inuse", false];

			if (_no_blufor_near && !_player_in_action) then {
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
			};
		};

		// Timeout
		if ([_unit, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0 && time > _timeout) then {
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
