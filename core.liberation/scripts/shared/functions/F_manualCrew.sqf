params ["_vehicle", "_units", ["_delete", true]];

private _vehicle_roles = [];
{ _vehicle_roles pushBack (_x select 1)} forEach (fullCrew [_vehicle, "", true] - fullCrew _vehicle);
if (count _units > count _vehicle_roles) then { diag_log format ["--- LRX Error: group too large for vehicle %1", typeOf _vehicle]};

private _lock = locked _vehicle;
_vehicle lock 0;

private _cargo_indx = 1;
{
    if (_forEachIndex >= count _vehicle_roles) then {
        if (_delete) then {
            diag_log format ["--- LRX crew overload: unit %1 deleted!", name _x];
            deleteVehicle _x;
        };
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
            
            _x assignAsCargoIndex [_vehicle, _cargo_indx];
            _x moveInCargo _vehicle;
            _cargo_indx = _cargo_indx + 1;
        };
        if (!_delete) then { sleep 0.2 };
    };
} forEach _units;

_units allowGetIn true;
_units orderGetIn true;

_vehicle lock _lock;
sleep 1;
