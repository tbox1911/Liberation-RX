if (!isServer && hasInterface) exitWith {};
params ["_unit", "_ammo", "_fuel"];

waitUntil { _unit getVariable ["GRLIB_score_set", 0] == 1};
waitUntil { _unit getVariable ["trx_complete", 0] != 1 };

private _ammo_collected = _unit getVariable ["GREUH_ammo_count", 0];
private _fuel_collected = _unit getVariable ["GREUH_fuel_count", 0];

_unit setVariable ["GREUH_ammo_count", (_ammo_collected + _ammo), true];
_unit setVariable ["GREUH_fuel_count", (_fuel_collected + _fuel), true];
_unit setVariable ["trx_complete", 2, true];
