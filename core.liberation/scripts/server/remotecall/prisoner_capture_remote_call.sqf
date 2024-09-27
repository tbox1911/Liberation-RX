params ["_unit", "_player"];

if (!local _unit) exitWith {
    [_unit, _player] remoteExec ["prisoner_capture_remote_call", owner _unit];
};

[_unit] join (group _player);

_unit removeAllEventHandlers "GetInMan";
_unit removeAllEventHandlers "SeatSwitchedMan";
_unit removeAllEventHandlers "Take";

_unit addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["Take", {removeAllWeapons (_this select 0)}];

_unit setVariable ["GRLIB_prisoner_owner", _player, true];
_unit setVariable ["GRLIB_is_prisoner", false, true];
_unit setVariable ["GRLIB_counter_TTL", nil, true];

[_unit, "move"] remoteExec ["remote_call_prisoner", 0];
[_unit] joinSilent (group _player);
