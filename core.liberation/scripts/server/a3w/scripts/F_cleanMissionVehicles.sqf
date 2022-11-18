params [["_vehicles",[]], ["_wait", 5]];

 if (typeName _vehicles != "ARRAY") then {
    _vehicles = [_vehicles];
 };

{
    [_x, _wait] spawn {
        params ["_vehicle", "_wait"];
        if (isNil "_vehicle") exitWith {};
        sleep _wait;
        if (typeOf _vehicle isKindOf "AllVehicles") then {
            if ([_vehicle] call is_abandoned) then {
                [_vehicle] call clean_vehicle;
                deleteVehicle _vehicle;
            };
        } else {
            deleteVehicle _vehicle;
        };
    };   

    sleep 1;
} forEach _vehicles;
