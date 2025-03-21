params [ "_sector_pos", ["_nb_unit", 1] ];
if (isNil "_sector_pos") exitWith { grpNull };
private ["_unit"];

private _spread = 2;
if ( _nb_unit > 10 ) then { _spread = 3 };

private _class_civ = [];
for "_i" from 1 to _nb_unit do {
	_class_civ pushBack (selectRandom civilians);
};

private _spawn_pos = [];
private _grp = createGroup [GRLIB_side_civilian, true];
{
	_spawn_pos = [(((_sector_pos select 0) + (75 * _spread)) - (floor random (150 * _spread))),(((_sector_pos select 1) + (75 * _spread)) - (floor random (150 * _spread))), 0.5];
	if !(surfaceIsWater _spawn_pos) then {
		_unit = _grp createUnit [_x, _spawn_pos, [], 20, "NONE"];
		[_unit] joinSilent _grp;
		_unit allowDamage false;
		_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_unit setPitch 1;
		_unit setVariable ['GRLIB_can_speak', true, true];
		_unit setVariable ["GRLIB_is_civilian", true, true];
		_unit setVariable ["acex_headless_blacklist", true, true];
		_unit addEventHandler ["HandleDamage", {_this call damage_manager_civilian}];
		_unit switchMove "AmovPercMwlkSnonWnonDf";
		_unit playMoveNow "AmovPercMwlkSnonWnonDf";
		sleep 1;
		_unit allowDamage true;
		if (floor random 4 == 0) then { _unit setDamage 0.45 };
	};
	sleep 0.1;
} foreach _class_civ;

_grp setCombatMode "BLUE";
_grp setBehaviourStrong "SAFE";

//diag_log format [ "Done Spawning civilian %1 at %2", typeOf _civ_unit, time ];
_grp;
