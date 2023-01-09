params ["_unit"];
if (isDedicated || (!hasInterface && !isServer)) exitWith {};
if (lifestate player == "INCAPACITATED") exitWith {};
if (player distance2D _unit > 300) exitWith {};

private _randomsound1 = selectRandom [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
if (_randomsound1 < 10) then { _randomsound1 = format ["0%1", _randomsound1]};

private _deathsound = format ["A3\sounds_f\characters\human-sfx\P%1\hit_max_%2.wss",_randomsound1, selectRandom [1,2,3]];
playSound3D [_deathsound, _unit, false, getPosASL _unit, 4, 1, 300];
