//--- LRX Load player context (Stuff + Ais)
if (!isServer) exitWith {};
params [ "_player", "_uid"];
private ["_grp", "_pos", "_unit", "_class", "_rank", "_loadout"];

if (isNull _player) exitWith {};
if (_player getVariable ["GRLIB_player_context_loaded", false]) exitWith {};

private _context = localNamespace getVariable [format ["player_context_%1", _uid], []];
if (count _context == 0) then {
    {if (_x select 0 == _uid) exitWith {_context = _x}} foreach GRLIB_player_context;
};
if (count _context >= 1) then {
    // Player loadout
    _player setUnitLoadout (_context select 1);
    _player setVariable ["GRLIB_player_context_loaded", true, true];
    _player setVariable ["GREUH_stuff_price", ([_player] call F_loadoutPrice), true];
    diag_log format ["--- LRX Loaded player %1 profile.", name _player];
    sleep 1;

    // AIs loadout
    if (count (_context select 2) >= 1 ) then {
        private _wait = true;
        while { _wait } do {
            _player = _uid call BIS_fnc_getUnitByUID;
            if (isNull _player) then {
                _wait = false
            } else {
                if ([_player, "FOB", GRLIB_fob_range] call F_check_near && isTouchingGround vehicle _player) then {
                    private _pos = markerPos GRLIB_respawn_marker;
                    private _grp = createGroup [GRLIB_side_friendly, true];
                    {
                        _class = _x select 0;
                        _rank = _x select 1;
                        _loadout = _x select 2;
                        if (count units _player > (GRLIB_squad_size + GRLIB_squad_size_bonus)) exitWith {};
                        private _unit = _grp createUnit [_class, _pos, [], 10, "NONE"];
                        sleep 0.1;
                        clearBackpackCargoGlobal (backpackContainer _unit);
                        _unit setUnitLoadout _loadout;
                        _unit setUnitRank _rank;
                        _unit setSkill (0.6 + (GRLIB_rank_level find _rank) * 0.05);
                        sleep 0.3;
                    } foreach (_context select 2);
                    _grp setGroupOwner (owner _player);
                    sleep 0.5;
                    [_grp] remoteExec ["remote_call_load_context", owner _player];
                    _wait = false;
                    //diag_log format ["--- LRX Loading %1 unit(s) for %2 Squad.", count (_context select 2), name _player];
                } else {
                    if (_player distance2D (markerPos GRLIB_respawn_marker) > 100) then {
                        [localize "$STR_SQUAD_WAIT"] remoteExec ["hintSilent", owner _player];
                    };
                };
            };
            sleep 3;
        };
        [""] remoteExec ["hintSilent", owner _player];
        diag_log format ["--- LRX Loaded %1 unit(s) for %2 Squad.", count (_context select 2), name _player];
    } else {
        _player setVariable ["GRLIB_squad_context_loaded", true, true];
    };
} else {
    _player setVariable ["GRLIB_player_context_loaded", true, true];
    _player setVariable ["GRLIB_squad_context_loaded", true, true];
};
