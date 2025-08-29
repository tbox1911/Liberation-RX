params ["_caller", "_sector"];
if (alive _caller && !([_caller] call F_getCommander) && GRLIB_Commander_VoteEnabled && count active_sectors == 0 && _sector in GRLIB_AvailAttackSectors) then {
    GRLIB_Sector_Votes set [getPlayerUID _caller, _sector];
    GRLIB_IsVoteInProgress = true;
    _sectorName = markerText _sector;
    systemChat format ["%1 has voted for %2", name _caller, _sectorName];
};