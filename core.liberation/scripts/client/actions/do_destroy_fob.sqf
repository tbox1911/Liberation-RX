_fob_pos = _this select 3;
if (isNil "_fob_pos") exitWith {};

_msg = format [localize "STR_DO_DESTROYFOB"];
_result = [_msg, localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
if (_result) then {
	[_fob_pos, false] remoteExec ["destroy_fob_remote_call", 0];
};
