private _fob_pos = [] call F_getNearestFob;
private _fob_owner = [_fob_pos] call F_getFobOwner;
private _fob_name = [_fob_pos] call F_getFobName;
if (PAR_Grp_ID != _fob_owner) exitWith { hintSilent "Error!\nYour are NOT the owner of the Outpost!" };

if (count (GRLIB_all_fobs - GRLIB_all_outposts) >= GRLIB_max_fobs) exitWith {
	hint format [localize "STR_HINT_FOBS_EXCEEDED", GRLIB_max_fobs];
};

private _cost = 1000;
private _result = [format [localize "STR_UPGRADE_OUTPOST_PAY", _cost], localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
if (!_result) exitWith {};
if (!([_cost] call F_pay)) exitWith {};

player setPos (player getPos [5, (getDir player) - 180]);
sleep 2;
[_fob_pos, PAR_Grp_ID] remoteExec ["upgrade_fob_remote_call", 2];

hintSilent format ["%1 %2 "+ localize "STR_UPGRADE_OUTPOST_HINT", "Outpost", _fob_name];
