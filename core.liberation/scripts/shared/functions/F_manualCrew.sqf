params ["_vehicle", "_units", ["_delete", true]];

private _vehicle_roles = [];
{ _vehicle_roles pushBack (_x select 1)} forEach (fullCrew [_vehicle, "", true] - fullCrew _vehicle);
if (count _units > count _vehicle_roles) then { gamelogic globalchat format ["Group too large for vehicle %1", [_vehicle] call F_getLRXName]};

private _role_order = ["driver", "commander", "gunner", "turret", "cargo"];
private _vehicle_roles_sorted = [];
{
    private _r = _x;
    { if (_x == _r) then { _vehicle_roles_sorted pushBack _x } } forEach _vehicle_roles;
} forEach _role_order;
_vehicle_roles = _vehicle_roles_sorted;

if (!local _vehicle) then {
	if (count crew _vehicle == 0) then {
		[_vehicle, clientOwner] remoteExec ["setOwner", 2];
	} else {
		private _grp = group (crew _vehicle select 0);
		[_grp, clientOwner] remoteExec ["setGroupOwner", 2];
	};
	waitUntil { sleep 0.2; local _vehicle };
    sleep 1;
};

private _turrets = (allTurrets [_vehicle, true]) select { isNull (_vehicle turretUnit _x)};
private _lock = locked _vehicle;
private _indx = 0;
_vehicle lock 0;
_units allowGetIn true;

{
    if (_forEachIndex >= count _vehicle_roles) then {
        if (_delete) then {
            diag_log format ["--- LRX crew overload: unit %1 deleted!", name _x];
            deleteVehicle _x;
        };
    } else {
        private _role = _vehicle_roles select _forEachIndex;
        if (_role == "driver") then {
            _x assignAsDriver _vehicle;
            _x moveInDriver _vehicle;
        };
        if (_role == "commander") then {
            _x assignAsCommander _vehicle;
            _x moveInCommander _vehicle;
        };
        if (_role == "gunner") then {
            _x assignAsGunner _vehicle;
            _x moveInGunner _vehicle;
            _indx = _indx + 1;
        };
        if (_role == "turret") then {
            _x assignAsTurret [_vehicle, (_turrets select _indx)];
            _x moveInTurret [_vehicle, (_turrets select _indx)];
            _indx = _indx + 1;
        };
        if (_role == "cargo") then {
            _x assignAsCargo _vehicle;
            _x moveInCargo _vehicle;
        };
        if (!_delete) then { sleep 0.5 };
    };
} forEach _units;

_vehicle lock _lock;
sleep 1;
