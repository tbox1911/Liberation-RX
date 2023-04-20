params ["_target", "_caller", "_actionId", "_killer"];

private _msg = format ["<t align='center'>" + localize "STR_TK_ASK1" + "</t>", name _killer];
private _result = [_msg, localize "STR_TK_COUNT", localize "STR_TK_PUNISH", localize "STR_TK_FORGIVE"] call BIS_fnc_guiMessage;
if (_result) then {
	_uid = getPlayerUID _killer;
	if (_uid == "") then { _uid = "server"};
	_kill = BTC_logic getVariable [_uid, 0];
	BTC_logic setVariable [_uid, (_kill + 1), true];
	_msg = format [localize "STR_TK_MSG1", name _target, name _killer];
	[_killer, _target] remoteExec ["LRX_tk_actions",[0,-2] select isDedicated];
} else {
	_msg = format [localize "STR_TK_MSG2", name _target, name _killer];
};

[gamelogic, _msg] remoteExec ["globalChat", 0];
player removeAction _actionId;
LRX_tk_player_action = LRX_tk_player_action - 1;
hintSilent "";