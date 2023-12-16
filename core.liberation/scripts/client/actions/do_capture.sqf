params ["_unit"];
if (isNull _unit) exitWith {};

[ _unit ] join group player;
_unit addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["Take", {removeAllWeapons (_this select 0)}];
_unit setVariable ["GRLIB_is_prisoner", false, true];
_unit setVariable ["GRLIB_counter_TTL", nil, true];
_unit stop false;
_unit enableAI "ANIM";
_unit enableAI "MOVE";
_anim = "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
[_unit, _anim] remoteExec ["switchMove", 0];
[_unit, _anim] remoteExec ["playMoveNow", 0];
