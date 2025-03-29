params ["_unit", "_vehicle"];

if (!local _vehicle) exitWith {};
if (isNull _vehicle) exitWith {};
_vehicle removeAllEventHandlers "Fuel";

private ["_fuel_veh", "_fuel_collected"];
private _conso = 0.002;  // fuel capacity = (((1/_conso) * 5) / 60) in minutes
private _refuel_cost = 5;

if (_vehicle isKindOf "Wheeled_APC_F") then { _conso = 0.003 };
if (_vehicle isKindOf "Tank") then { _conso = 0.004 };
if (_vehicle isKindOf "Air") then { _conso = 0.0045 };
_conso = (_conso * GRLIB_vehicles_fuel);

_vehicle setVariable ["GREUH_vehicle_fuel_managed", true];
while {!(isNull _vehicle) && (_unit == driver _vehicle)} do {
    if (speed vehicle _vehicle > 1) then {
        _fuel_veh = fuel _vehicle;
        if (_fuel_veh < 0.010) then {
            _fuel_collected = player getVariable ["GREUH_fuel_count", 0];
            if (_fuel_collected >= _refuel_cost) then {
                _fuel_veh = 0.10;
                if (typeOf _vehicle isKindOf "Air") then {
                    _fuel_veh = 0.20;
                };
                player setVariable ["GREUH_fuel_count", (_fuel_collected - _refuel_cost), true];
                gamelogic globalChat format [localize "STR_LOG_RESOURCE_FUEL_USED", _refuel_cost];
            };
        };
        _vehicle setFuel (_fuel_veh - _conso) max 0;
    };
    sleep 5;
};
_vehicle setVariable ["GREUH_vehicle_fuel_managed", nil];
