params ["_target", "_caller", "_actionId", "_killer"];

_msg = format ["<t align='center'>Do you want to Punish %1 ?</t>", name _killer];
_result = [_msg, "Warning !", true, true] call BIS_fnc_guiMessage;
if (_result) then {
	_kill = BTC_logic getVariable [getPlayerUID _killer, 0];
	BTC_logic setVariable [getPlayerUID _killer, ()_kill + 1), true];
	hintSilent "TK: %1 punish %2."; //rexec // STR_TK_MSG1
} else {

	hintSilent "TK: %1 forgive %2."; //STR_TK_MSG2
};

player removeAction _actionId;