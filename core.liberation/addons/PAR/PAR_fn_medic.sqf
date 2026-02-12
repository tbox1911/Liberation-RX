params ["_wnded"];

if (_wnded == player && player getVariable ["SOG_player_in_tunnel", false]) exitWith {};
private _medic = [_wnded] call PAR_fn_nearestMedic;
private _msg = "";

if (isNil "_medic") exitWith {
	_wnded setVariable ["PAR_myMedic", nil];
	_msg = format [localize "STR_PAR_MD_01", name _wnded];
	[_wnded, _msg] call PAR_fn_globalchat;

	if (PAR_revive in [2,3]) then {
	_msg = localize "STR_PAR_MD_04";
	[_wnded, _msg] call PAR_fn_globalchat;
	};

	private _lst = PAR_AI_bros select { !([_x] call PAR_is_wounded) };
	_msg = format [localize "STR_PAR_MD_02", count (_lst)];
	[_wnded, _msg] call PAR_fn_globalchat;
};

_msg = format [localize "STR_PAR_MD_03", name _wnded, name _medic, round (_medic distance2D _wnded)];
[_medic, _msg] call PAR_fn_globalchat;

_medic setVariable ["PAR_busy", true];
_wnded setVariable ["PAR_myMedic", _medic];

[_wnded, _medic] call PAR_fn_911;
