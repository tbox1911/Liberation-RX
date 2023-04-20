if (!isServer && hasInterface) exitWith {};

params ["_pos"];
{_x hideObjectGlobal true} forEach (nearestTerrainObjects [_pos, GRLIB_clutter_cutter, 20]);
