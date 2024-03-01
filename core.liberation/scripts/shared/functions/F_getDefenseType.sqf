params ["_sector"];
private _ret = 0;
private _index = { if ((_x select 0) == _sector) exitWith { _forEachIndex } } forEach GRLIB_sector_defense;
if (!isNil "_index") then { _ret = GRLIB_sector_defense select _index select 1 };
_ret;
