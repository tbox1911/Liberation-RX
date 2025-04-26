//--- LRX Save player context (Stuff + Ais)
if (!isServer) exitWith {};
params ["_player", "_uid", ["_delete", false], ["_notify", false]];

if (isNull _player) exitWith {};
if !(_player getVariable ["GRLIB_player_context_loaded", false]) exitWith {};

private _ai_group = [];
private _loadout = [];
private _context = [];
private _score = 0;
private _squad_loaded = false;
private _bros = (units GRLIB_side_friendly + units GRLIB_side_civilian) select { (_x != _player) && (_x getVariable ["PAR_Grp_ID", "0"]) == format ["Bros_%1",_uid] };

{if ((_x select 0) == _uid) exitWith {_score = (_x select 1)}} forEach GRLIB_player_scores;

if (_score >= GRLIB_min_score_player) then {
	if !([_player] call PAR_is_wounded) then {
		_loadout = getUnitLoadout _player;
		_squad_loaded = _player getVariable ["GRLIB_squad_context_loaded", false];
		if (_squad_loaded) then {
			{
				_ai_group pushback [typeOf _x, rank _x, getUnitLoadout _x];
			} forEach (_bros select {!([_x] call PAR_is_wounded)});
			diag_log format ["--- LRX Saving %1 unit(s) for %2 Squad.", count _ai_group, name _player];
		} else {
			_context = localNamespace getVariable [format ["player_context_%1", _uid], []];
			if (count _context == 0) then {
				{if (_x select 0 == _uid) exitWith {_context = _x}} foreach GRLIB_player_context;
			};
			_ai_group = _context select 2;
		};
	};
	private _personal_arsenal = _player getVariable [format ["GRLIB_personal_arsenal_%1", _uid], []];
	private _virtual_garage = _player getVariable [format ["GRLIB_virtual_garage_%1", _uid], []];
	localNamespace setVariable [format ["player_context_%1", _uid], [_uid, _loadout, _ai_group, _personal_arsenal, _virtual_garage]];
	diag_log format ["--- LRX player %1 profile Saved.", name _player];
};

// Delete units
if (_delete) then {
	{ deleteVehicle _x } forEach _bros;
};

// Notify
if (_notify) then {
	private _owner = owner _player;
	if (_owner != 0) then {
		private _msg = format [localize "STR_SAVE_PLAYER_MSG", count _ai_group];
		if (_score < GRLIB_min_score_player) then {
			_msg = format [localize "STR_NO_SAVE_PLAYER_MSG", _score, GRLIB_min_score_player];
		};
		[_msg ] remoteExec ["hintSilent", _owner];
	};
};
