params ["_caller", "_sector"];
if (alive _caller && [_caller] call F_getCommander && _sector in GRLIB_AvailAttackSectors) then {
    GRLIB_IsVoteInProgress = false;
    [_sector] call start_sector;
};
