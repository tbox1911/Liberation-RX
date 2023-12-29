params ["_unit", "_vehicle"];

if (!local _vehicle) exitWith {};

private ["_role", "_fuel_veh", "_fuel_collected"];
private _conso = 0.002;  // fuel capacity = (((1/_conso) * 5) / 60) in minutes
private _refuel_cost = 5;

if (_vehicle isKindOf "Wheeled_APC_F") then { _conso = 0.003 };
if (_vehicle isKindOf "Tank") then { _conso = 0.004 };
if (_vehicle isKindOf "Air") then { _conso = 0.005 };

while {true} do {
    _role = (assignedVehicleRole _unit) select 0;
    if (isNil "_role") exitWith {};
    if (_role != "driver" || isNull objectParent _unit) exitWith {};

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
                gamelogic globalChat "Resource Fuel used...";
            };
        };
        _vehicle setFuel (_fuel_veh - _conso) max 0;
    };
    sleep 5;
};
