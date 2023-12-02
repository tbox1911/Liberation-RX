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
	_spawnpos = [(((_sectorpos select 0) + (75 * _spread)) - (random (150 * _spread))),(((_sectorpos select 1) + (75 * _spread)) - (random (150 * _spread))),0.3];
	while { (surfaceIsWater _spawnpos) } do {
		_spawnpos = [(((_sectorpos select 0) + (75 * _spread)) - (random (150 * _spread))),(((_sectorpos select 1) + (75 * _spread)) - (random (150 * _spread))),0.3];
		sleep 0.1;
	};

	_unit = _grp createUnit [_x, _spawnpos, [], 100, "NONE"];
	_unit allowDamage false;
	_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	_unit setVariable ['GRLIB_can_speak', true, true];
	_unit addEventHandler ["HandleDamage", {
		params ["_unit", "_selection", "_damage", "_source"];
		private _dam = 0;
		if ( side _source == GRLIB_side_friendly ) then {
			_dam = _damage;
		};
		if ( side(driver _unit) == GRLIB_side_friendly ) then {
			_dam = _damage;
		};
		_dam;
	}];

	[_unit] call F_fixPosUnit;
	_unit switchMove "AmovPercMwlkSrasWrflDf";
	_unit playMoveNow "AmovPercMwlkSrasWrflDf";
	sleep 1;
	_unit allowDamage true;
} foreach _class_civ;

_grp setCombatMode "BLUE";
_grp setBehaviour "SAFE";

//diag_log format [ "Done Spawning civilian %1 at %2", typeOf _civ_unit, time ];
_grp;
