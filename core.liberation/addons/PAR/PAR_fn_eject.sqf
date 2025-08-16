params ["_unit", "_vehicle"];

if (_vehicle iskindof "ParachuteBase") exitWith {};

// No eject when driving
waitUntil {
    sleep 0.2;
    ((round (speed vehicle _vehicle) == 0 && (round (getPosATL _vehicle select 2) < 5)) || ([_vehicle] call F_getVehicleDamage) > 0.3 || driver _vehicle == _unit)
};
[_unit, false] spawn F_ejectUnit;
