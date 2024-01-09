params ["_unit"];

if (!isNull objectParent _unit) exitWith {};

// try to fix pos on rock/object (thanks Larrow)
private _spawnpos = getPosASL _unit;
private _curalt = _spawnpos select 2;
private _maxpos = _spawnpos vectorAdd [0,0,80];
if (_curalt >= 80) exitWith {};
if (surfaceIsWater _spawnpos) exitWith {};

while { (lineIntersects [_spawnpos, _maxpos]) && _curalt < 80 } do {
	_curalt = _curalt + 0.5;
	_spawnpos set [2, _curalt];
	sleep 0.1;
};
_unit setPosASL _spawnpos;
