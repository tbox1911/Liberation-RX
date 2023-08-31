//--- LRX Save player context (Stuff + Ais)
if (!isServer) exitWith {};
params ["_player", "_uid", ["_delete",false]];

if (isNull _player) exitWith {};

private _ai_group = [];
private _loadout = [];
private _bros = (units _player + units GRLIB_side_civilian) select { (_x != _player) && (_x getVariable ["PAR_Grp_ID", "0"]) == format ["Bros_%1",_uid] };
private _score = 0;
{if ((_x select 0) == _uid) exitWith {_score = (_x select 1)}} forEach GRLIB_player_scores; 

if (_score >= GRLIB_min_score_player) then {
	private _loaded = _player getVariable ["GRLIB_squad_context_loaded", false];
	if (alive _player && lifeState _player != "INCAPACITATED") then {
		_loadout = getUnitLoadout [_player, true];
		if (_loaded) then {
			{
				_ai_group pushback [typeOf _x, rank _x, getUnitLoadout [_x, true]];
			} forEach (_bros select {alive _x && lifeState _x != "INCAPACITATED"});
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
};

// Remove AI
if (_delete) then {
	{ deleteVehicle _x } forEach _bros;
} else {
	private _msg = format [localize "STR_SAVE_PLAYER_MSG", count _ai_group];
	if (_score < GRLIB_min_score_player) then {
		_msg = format [localize "STR_NO_SAVE_PLAYER_MSG", _score, GRLIB_min_score_player];
	};
	[_msg ] remoteExec ["hintSilent", owner _player]
}