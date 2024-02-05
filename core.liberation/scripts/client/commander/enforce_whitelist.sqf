if (!GRLIB_use_whitelist) exitWith { true };
if (typeOf player != commander_classname && !([] call is_admin)) exitWith { true };

waitUntil { sleep 1; !isNil "GRLIB_Player_VIP" };
if (GRLIB_Player_VIP || ([] call is_admin)) exitWith {
	GRLIB_active_commander = player;
	publicVariable "GRLIB_active_commander";
	true;
};

false;