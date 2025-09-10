params ["_target", "_caller", "_actionId", "_killer_uid"];

private _killer = _killer_uid call BIS_fnc_getUnitByUID;
private _killer_name = _killer_uid;
if (!isNull _killer) then {
	_killer_name = name _killer;
};

private _msg = format ["<t align='center'>" + localize "STR_TK_ASK1" + "</t>", _killer_name];
private _result = [_msg, localize "STR_TK_COUNT", localize "STR_TK_PUNISH", localize "STR_TK_FORGIVE"] call BIS_fnc_guiMessage;
if (_result) then {
	private _kill = 1 + (BTC_logic getVariable [_killer_uid, 0]);
	BTC_logic setVariable [_killer_uid, _kill, true];
	_msg = format [localize "STR_TK_MSG1", name _target, _killer_name];
	[_killer, _target] remoteExec ["LRX_tk_server_actions", 2];
} else {
	_msg = format [localize "STR_TK_MSG2", name _target, _killer_name];
};

[gamelogic, _msg] remoteExec ["globalChat", 0];
player removeAction _actionId;
LRX_tk_player_action = LRX_tk_player_action - 1;
hintSilent "";