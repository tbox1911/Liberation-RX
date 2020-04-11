//waitUntil { !isNil "GRLIB_permissions" };
private [ "_dialog", "_players_array" ];

_players_array = [];
_dialog = createDialog "liberation_cheat";
waitUntil { dialog };
disableSerialization;
_ctrl = (findDisplay 5204) displayCtrl 1607;

if (!isDamageAllowed player) then {
	_ctrl ctrlSetChecked true;
} else {
	_ctrl ctrlSetChecked false;
};
player onMapSingleClick "if (_alt) then {player setPosATL _pos}";

do_unban = 0;
do_score = 0;
_display = findDisplay 5204;
_player_combo = _display displayCtrl 1611;
lbClear _player_combo;
_player_combo2 = _display displayCtrl 1612;
lbClear _player_combo2;

_i = 0;
{
	_player_combo lbAdd format["%1", name _x];
	_player_combo lbSetData [_i, getPlayerUID _x];
	_player_combo2 lbAdd format["%1", name _x];
	_player_combo2 lbSetData [_i, getPlayerUID _x];
	_i = _i + 1;
} foreach AllPlayers;

_player_combo lbSetCurSel 0;
_player_combo2 lbSetCurSel 0;

while { dialog && (alive player) } do {
	if (do_unban == 1) then {
		_dst_name = _player_combo lbText (lbCurSel _player_combo);
		_dst_id = _player_combo lbData (lbCurSel _player_combo);
		BTC_logic setVariable [_dst_id, 0, true];
		systemchat format ["Unban player: %1 UID:%2", _dst_name, _dst_id];
		sleep 1;
		do_unban = 0;
	};

	if (do_score == 1) then {
		_dst_name = _player_combo2 lbText (lbCurSel _player_combo2);
		_dst_id = _player_combo2 lbData (lbCurSel _player_combo2);
		_player = objNull;
		{
			if (getPlayerUID _x == _dst_id) exitWith { _player = _x };
		} forEach allPlayers;

		if (!isNull _player) then {
			[_player, 200] remoteExec ['addScore', 2];
			systemchat format ["Add 200 pts to %1 score", _dst_name];
			sleep 1;
		};
		do_score = 0;
	};
	sleep 0.5;
};
closeDialog 0;
hintSilent "";