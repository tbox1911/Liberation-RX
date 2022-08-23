params [["_score",0]];
private _rank = "None";

if ((_score >= GRLIB_perm_ban) && (_score < GRLIB_perm_min)) then {_rank = "None"};
if ((_score >= GRLIB_perm_min) && (_score < GRLIB_perm_inf)) then {_rank = "Private"};
if ((_score >= GRLIB_perm_inf) && (_score < GRLIB_perm_log)) then {_rank = "Corporal"};
if ((_score >= GRLIB_perm_log) && (_score < GRLIB_perm_tank)) then {_rank = "Sergeant"};
if ((_score >= GRLIB_perm_tank) && (_score < GRLIB_perm_air)) then {_rank = "Captain"};
if ((_score >= GRLIB_perm_air) && (_score < GRLIB_perm_max)) then {_rank = "Major"};
if ((_score >= GRLIB_perm_max) && (_score < GRLIB_perm_max*2)) then {_rank = "Colonel"};
if ((_score >= GRLIB_perm_max*2)) then {_rank = "Super Colonel"};

_rank;