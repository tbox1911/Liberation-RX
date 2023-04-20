params ["_player"];

private _ret = false;

if ( !GRLIB_use_exclusive || ([] call is_admin) ) exitWith { true };
if ( !isNil "GRLIB_whitelisted_player" ) then {
    if ( (getPlayerUID _player) in GRLIB_whitelisted_player ) then {
        _ret = true;
    };
};

_ret;