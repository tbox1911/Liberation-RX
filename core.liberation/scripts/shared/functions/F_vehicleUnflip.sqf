params ["_vehicle", ["_force", false]];

if !(_vehicle isKindOf "LandVehicle" || _vehicle isKindOf "StaticWeapon") exitWith {};
if !(isNull (_vehicle getVariable ["R3F_LOG_est_transporte_par", objNull])) exitWith {};
if (surfaceIsWater (getPos _vehicle)) exitWith {};

if (vectorUp _vehicle select 2 < 0.60) then {
    _vehicle setpos [(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, 0.5];
    _vehicle setVectorUp surfaceNormal position _vehicle;
};

if (getPosATL _vehicle select 2 < -0.50 || _force) then {
    _vehicle setpos (getpos _vehicle);
};
