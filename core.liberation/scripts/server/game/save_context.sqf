//--- LRX Save player context (Stuff + Ais)
if (!isServer) exitWith {};
params ["_player","_uid"];

if (isNull _player) exitWith {};
if (isNil "_uid") then { _uid = getPlayerUID _player };

private _score = 0; 
{if ((_x select 0) == _uid) exitWith {_score = (_x select 1)}} forEach GRLIB_player_scores; 
if (_score < GRLIB_min_score_player)  exitWith {};

private _puid = _player getVariable ["PAR_Grp_ID","1"];
private _loaded = _player getVariable ["GRLIB_squad_context_loaded", false];
private _ai_group = [];
private _loadout = [];

if (alive _player && lifeState _player != "INCAPACITATED") then {
	private _bros = allUnits select { alive _x && _x != _player && lifeState _x != "INCAPACITATED" && (_x getVariable ["PAR_Grp_ID","0"]) == _puid};
	{ _ai_group pushback [typeOf _x, rank _x, getUnitLoadout [_x, true]]} forEach _bros;
	_loadout = getUnitLoadout [_player, true];
	diag_log format ["--- LRX saving player %1 Loadout.", name _player];
};

localNamespace setVariable [format ["player_context_%1", _uid], [_uid, _loadout, _ai_group]];
diag_log format ["--- LRX saving %1 unit(s) for %2 Squad.", count _ai_group, name _player];
