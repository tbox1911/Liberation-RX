params ["_unit"];
if (isNull _unit) exitWith {};

waitUntil {
    [_unit] joinSilent (group player);
    gamelogic globalChat format ["Capturing prisoner %1...", name _unit];
    sleep 2;
    (local _unit && _unit in (units player));
};
if (!alive _unit) exitWith {};

_unit removeAllEventHandlers "GetInMan";
_unit removeAllEventHandlers "SeatSwitchedMan";
_unit removeAllEventHandlers "Take";
_unit addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["Take", {removeAllWeapons (_this select 0)}];
_unit setVariable ["GRLIB_prisoner_owner", player, true];
_unit setVariable ["GRLIB_is_prisoner", false, true];
_unit setVariable ["GRLIB_counter_TTL", nil, true];
[_unit] joinSilent (group player);
