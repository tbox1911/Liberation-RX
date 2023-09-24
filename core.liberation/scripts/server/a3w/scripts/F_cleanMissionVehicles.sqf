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
            private _not_towed = (isNull (_vehicle getVariable ["R3F_LOG_est_transporte_par", objNull]));
            private _server_owned = (_vehicle getVariable ["GRLIB_vehicle_owner", ""] in ["", "server"]);
            private _no_blu_inside = ({(alive _x && side group _x == GRLIB_side_friendly)} count (crew _vehicle) == 0);

            if ( _no_blu_inside && _server_owned && _not_towed) then {
                { deleteVehicle _x } forEach (crew _vehicle);
                deleteVehicle _vehicle;
            };
        } else {
            deleteVehicle _vehicle;
        };
    };   

    sleep 0.3;
} forEach _vehicles;
