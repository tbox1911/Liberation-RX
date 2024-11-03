// Fix unit position when blocked in rock/ruins/object
// by pSiKO - (thanks Larrow)

params ["_unit"];

if (!alive _unit) exitWith {};
if (!isNull objectParent _unit) exitWith {};
if (speed vehicle _unit > 1) exitWith {};
if (_unit getVariable ["GRLIB_in_building", false]) exitWith {};

private ["_spawnpos", "_curalt", "_maxalt", "_maxpos" ];
_spawnpos = getPosASL _unit;
if (surfaceIsWater _spawnpos) exitWith {};

_curalt = _spawnpos select 2;
_maxalt = _curalt + 100;
private _forest_type = ["forest", "wood"];
private _typepos = tolower (surfaceType getPosWorld _unit);
private _forest = count (_forest_type select { (_typepos find _x) > -1 });
_forest = _forest + count (nearestTerrainObjects [_unit, ["Tree","Small Tree"], 6]);
if (_forest > 0) then { _maxalt = 3 };

private _obstacle = count (nearestTerrainObjects [_unit, ["House","Building"], 10]);
if (_obstacle > 0) then { _maxalt = 2.3 };

// private _obstacle_rock = count (nearestTerrainObjects [_spawnpos, ["ROCK"], 20]);
// if (_obstacle_rock > 0) then {_maxalt = 60 };

_spawnpos = (_spawnpos vectorAdd [0,0,0.5]);
_maxpos = (_spawnpos vectorAdd [0,0,_maxalt]);
if !(lineIntersects [_spawnpos, _maxpos, _unit]) exitWith {};

while { (lineIntersects [_spawnpos, _maxpos, _unit]) && _curalt < _maxalt } do {
	_curalt = _curalt + 0.5;
	_spawnpos set [2, _curalt];
	sleep 0.1;
};

_unit allowDamage false;
_unit setPosASL _spawnpos;
_unit switchMove "AmovPercMwlkSrasWrflDf";
_unit playMoveNow "AmovPercMwlkSrasWrflDf";
sleep 3;
_unit setHitPointDamage ["hitLegs", 0];
_unit allowDamage true;
