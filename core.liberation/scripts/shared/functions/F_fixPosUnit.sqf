params ["_unit"];

if (!isNull objectParent _unit) exitWith {};

// try to fix pos on rock/object (thanks Larrow)
private _spawnpos = getPosATL _unit;
private _maxpos = _spawnpos vectorAdd [0,0,150];
while { (lineIntersects [ATLToASL _maxpos, ATLToASL _spawnpos]) && (_spawnpos select 2) <= 150 } do {
	_spawnpos set [2, ((_spawnpos select 2) + 0.25)];
};
_unit setPosATL _spawnpos;
