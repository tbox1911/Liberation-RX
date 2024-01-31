private _ret = true;

if ( !GRLIB_use_whitelist || ([] call is_admin) ) exitWith { _ret };
if ( typeOf player == commander_classname ) then {
	if (!GRLIB_Player_VIP) then { _ret = false };
};

_ret;