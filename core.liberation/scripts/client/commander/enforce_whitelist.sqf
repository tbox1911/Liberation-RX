if (!GRLIB_use_whitelist) exitWith {};
if (!GRLIB_is_Commander) exitWith {};
if ([] call is_admin) exitWith {};

private _whitelisted = (PAR_Grp_ID in GRLIB_whitelisted_steamids);

if (GRLIB_is_Commander && _whitelisted) exitWith {
	GRLIB_active_commander = player;
	publicVariable "GRLIB_active_commander";
};

private _msg = localize "STR_COMMANDER_NOT_AUTHORIZED";
if (GRLIB_use_exclusive && !([] call is_admin || _whitelisted)) then {
	_msg = localize "STR_MSG_INVALID_STEAMID";
};

titleText [_msg, "BLACK FADED", 100];
uisleep 10;
disableUserInput false;
endMission "LOSER";
forceEnd;
sleep 300;