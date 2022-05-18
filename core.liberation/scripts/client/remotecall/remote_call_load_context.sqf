if ( isDedicated ) exitWith {};

params [ "_context" ];
if (count _context == 0 ) exitWith {};
systemChat "-------- Loading Squad Backup --------";

private _grp = group player;
[player, _context select 1] call F_setLoadout;

if (count (_context select 2) >= 1 ) then {
    waitUntil {
        sleep 3;
        if ([player, "FOB", GRLIB_fob_range] call F_check_near) exitWith { true };
        hintSilent localize "$STR_SQUAD_WAIT";
        false;
    };
    hintSilent "";

    {
        _unit = _grp createUnit [(_x select 0), getPosATL player, [], 10, "NONE"];
        sleep 0.1;
        [_unit] joinSilent _grp;
        _unit setMass 10;
        _unit setUnitRank (_x select 1);
        _unit setSkill (0.6 + (GRLIB_rank_level find (_x select 1)) * 0.05);
        _unit setVariable ["PAR_Grp_ID", format["Bros_%1",PAR_Grp_ID], true];
        _unit enableIRLasers true;
        _unit enableGunLights "Auto";
        [_unit, _x select 2] call F_setLoadout;
        sleep 0.1;
    } foreach (_context select 2);

    _grp selectLeader player;
};

player setVariable ["GRLIB_player_context_loaded", true, true];
