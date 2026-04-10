if (!isServer && hasInterface) exitWith {};
params ["_truck" ,"_ammobox", "_caller"];

if (isNil "_truck") exitWith {};
if (isNull _truck) exitWith {};
if (!isNil "GRLIB_load_box") exitWith {};

GRLIB_load_box = true;

_truck setOwner 2;
_ammobox setOwner 2;
sleep 1;

private _owner = (owner _caller);
private _ret = [_truck, _ammobox, false] call attach_object_direct;

if (isNull _ret) then {
    private _msg = format [localize "STR_BOX_LOADED", [typeOf _ammobox] call F_getLRXName];
    [_msg] remoteExec ["hintSilent", _owner];
};

if (_owner != 0) then {
    _truck setOwner _owner;
    _ammobox setOwner _owner;
};

sleep 1;
GRLIB_load_box = nil;
