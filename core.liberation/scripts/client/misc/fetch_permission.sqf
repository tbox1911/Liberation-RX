params [ "_source", "_permission" ];
private [ "_uidvar", "_ret", "_perms" ];

_ret = false;
_perms = [];

if ( isNil "GRLIB_permissions" ) exitWith { _ret };
if ( count GRLIB_permissions == 0 ) exitWith { _ret };
if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {_ret};

_uidvar = getPlayerUID _source;
{
	if ( _uidvar == _x select 0 ) exitWith { _perms = (_x select 1) };
} foreach GRLIB_permissions;
if ( count _perms == 0 ) exitWith { _ret };
if (_perms select _permission) exitWith { true };

_ret