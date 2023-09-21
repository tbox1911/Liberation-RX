params [ "_sectorpos", ["_nbunit", 1] ];
private ["_unit"];

private _spread = 1;
if ( _sector in sectors_bigtown ) then {
	_spread = 2.5;
};

private _spawnpos = [(((_sectorpos select 0) + (75 * _spread)) - (random (150 * _spread))),(((_sectorpos select 1) + (75 * _spread)) - (random (150 * _spread))),0.3];
private _class_civ = [];
for "_i" from 1 to _nbunit do {
	_class_civ pushBack (selectRandom civilians);
};

private _grp = createGroup [GRLIB_side_civilian, true];
{
	_unit = _grp createUnit [_x, _spawnpos, [], 20, "NONE"];
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
} foreach _class_civ;

//diag_log format [ "Done Spawning civilian %1 at %2", typeOf _civ_unit, time ];
_grp;
