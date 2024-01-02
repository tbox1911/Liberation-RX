if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_data"];

private _enemy_nearby = [player, GRLIB_sector_size, GRLIB_side_enemy] call F_getUnitsCount;
if (_enemy_nearby > 0 || (behaviour player) in [ "COMBAT", "STEALTH"]) exitWith {};
_data spawn BIS_fnc_dynamicText;
