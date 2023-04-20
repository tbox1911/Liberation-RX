params ["_player"];

private _ret = true;
private _tagmatch = false;
private _idmatch = false;
private _namematch = false;

if ( !GRLIB_use_whitelist || ([] call is_admin) ) exitWith { _ret };
if ( typeOf _player == commander_classname ) then {
	if ( !isNil "GRLIB_whitelisted_tags" ) then {
		if ( count (squadParams _player) != 0 ) then {
			if ( (squadParams _player select 0 select 0) in GRLIB_whitelisted_tags  ) then {
				_tagmatch = true;
			};
		};
	};

	if ( !isNil "GRLIB_whitelisted_steamids" ) then {
		if ( ( getPlayerUID _player ) in GRLIB_whitelisted_steamids ) then {
			_idmatch = true;
		};
	};

	if ( !isNil "GRLIB_whitelisted_names" ) then {
		if ( ( name _player ) in GRLIB_whitelisted_names ) then {
			_namematch = true;
		};
	};

	if ( !( _tagmatch || _idmatch || _namematch ) ) then {
		_ret = false;
	};
};

_ret;