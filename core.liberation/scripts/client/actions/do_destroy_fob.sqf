_fob_pos = _this select 3;
if (isNil "_fob_pos") exitWith {};

_msg = format ["<t align='center'>Destroy the Outpost<br/>Are you sure ?</t>"];
_result = [_msg, "Warning !", true, true] call BIS_fnc_guiMessage;
if (_result) then {
	[_fob_pos, false] remoteExec ["destroy_fob_remote_call", 0];
};
