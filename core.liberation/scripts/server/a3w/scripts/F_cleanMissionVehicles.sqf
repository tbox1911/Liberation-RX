params [["_vehicles",[]], ["_wait", false]];

 if (typeName _vehicles != "ARRAY") then {
    _vehicles = [_vehicles];
 };

{
    [_x, _wait] spawn {
        params ["_vehicle", "_wait"];
        if (isNil "_vehicle") exitWith {};
        if (_wait) then {
            waitUntil { sleep 30; (GRLIB_global_stop == 1 || [getPosATL _vehicle, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
        };

        if (_vehicle isKindOf "AllVehicles") then {
             if (_vehicle getVariable ["GRLIB_vehicle_owner", ""] == "server") then {
                _vehicle setVariable ["GRLIB_vehicle_owner", ""];
             };
            [_vehicle] call clean_vehicle;
        } else {
            deleteVehicle _vehicle;
        };
    };
    sleep 0.3;
} forEach _vehicles;
