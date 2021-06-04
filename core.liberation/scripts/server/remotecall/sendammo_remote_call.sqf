if (!isServer && hasInterface) exitWith {};
params ["_src", "_dst_id", "_ammo"];
private ["_dst", "_src_ammo", "_dst_ammo"];

_dst = _dst_id call BIS_fnc_getUnitByUID;
if (isNull _dst || !isPlayer _src || !isPlayer _dst || _src == _dst) exitWith {};

_src_ammo = _src getVariable ["GREUH_ammo_count",0];
if (_src_ammo < _ammo) exitWith {};
_text = format ["Send %1 AMMO to %2", _ammo, name _dst];
_src setVariable ["GREUH_ammo_count", (_src_ammo - _ammo), true];
[gamelogic, _text] remoteExec ["globalChat", owner _src];

_dst_ammo = _dst getVariable ["GREUH_ammo_count",0];
_text = format ["Recv %1 AMMO from %2", _ammo, name _src];
_dst setVariable ["GREUH_ammo_count", (_dst_ammo + _ammo), true];
[gamelogic, _text] remoteExec ["globalChat", owner _dst];
