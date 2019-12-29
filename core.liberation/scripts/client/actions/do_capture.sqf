_prisonner = _this select 3;
if (isNil "_prisonner") exitWith {};

[ _prisonner ] join group player;
_prisonner addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
_prisonner addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];
_prisonner addEventHandler ["Take", {removeAllWeapons (_this select 0)}];
_prisonner setVariable ["GRLIB_is_prisonner", false, true];
[ [ _prisonner ], "remote_call_prisonner", _prisonner ] call bis_fnc_mp;