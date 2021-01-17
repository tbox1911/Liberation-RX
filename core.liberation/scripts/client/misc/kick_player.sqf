_uid = getPlayerUID player;
BTC_logic setVariable [_uid, 99, true];
[] spawn LRX_tk_actions;
diag_log format ["-- LRX TK: BAN for player %1 - %2", name player, _uid];