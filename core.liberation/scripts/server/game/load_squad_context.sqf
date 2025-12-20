//--- LRX Load player context (Stuff + Ais)
if (!isServer) exitWith {};
params [ "_player", "_uid"];
private ["_grp", "_pos", "_unit", "_class", "_rank", "_loadout", "_owner"];

if (_player getVariable ["GRLIB_squad_context_loaded", false]) exitWith {};

private _context = localNamespace getVariable [format ["player_context_%1", _uid], []];
if (count _context == 0) then {
    {if (_x select 0 == _uid) exitWith {_context = _x}} foreach GRLIB_player_context;
};

// AIs loadout
if (count _context < 3) exitWith { _player setVariable ["GRLIB_squad_context_loaded", true, true] };
if (count (_context select 2) >= 1) then {
    while {alive _player && !(_player getVariable ["GRLIB_squad_context_loaded", false])} do {
        _player = _uid call BIS_fnc_getUnitByUID;
        _owner = owner _player;
        if (alive _player && [_player, "FOB", GRLIB_fob_range] call F_check_near && (round (getPos _player select 2) <= 0)) then {
            private _score = [_player] call F_getScore;
            private _squad_size = ([_score] call F_getRank) select 1;
            diag_log format ["--- LRX Info: %1 Squad loading %2 unit(s).", name _player, count (_context select 2)];
            _pos = markerPos GRLIB_respawn_marker;
            _grp = createGroup [GRLIB_side_friendly, true];
            {
                _class = _x select 0;
                _rank = _x select 1;
                _loadout = _x select 2;
                if (count units _grp >= _squad_size) exitWith {};
                _unit = _grp createUnit [_class, _pos, [], 10, "NONE"];
                _unit allowDamage false;
                _unit setPos (getPos _unit);
                [_unit] joinSilent _grp;
                removeBackpack _unit;
                sleep 0.1;
                waitUntil {sleep 0.1; !(isSwitchingWeapon _unit)};
                _unit setUnitLoadout _loadout;
                _unit setUnitRank _rank;
                _unit setSkill (0.6 + (GRLIB_rank_level find _rank) * 0.05);
                sleep 0.2;
            } foreach (_context select 2);
            _grp setGroupOwner _owner;
            sleep 0.5;
            [_grp] remoteExec ["remote_call_load_context", _owner];
            waitUntil {sleep 1; (_player getVariable ["GRLIB_squad_context_loaded", false])};
        } else {
            if (_player distance2D (markerPos GRLIB_respawn_marker) > 100) then {
                [localize "$STR_SQUAD_WAIT"] remoteExec ["hintSilent", _owner];
                sleep 3;
            };
        };
        sleep 1;
    };
} else {
    _player setVariable ["GRLIB_squad_context_loaded", true, true];
};
