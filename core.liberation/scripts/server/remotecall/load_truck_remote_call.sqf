if (!isServer && hasInterface) exitWith {};
params ["_truck" ,"_ammobox", "_caller"];

if (isNil "_truck") exitWith {};
if (isNull _truck) exitWith {};
if (!isNil "GRLIB_load_box") exitWith {};

GRLIB_load_box = true;
[_truck, _ammobox, false] call attach_object_direct;

private _msg = format [localize "STR_BOX_LOADED", [typeOf _ammobox] call F_getLRXName];
[_msg] remoteExec ["hintSilent", owner _caller];

sleep 1;
GRLIB_load_box = nil;
