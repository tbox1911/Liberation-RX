if (!isServer && hasInterface) exitWith {};
params ["_src", "_dst_id", "_ammo", "_fuel"];

private _dst = _dst_id call BIS_fnc_getUnitByUID;
if (isNull _dst || !isPlayer _src || !isPlayer _dst || _src == _dst) exitWith {};

private _src_ammo = _src getVariable ["GREUH_ammo_count",0];
private _src_fuel = _src getVariable ["GREUH_fuel_count",0];
if (_src_ammo < _ammo) exitWith {};
if (_src_fuel < _fuel) exitWith {};
_src setVariable ["GREUH_ammo_count", (_src_ammo - _ammo), true];
_src setVariable ["GREUH_fuel_count", (_src_fuel - _fuel), true];

private _dst_ammo = _dst getVariable ["GREUH_ammo_count",0];
private _dst_fuel = _dst getVariable ["GREUH_fuel_count",0];
_dst setVariable ["GREUH_ammo_count", (_dst_ammo + _ammo), true];
_dst setVariable ["GREUH_fuel_count", (_dst_fuel + _fuel), true];

private _text = format ["Send %1 AMMO and %2 FUEL to %3", _ammo, _fuel, name _dst];
[gamelogic, _text] remoteExec ["globalChat", owner _src];

private _text = format ["Receive %1 AMMO and %2 FUEL from %3", _ammo, _fuel, name _src];
[gamelogic, _text] remoteExec ["globalChat", owner _dst];
