params ["_unit", "_vehicle"];

private ["_role", "_fuel_veh", "_fuel_collected"];
private _conso = 0.003;  // fuel capacity = (((1/_conso) * 5) / 60) in minutes

if (_vehicle isKindOf "APC") then { _conso = 0.004 };
if (_vehicle isKindOf "Tank") then { _conso = 0.005 };
if (_vehicle isKindOf "Air") then { _conso = 0.006 };

while {true} do {
    _role = (assignedVehicleRole _unit) select 0;
    if (isNil "_role") exitWith {};
    if (_role != "driver" || isNull objectParent _unit) exitWith {};

    if (speed vehicle _vehicle > 1) then {
        _fuel_veh = fuel _vehicle;
        if (_fuel_veh < 0.010) then {
            _fuel_collected = player getVariable ["GREUH_fuel_count", 0];
            if (_fuel_collected > 1) then {
                _fuel_veh = 0.06;
                _unit setVariable ["GREUH_fuel_count", (_fuel_collected - 1), true];
                gamelogic globalChat "Resource Fuel used...";
            };
        };
        _vehicle setFuel (_fuel_veh - _conso) max 0;
    };
    sleep 5;
};
