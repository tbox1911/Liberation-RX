params ["_unit"];
if (isDedicated || (!hasInterface && !isServer)) exitWith {};
if (lifestate player == "INCAPACITATED") exitWith {};
if (player distance2D _unit > 300) exitWith {};

private _deathsound = format ["A3\sounds_f\characters\human-sfx\P%1\hit_max_%2.wss", selectRandom ["03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18"], selectRandom [1,2,3]];
playSound3D [_deathsound, _unit, false, getPosASL _unit, 4, 1, 300];
