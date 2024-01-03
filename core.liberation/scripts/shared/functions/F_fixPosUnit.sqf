params ["_unit"];

if (!isNull objectParent _unit) exitWith {};

// try to fix pos on rock/object (thanks Larrow)
private _spawnpos = getPosATL _unit;
private _curalt = _spawnpos select 2;
private _maxpos = _spawnpos vectorAdd [0,0,150];
if (_curalt >= 150) exitWith {};

while { (lineIntersects [ATLtoASL _spawnpos, ATLtoASL _maxpos]) && _curalt < 150 } do {
	_curalt = _curalt + 0.5;
	_spawnpos set [2, _curalt];
	sleep 0.1;
};
_unit setPosATL _spawnpos;
