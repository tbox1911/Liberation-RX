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
	_loadout = getUnitLoadout [_player, true];
	if (_loaded) then {
		private _bros = ((units GRLIB_side_friendly) + (units GRLIB_side_civilian)) select { !(isPlayer _x) && alive _x && (_x getVariable ["PAR_Grp_ID","0"]) == _puid && lifeState _x != "INCAPACITATED"};
		{ _ai_group pushback [typeOf _x, rank _x, getUnitLoadout [_x, true]]} forEach _bros;
	} else {
		private _context = localNamespace getVariable [format ["player_context_%1", _uid], []];
		if (count _context == 0) then {
    		{if (_x select 0 == _uid) exitWith {_context = _x}} foreach GRLIB_player_context;
		};
		_ai_group = _context select 2;
	};
	diag_log format ["--- LRX Saving %1 unit(s) for %2 Squad.", count _ai_group, name _player];
};

localNamespace setVariable [format ["player_context_%1", _uid], [_uid, _loadout, _ai_group]];
diag_log format ["--- LRX player %1 profile Saved.", name _player];
