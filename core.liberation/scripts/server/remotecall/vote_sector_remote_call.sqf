params ["_caller", "_sector"];

if (alive _caller && GRLIB_Commander_VoteEnabled && _sector in GRLIB_AvailAttackSectors) then {
    GRLIB_Sector_Votes set [getPlayerUID _caller, _sector];
    GRLIB_IsVoteInProgress = true;
    private _msg = format ["%1 has voted for %2!", name _caller, markerText _sector];
    [[GRLIB_side_friendly, "HQ"], _msg] remoteExec ["sideChat", 0];
};