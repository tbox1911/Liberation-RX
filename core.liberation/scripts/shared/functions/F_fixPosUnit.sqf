params ["_unit"];
// try to fix pos on rock/object (thanks Larrow)
if (!alive _unit) exitWith {};
if (!isNull objectParent _unit) exitWith {};
if (round (speed vehicle _unit) > 1) exitWith {};

private _spawnpos = getPosATL _unit;
private _curalt = _spawnpos select 2;
private _maxalt = 50;
if (_curalt >= _maxalt) exitWith {};
if (surfaceIsWater _spawnpos) exitWith {};

private _maxpos = _spawnpos vectorAdd [0,0,_maxalt];
private _obstacle = count (nearestTerrainObjects [_unit, ["House","Building","Tree","Small Tree","Bush"], 5]);

if (lineIntersects [ATLtoASL _spawnpos, ATLtoASL _maxpos] && _obstacle == 0) then {
	while { (lineIntersects [ATLtoASL _spawnpos, ATLtoASL _maxpos]) && _curalt < _maxalt } do {
		_curalt = _curalt + 0.5;
		_spawnpos set [2, _curalt];
		sleep 0.1;
	};
	_unit setPosATL _spawnpos;
	//_unit setHitPointDamage ["hitLegs", 0];
	_unit setDamage 0;
};

if (round (speed vehicle _unit) <= 1) then {
	_unit switchMove "AmovPercMwlkSrasWrflDf";
	_unit playMoveNow "AmovPercMwlkSrasWrflDf";	
	sleep 2;
};

