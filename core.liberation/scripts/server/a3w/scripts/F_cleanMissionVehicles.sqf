params [["_vehicles",[]], ["_wait", 5], ["_force", false]];

 if (typeName _vehicles != "ARRAY") then {
    _vehicles = [_vehicles];
 };

{
    [_x, _wait, _force] spawn {
        params ["_vehicle", "_wait", "_force"];
        if (isNil "_vehicle") exitWith {};
        sleep _wait;
        if (typeOf _vehicle isKindOf "AllVehicles") then {
            if ( (count (crew _vehicle) == 0 || _force) && (_vehicle getVariable ["GRLIB_vehicle_owner", ""]) in ["", "server"]) then {
                [_vehicle] spawn clean_vehicle;
            };
        } else {
            deleteVehicle _vehicle;
        };
    };   

    sleep 0.3;
} forEach _vehicles;
