_fob_pos = _this select 3;
if (isNil "_fob_pos") exitWith {};

private _fob_owner = [_fob_pos] call F_getFobOwner;
private _fob_name = [_fob_pos] call F_getFobName;
if (getPlayerUID player != _fob_owner) exitWith { hintSilent "Error!\nYour are NOT the owner of the Outpost!" };

build_confirmed = 1;
private _msg = format [localize "STR_DO_DESTROYFOB"];
private _result = [_msg, localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
if (_result) then {
	[_fob_pos] remoteExec ["destroy_fob_remote_call", 2];
	hintSilent format ["%1 %2 "+ localize "STR_FOB_REPACKAGE_HINT", "Outpost", _fob_name];
	sleep 2;
};

sleep 2;
build_confirmed = 0;