params ["_caller", "_sector"];
if (alive _caller && !GRLIB_connCalculating && !([_caller] call F_getCommander) && GRLIB_Commander_VoteEnabled && active_sectors isEqualTo [] && !(GRLIB_AvailAttackSectors isEqualTo []) && {_sector in GRLIB_AvailAttackSectors}) then {
    GRLIB_Sector_Votes set [getPlayerUID _caller, _sector];
    GRLIB_IsVoteInProgress = true;
    _sectorName = markerText _sector;
    systemChat format ["%1 has voted for %2", name _caller, _sectorName];
};