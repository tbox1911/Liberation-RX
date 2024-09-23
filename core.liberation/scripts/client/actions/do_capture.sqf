params ["_unit"];
if (isNull _unit) exitWith {};

[_unit] join group player;
_unit removeAllEventHandlers "GetInMan";
_unit addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
_unit removeAllEventHandlers "SeatSwitchedMan";
_unit addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];
_unit removeAllEventHandlers "Take";
_unit addEventHandler ["Take", {removeAllWeapons (_this select 0)}];
_unit setVariable ["GRLIB_prisoner_owner", player, true];
_unit setVariable ["GRLIB_is_prisoner", false, true];
_unit setVariable ["GRLIB_counter_TTL", nil, true];
[_unit, "move"] remoteExec ["remote_call_prisoner", 0];
