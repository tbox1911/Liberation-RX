//--- LRX Load player context (Stuff + Ais)
if (!isServer) exitWith {};
params [ "_player", "_uid"];
private ["_grp", "_pos", "_unit", "_class", "_rank", "_loadout", "_owner"];

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

// Player loadout
if (count _context >= 1) then {
    waitUntil {sleep 0.1; !(isSwitchingWeapon _player)};
    _player setUnitLoadout (_context select 1);
    _player setVariable ["GREUH_stuff_price", ([_player] call F_loadoutPrice), true];
    diag_log format ["--- LRX Loaded player %1 profile.", name _player];
    sleep 1;
};

_player setVariable ["GRLIB_player_context_loaded", true, true];
