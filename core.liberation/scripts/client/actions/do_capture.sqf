params ["_prisonner"];
if (isNil "_prisonner") exitWith {};

[ _prisonner ] join group player;
_prisonner addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
_prisonner addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];
_prisonner addEventHandler ["Take", {removeAllWeapons (_this select 0)}];
_prisonner setVariable ["GRLIB_is_prisonner", false, true];