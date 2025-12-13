params ["_target", "_caller", "_actionId", "_arguments"];

if (count GRLIB_vehicle_need_support == 0) exitWith {};

private ["_vehicle", "_task", "_type", "_name", "_verb", "_cost", "_result"];

private _distarsenal = 30;
{
    _vehicle = _x;
    if (!isNull _vehicle) then {
        _task = _vehicle getVariable "GRLIB_vehicle_need_support";
        if (!isNil "_task") then {
            {
                _type = _x;
                _cost = 0;

                switch (_type) do {
                    case 1: {
                        _verb = "Repair";
                        if ([_vehicle, "FOB", _distarsenal, true] call F_check_near) then { _cost = 80 };
                        if ([_vehicle, "REP", _distarsenal, false] call F_check_near) then {_cost = 50 };
                    };
                    case 2: {
                        _verb = "Rearm";
                        if ([_vehicle, "FOB", _distarsenal, true] call F_check_near) then { _cost = 50 };
                    };
                    case 3: {
                        _verb = "Refuel";
                        if ([_vehicle, "FOB", _distarsenal, true] call F_check_near) then { _cost = 80 };
					    if ([_vehicle, "FUEL", _distarsenal, false] call F_check_near) then { _cost = 50 };
                    };
                };

                _result = [format ["Do you want to %1 %2 for %3 Ammo ?", _verb, ([_vehicle] call F_getLRXName), _cost], localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
                if (_result) then {
                    _vehicle setVariable ["GRLIB_vehicle_need_support", nil];
                    [_vehicle, _type, _cost] call F_vehicleSupport;
                };
                sleep 0.5;
            } forEach _task;
        };
    };
    sleep 1;
} forEach GRLIB_vehicle_need_support;
