params ["_player", "_uid"];

private _puid = _player getVariable ["PAR_Grp_ID","1"];
private _bros = allUnits select { alive _x && lifeState _x != "INCAPACITATED" && !(_x getVariable ["GRLIB_score_set", 0] == 1) && (_x getVariable ["PAR_Grp_ID","0"]) == _puid};

private _ai_group = [];
{
	_ai_group pushback [typeOf _x, rank _x, [_x] call F_getLoadout];
	deleteVehicle _x;
} forEach _bros;

private _new = true;
private _loadout = [_player] call F_getLoadout;
{
	if (_x select 0 == _uid) exitWith {
		_x set [1, _loadout];
		_x set [2, _ai_group ];
		_new = false;
	};
} foreach GRLIB_player_context;

if (_new) then {
	GRLIB_player_context pushback [ _uid, _loadout, _ai_group ];
};

diag_log format ["--- LRX Squad Player %1 Saved at %2 ", name _player, time];
