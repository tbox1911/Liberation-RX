params [ "_sector_pos", ["_nb_unit", 1] ];
if (isNil "_sector_pos") exitWith { grpNull };

private _grp = createGroup [GRLIB_side_civilian, true];

for "_i" from 1 to _nb_unit do {
	private _spawn_pos = (_sector_pos getPos [1 + 15 * sqrt (random 1), floor random 360]);
	_spawn_pos = [_spawn_pos, 3, 0, 80] call F_findSafePlace;
	if (count _spawn_pos > 0) then {
		private _unit = _grp createUnit [selectRandom civilians, _spawn_pos, [], 1, "CAN_COLLIDE"];
		if (!isNull _unit) then {
			_unit allowDamage false;
			sleep 0.1;
			[_unit] joinSilent _grp;
			_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
			_unit setVariable ['GRLIB_can_speak', true, true];
			_unit setVariable ["acex_headless_blacklist", true, true];
			_unit addEventHandler ["HandleDamage", {_this call damage_manager_civilian}];
			if (floor random 4 == 0) then { _unit setDamage 0.45 };
			if (floor random 2 == 0) then { [_unit, _sector_pos] spawn civilian_ai };
		};
	};
	sleep 0.1;
};

if (count units _grp == 0) exitWith {
	deleteGroup _grp;
	grpNull
};

[_grp] spawn {
	params ["_grp"];
	sleep 3;
	{
		[_x] call F_fixPosUnit;
		_x allowDamage true;
	} forEach (units _grp);
};

_grp setCombatMode "BLUE";
_grp setBehaviourStrong "SAFE";

// diag_log format [ "Done Spawning %1 civilians at %2", count units _grp, time ];
_grp;
