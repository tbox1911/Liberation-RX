if (!isServer && hasInterface) exitWith {};
params ["_unit", "_ammo"];

private _ammo_collected = _unit getVariable ["GREUH_ammo_count", 0];

if (_ammo_collected >= _ammo) then {
    _unit setVariable ["GREUH_ammo_count", (_ammo_collected - _ammo), true];
    _unit setVariable ["trx_complete", 2, true];
    stats_ammo_spent = stats_ammo_spent + _ammo; publicVariable "stats_ammo_spent";
} else {
    _unit setVariable ["trx_complete", 3, true];
};
