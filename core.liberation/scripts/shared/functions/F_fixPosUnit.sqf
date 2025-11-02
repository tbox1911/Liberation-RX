// Fix unit position when blocked in rock/ruins/object
// by pSiKO - (thanks Larrow)

params ["_unit"];

if (!local _unit || !alive _unit) exitWith {};
if (!isNull objectParent _unit) exitWith {};
if (speed vehicle _unit >= 3) exitWith {};
if (_unit getVariable ["GRLIB_in_building", false]) exitWith {};
if (round (getPosATL _unit select 2) > 2) exitWith {};
if (underwater vehicle _unit) exitWith { deleteVehicle _unit };
if (surfaceIsWater (getPosATL _unit)) exitWith {};

// Exit if forest / tree
private _forest_type = ["forest", "wood"];
private _typepos = tolower (surfaceType getPosWorld _unit);
private _forest = count (_forest_type select { (_typepos find _x) > -1 });
_forest = _forest + count (nearestTerrainObjects [_unit, ["Tree","Small Tree"], 10]);
private _obstacle_rock = count (nearestTerrainObjects [_unit, ["ROCK"], 20]);
if (_forest > 0 && _obstacle_rock == 0) exitWith {};

// Default
private _curalt = 0;
private _maxalt = 100;
private _obstacle = count (nearestTerrainObjects [_unit, ["House","Building"], 15]);
if (_obstacle > 0) then { _maxalt = 2.0 };
private _spawnpos = (getPosASL _unit) vectorAdd [0,0,0.5];
private _maxpos = _spawnpos vectorAdd [0,0,_maxalt];

if !(lineIntersects [_spawnpos, _maxpos, _unit]) exitWith {};

while { (lineIntersects [_spawnpos, _maxpos, _unit]) && _curalt < _maxalt } do {
	_curalt = _curalt + 0.5;
	_spawnpos = (_spawnpos vectorAdd [0,0,_curalt]);
};

if (lineIntersects [_spawnpos, (_spawnpos vectorAdd [0,0,_maxalt]), _unit]) exitWith {
	diag_log format ["--- LRX Error: unit %1 is still blocked at %2...", name _unit, getpos _unit];
	deleteVehicle _unit;
};


private _state = isDamageAllowed _unit;
_unit allowDamage false;
sleep 0.5;
_unit setPosASL _spawnpos;
_unit setHitPointDamage ["hitLegs", 0];
sleep 0.5;
_unit allowDamage _state;
