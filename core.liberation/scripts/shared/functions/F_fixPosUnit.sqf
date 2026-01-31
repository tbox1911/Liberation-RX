// Fix unit position when blocked
// by pSiKO (corrected)

params ["_unit"];

if (!local _unit || !alive _unit) exitWith {};
if (!isNull objectParent _unit) exitWith {};
if (speed vehicle _unit >= 3) exitWith {};
if (surfaceIsWater (getPosATL _unit)) exitWith {};
if (_unit getVariable ["GRLIB_in_building", false]) exitWith {};
if (_unit getVariable ["LRX_unblock_running", false]) exitWith {};

// Exit if forest / tree
private _forest_type = ["forest", "wood"];
private _typepos = tolower (surfaceType getPosWorld _unit);
private _forest = count (_forest_type select { (_typepos find _x) > -1 }) + count (nearestTerrainObjects [_unit, ["Tree","Small Tree"], 10]);
private _rocks = count (nearestTerrainObjects [_unit, ["ROCK"], 20]);
if (_forest > 0 && _rocks == 0) exitWith {};

// Default
private _basepos = (getPosATL _unit) vectorAdd [0,0,0.5];
private _foundPos = nil;
private _step = 0.25;
private _maxalt = 120;

private _obstacle = count (nearestTerrainObjects [_unit, ["House","Building"], 15]);
if (_obstacle > 0) then { _maxalt = 1.8 };

private _maxpos = _basepos vectorAdd [0,0,_maxalt];
if !(lineIntersects [ATLtoASL _basepos, ATLtoASL _maxpos, _unit]) exitWith {};

_unit setVariable ["LRX_unblock_running", true];

for "_i" from 0 to (_maxalt / _step) do {
    private _z = _maxalt - (_i * _step);
    private _testPos = _basepos vectorAdd [0,0,_z];
    if (lineIntersects [
        ATLtoASL _testPos,
        ATLtoASL _testPos vectorAdd [0,0,-0.05],
        _unit
    ]) exitWith {
        _foundPos = _testPos vectorAdd [0,0,0.5];
    };
};
if (isNil "_foundPos") exitWith {
    diag_log format ["--- LRX Error: unit %1 no free position %2", name _unit, _basePos];
    deleteVehicle _unit;
};

diag_log format ["--- LRX Info: unblock unit %1 position %2", name _unit, _foundPos];
private _state = isDamageAllowed _unit;
_unit allowDamage false;
_unit enableSimulation false;
_unit setPosATL _foundPos;
_unit enableSimulation true;
sleep 1;
_unit switchMove "AmovPercMwlkSrasWrflDf";
_unit playMoveNow "AmovPercMwlkSrasWrflDf";
sleep 2;
_unit setHitPointDamage ["hitLegs", 0];
_unit allowDamage _state;

_unit setVariable ["LRX_unblock_running", false];
