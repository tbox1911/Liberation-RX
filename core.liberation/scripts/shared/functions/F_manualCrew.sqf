params ["_vehicle", "_grp"];

private _vehicle_roles = [];
{ _vehicle_roles pushBack (_x select 1)} forEach (fullCrew [_vehicle, "", true]);
if (count (units _grp) > count _vehicle_roles) then { diag_log format ["--- LRX Error: group too large for vehicle %1", typeOf _vehicle]};

{
    if (_forEachIndex > count _vehicle_roles) then {
        diag_log format ["--- LRX Error: unit %1 deleted!", name _x];
        deleteVehicle _x;
    } else {
        private _assigned = false;
        private _role = _vehicle_roles select _forEachIndex;

        if (_role == "driver") then {
            _x assignAsDriver _vehicle;
            _x moveInDriver _vehicle;
            _assigned = true;
        };
        if (_role == "commander") then {
            _x assignAsCommander _vehicle;
            _x moveInCommander _vehicle;
            _assigned = true;
        };
        if (_role == "gunner") then {
            _x assignAsGunner _vehicle;
            _x moveInGunner _vehicle;
            _assigned = true;
        };
        if (!_assigned) then {
            _x assignAsCargo _vehicle;
            _x moveInCargo _vehicle;
        };
        sleep 0.1;
    };
} forEach (units _grp);

(units _grp) allowGetIn true;
(units _grp) orderGetIn true;
(group _vehicle) addVehicle _vehicle;
