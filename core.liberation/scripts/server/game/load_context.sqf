//--- LRX Load player context (Stuff + Ais)
if (!isServer) exitWith {};
params [ "_player", "_uid"];
private ["_grp", "_pos", "_unit", "_class", "_rank", "_loadout", "_owner"];

if (isNull _player) exitWith {};
if (_player getVariable ["GRLIB_player_context_loaded", false]) exitWith {};

private _context = localNamespace getVariable [format ["player_context_%1", _uid], []];
if (count _context == 0) then {
    {if (_x select 0 == _uid) exitWith {_context = _x}} foreach GRLIB_player_context;
};
// Load Personal Arsenal
private _personal_arsenal = [];
if (GRLIB_filter_arsenal == 4) then {
    _personal_arsenal = default_personal_arsenal;
    if (count _context >= 4) then { _personal_arsenal = (_context select 3) };
};
_player setVariable [format ["GRLIB_personal_arsenal_%1", _uid], _personal_arsenal, true];

// Load Virtual Garage
private _virtual_garage = [];
if (count _context >= 5) then { _virtual_garage = (_context select 4) };
_player setVariable [format ["GRLIB_virtual_garage_%1", _uid], _virtual_garage, true];

if (count _context >= 1) then {
    // Player loadout
    waitUntil {sleep 0.1; !(isSwitchingWeapon _player)};
    _player setUnitLoadout (_context select 1);
    _player setVariable ["GREUH_stuff_price", ([_player] call F_loadoutPrice), true];
    diag_log format ["--- LRX Loaded player %1 profile.", name _player];
    sleep 1;

    // AIs loadout
    if (count (_context select 2) >= 1 && alive _player) then {
        private _score = [_player] call F_getScore;
        private _squad_size = ([_score] call F_getRank) select 1;
        private _wait = true;
        while { _wait } do {
            _player = _uid call BIS_fnc_getUnitByUID;
            _owner = owner _player;
            if (isNull _player) then {
                _wait = false
            } else {
                if ([_player, "FOB", GRLIB_fob_range] call F_check_near && (round (getPos _player select 2) <= 0)) then {
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
                    sleep 0.5;
                    [_grp] remoteExec ["remote_call_load_context", _owner];
                    sleep 0.5;
                    _grp setGroupOwner _owner;
                    _wait = false;
                    diag_log format ["--- LRX Loading %1 unit(s) for %2 Squad.", count (_context select 2), name _player];
                } else {
                    if (_player distance2D (markerPos GRLIB_respawn_marker) > 100) then {
                        [localize "$STR_SQUAD_WAIT"] remoteExec ["hintSilent", _owner];
                        sleep 5;
                    };
                };
            };
            sleep 2;
        };
        _player setVariable ["GRLIB_player_context_loaded", true, true];
    } else {
        _player setVariable ["GRLIB_squad_context_loaded", true, true];
    };
    _player setVariable ["GRLIB_player_context_loaded", true, true];
} else {
    _player setVariable ["GRLIB_player_context_loaded", true, true];
    _player setVariable ["GRLIB_squad_context_loaded", true, true];
};
