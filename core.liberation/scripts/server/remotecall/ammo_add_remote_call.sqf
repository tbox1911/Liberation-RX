if (!isServer && hasInterface) exitWith {};
params ["_unit", "_ammo", "_fuel"];

diag_log format ["--- LRX DBG: start ammo_add to Player:%1 Ammo:%2 Fuel:%3", name _unit, _ammo, _fuel];

waitUntil { _unit getVariable ["GRLIB_score_set", 0] == 1};
waitUntil { _unit getVariable ["trx_complete", 0] != 1 };

private _ammo_collected = _unit getVariable ["GREUH_ammo_count", 0];
private _fuel_collected = _unit getVariable ["GREUH_fuel_count", 0];

diag_log format ["--- LRX DBG: current ammo_add from Player:%1 Ammo:%2 Fuel:%3", name _unit, _ammo_collected, _fuel_collected];

_unit setVariable ["GREUH_ammo_count", (_ammo_collected + _ammo), true];
_unit setVariable ["GREUH_fuel_count", (_fuel_collected + _fuel), true];
_unit setVariable ["trx_complete", 2, true];

diag_log format ["--- LRX DBG: end ammo_add to player %1", name _unit];