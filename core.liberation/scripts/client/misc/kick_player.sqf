_uid = getPlayerUID player;
BTC_teamkiller = 99;
BTC_logic setVariable [_uid, BTC_teamkiller, true];
[] spawn BTC_Teamkill;
diag_log format ["TKP: BAN for player %1 - %2", name player, _uid];