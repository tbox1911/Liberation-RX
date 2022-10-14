//--- LRX Load player context (Stuff + Ais)
if (!isServer) exitWith {};
params [ "_player", "_uid", "_context" ];
private ["_grp", "_pos", "_unit", "_class", "_rank", "_loadout"];

if (count _context == 0) exitWith {};

// Player loadout
[_player, _context select 1] remoteExec ["setUnitLoadout", owner _player];

if (count (_context select 2) >= 1 ) then {
    private _wait = true;
    while { _wait } do {
        _player = _uid call BIS_fnc_getUnitByUID;
        if (isNull _player) then { 
            _wait = false
        } else {
            [localize "$STR_SQUAD_WAIT"] remoteExec ["hintSilent", owner _player];
            if ([_player, "FOB", GRLIB_fob_range] call F_check_near && isTouchingGround (vehicle _player)) then {
                // AIs loadout
                {
                    _class = _x select 0;
                    _rank = _x select 1;
                    _loadout = _x select 2;

                    _grp = createGroup [GRLIB_side_friendly, true];
                    _pos = getPosATL _player;
                    _unit = _grp createUnit [_class, _pos, [], 10, "NONE"];
                    waitUntil {!isNull _unit};
                    _unit setVariable ["PAR_Grp_ID", format["Bros_%1", _uid], true];

                    [
                        [_unit, _rank, _loadout],
                    {
                        if (isDedicated) exitWith {};
                        params ["_unit", "_rank", "_loadout"];
                        [_unit] joinSilent (group player);
                        waituntil {sleep 0.5; local _unit};
                        gamelogic globalChat format ["Adds %1 (%2) to your squad.", name _unit, _rank];
                        _unit setMass 10;
                        _unit setUnitRank _rank;
                        _unit setSkill (0.6 + (GRLIB_rank_level find _rank) * 0.05);
                        _unit enableIRLasers true;
                        _unit enableGunLights "Auto";
                        _unit setUnitLoadout _loadout;
                        //(group player) selectLeader player;
                    }] remoteExec ["bis_fnc_call", owner _player];

                    deleteGroup _grp;
                    sleep 0.5;
                } foreach (_context select 2);
                _wait = false;
            };
        };

        sleep 3;
    };
    [""] remoteExec ["hintSilent", owner _player];
};

_player setVariable ["GRLIB_squad_context_loaded", true];
diag_log format ["--- LRX Loading %1 unit(s) for %2 Squad.", count (_context select 2), name _player];
