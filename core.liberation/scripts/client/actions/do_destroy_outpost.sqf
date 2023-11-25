private _fob_pos = [] call F_getNearestFob;
private _fob_owner = [_fob_pos] call F_getFobOwner;
private _fob_name = [_fob_pos] call F_getFobName;
if ((PAR_Grp_ID != _fob_owner) && !([] call is_admin)) exitWith { hintSilent localize "STR_HINT_OUTPOST_WRONG_OWNER" };
if (player distance2D _fob_pos > 20) exitWith {};

build_confirmed = 1;
private _msg = format [localize "STR_DO_DESTROYFOB"];
private _result = [_msg, localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
if (_result) then {
	[_fob_pos] remoteExec ["destroy_fob_remote_call", 2];
	hintSilent format ["%1 %2 "+ localize "STR_FOB_REPACKAGE_HINT", "Outpost", _fob_name];
};

sleep 2;
build_confirmed = 0;