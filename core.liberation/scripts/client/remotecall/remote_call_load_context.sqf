if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_grp"];

waitUNtil { sleep 0.1; local _grp };
{
    [_x] joinSilent (group player);
    [_x] spawn F_fixModUnit;
    [_x] spawn PAR_fn_AI_Damage_EH;
    _x enableIRLasers true;
    _x enableGunLights "Auto";
    _x switchMove "AmovPercMwlkSrasWrflDf";
    _x playMoveNow "AmovPercMwlkSrasWrflDf";
    _x setVariable ["PAR_Grp_ID", format["Bros_%1", PAR_Grp_ID], true];
    _x setVariable ["PAR_revive_max", PAR_ai_revive + (GRLIB_rank_level find (rank _x))];
    gamelogic globalChat format ["Adds %1 (%2) to your squad.", name _x, rank _x];
    PAR_AI_bros = PAR_AI_bros + [_x];
    sleep 0.3;
} foreach (units _grp);
