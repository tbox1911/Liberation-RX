if (GRLIB_vehicles_fuel == 0) exitWith {};
waitUntil { sleep 1; !isNil "blufor_sectors" };

private ["_unitList", "_unit", "_vehicle", "_unmanaged"];

while {true} do {
    _unitList = (units group player) select { local _x && lifeState _x != "INCAPACITATED" };
    {
        _unit = _x;
        _vehicle = objectParent _unit;
        _unmanaged = isNil {_vehicle getVariable "GREUH_vehicle_fuel_managed"};
        if (local _vehicle && !(isNull _vehicle) && _unmanaged && _unit == driver _vehicle) then {
            [_unit, _vehicle] spawn vehicle_fuel;
        };
        sleep 0.5;
    } forEach _unitList;
    sleep 3;
};
