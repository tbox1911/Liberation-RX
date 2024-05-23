if (!isServer && hasInterface) exitWith {};
params ["_pos"];

{
    _x enableSimulationGlobal false;
    _x hideObjectGlobal true;
    deleteVehicle _x;
} forEach (nearestTerrainObjects [_pos, GRLIB_clutter_cutter, 20]);
