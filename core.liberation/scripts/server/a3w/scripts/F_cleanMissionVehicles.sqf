params [["_vehicles",[]], ["_wait", 5]];

 if (typeName _vehicles != "ARRAY") then {
    _vehicles = [_vehicles];
 };

{
    [_x, _wait] spawn {
        params ["_vehicle", "_wait"];
        if (isNil "_vehicle") exitWith {};
        sleep _wait;
      
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
