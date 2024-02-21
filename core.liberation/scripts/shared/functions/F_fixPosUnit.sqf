params ["_unit"];

if (!isNull objectParent _unit) exitWith {};

// try to fix pos on rock/object (thanks Larrow)
private _spawnpos = getPosASL _unit;
private _curalt = _spawnpos select 2;
private _maxalt = 80;
private _maxpos = _spawnpos vectorAdd [0,0,_maxalt];

if (_curalt >= _maxalt) exitWith {};
if (surfaceIsWater _spawnpos) exitWith {};

while { (lineIntersects [_spawnpos, _maxpos, _unit]) && _curalt < _maxalt } do {
	_curalt = _curalt + 0.5;
	_spawnpos set [2, _curalt];
};

_unit setPosASL _spawnpos;
_unit setHitPointDamage ["hitLegs", 0];
