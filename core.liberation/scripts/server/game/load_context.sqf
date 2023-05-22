//--- LRX Load player context (Stuff + Ais)
if (!isServer) exitWith {};
params [ "_player", "_uid"];
private ["_grp", "_pos", "_unit", "_class", "_rank", "_loadout"];

if (isNull _player) exitWith {};

private _context = localNamespace getVariable [format ["player_context_%1", _uid], []];
if (count _context == 0) then {
    {if (_x select 0 == _uid) exitWith {_context = _x}} foreach GRLIB_player_context;
};
if (count _context >= 1) then {
    // Player loadout
    [
        [_context select 1],
        {
            params ["_loadout"];
            player setUnitLoadout _loadout;
            player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice)];
        }
    ] remoteExec ["bis_fnc_call", owner _player];
    sleep 1;

    // AIs loadout
    if (count (_context select 2) >= 1 ) then {
        private _wait = true;
        while { _wait } do {
            _player = _uid call BIS_fnc_getUnitByUID;
            if (isNull _player) then {
                _wait = false
            } else {
                if ([_player, "FOB", GRLIB_fob_range] call F_check_near && isTouchingGround (vehicle _player)) then {
                    {
                        [
                            [_x select 0, _x select 1, _x select 2],
                            {
                                params ["_class", "_rank", "_loadout"];
                                private _unit = (group player) createUnit [_class, (getPosATL player), [], 10, "NONE"];
                                [_unit] joinSilent (group player);
                                _unit setVariable ["PAR_Grp_ID", format["Bros_%1", (getPlayerUID player)], true];
                                [_unit] call PAR_fn_AI_Damage_EH;
                                _unit setUnitLoadout _loadout;
                                _unit setUnitRank _rank;
                                _unit setSkill (0.6 + (GRLIB_rank_level find _rank) * 0.05);
                                _unit enableIRLasers true;
                                _unit enableGunLights "Auto";
                                _unit setpos (getpos _unit);
                                _unit switchMove "AmovPercMwlkSrasWrflDf";
				                _unit playMoveNow "AmovPercMwlkSrasWrflDf";
                                gamelogic globalChat format ["Adds %1 (%2) to your squad.", name _unit, rank _unit];
                            }
                        ] remoteExec ["bis_fnc_call", owner _player];
                        sleep 1;
                    } foreach (_context select 2);

                    _wait = false;
                    //diag_log format ["--- LRX Loading %1 unit(s) for %2 Squad.", count (_context select 2), name _player];
                } else {
                    if ((getPosATL _player) distance2D (markerPos "respawn_west") > 100) then {
                        [localize "$STR_SQUAD_WAIT"] remoteExec ["hintSilent", owner _player];
                    };
                };
            };
            sleep 3;
        };
        [""] remoteExec ["hintSilent", owner _player];
    };
};
_player setVariable ["GRLIB_squad_context_loaded", true, true];
diag_log format ["--- LRX player %1 profile Loaded.", name _player];