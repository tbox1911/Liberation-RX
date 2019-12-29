_uid = getPlayerUID player;
if (BTC_logic getVariable [_uid, 0] < 50) then {
	["", 0, 0, 0, 0, 0, 90] spawn BIS_fnc_dynamicText;
	BTC_teamkiller = 99;
	[] spawn BTC_Teamkill;
}
