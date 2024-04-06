params [ "_sectorpos", ["_nb_unit", 1] ];
if (isNil "_sectorpos") exitWith { grpNull };
private ["_unit"];

private _spread = 2;
if ( _nb_unit > 10 ) then { _spread = 3 };

private _class_civ = [];
for "_i" from 1 to _nb_unit do {
	_class_civ pushBack (selectRandom civilians);
};

private _spawnpos = [];
private _grp = createGroup [GRLIB_side_civilian, true];
{
	_spawnpos = [(((_sectorpos select 0) + (75 * _spread)) - (random (150 * _spread))),(((_sectorpos select 1) + (75 * _spread)) - (random (150 * _spread))), 0.5];
	_unit = _grp createUnit [_x, _spawnpos, [], 100, "NONE"];
	sleep 0.1;
	_unit allowDamage false;
	_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	_unit setVariable ['GRLIB_can_speak', true, true];
	_unit addEventHandler ["HandleDamage", { _this call damage_manager_civilian }];
	_unit switchMove "AmovPercMwlkSnonWnonDf";
	_unit playMoveNow "AmovPercMwlkSnonWnonDf";
	sleep 1;
	_unit allowDamage true;
} foreach _class_civ;

_grp setCombatMode "BLUE";
_grp setBehaviourStrong "SAFE";

[_grp, _sectorpos] spawn add_civ_waypoints;
[_grp, _sectorpos] spawn civilian_ai;

//diag_log format [ "Done Spawning civilian %1 at %2", typeOf _civ_unit, time ];
_grp;
