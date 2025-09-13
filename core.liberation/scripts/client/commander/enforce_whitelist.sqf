if (!GRLIB_use_whitelist) exitWith {};
if ([] call is_admin) exitWith {};

private _whitelisted = (PAR_Grp_ID in GRLIB_whitelisted_steamids);

if (typeOf player == commander_classname && _whitelisted) exitWith {
	GRLIB_active_commander = player;
	publicVariable "GRLIB_active_commander";
};

if (GRLIB_use_exclusive && !([] call is_admin || _whitelisted)) exitWith {
	private _msg = localize "STR_MSG_INVALID_STEAMID";
	titleText [_msg, "BLACK FADED", 100];
	uisleep 10;
	disableUserInput false;
	endMission "LOSER";
	forceEnd;
	sleep 300;
};

if (typeOf player != commander_classname) exitWith {};

private _msg = localize "STR_COMMANDER_NOT_AUTHORIZED";
titleText [_msg, "BLACK FADED", 100];
uisleep 10;
disableUserInput false;
endMission "LOSER";
forceEnd;
sleep 300;