if (!isServer && hasInterface) exitWith {};
params ["_pos"];

_pos set [2, 0];
{
    _x hideObjectGlobal true;
    _x enableSimulationGlobal false;
    deleteVehicle _x;
} forEach (nearestTerrainObjects [_pos, GRLIB_clutter_cutter, 20]);
