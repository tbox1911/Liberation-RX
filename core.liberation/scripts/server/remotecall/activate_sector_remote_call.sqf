params ["_caller", "_sector"];
if (alive _caller && [_caller] call F_getCommander && count active_sectors == 0 && _sector in GRLIB_AvailAttackSectors) then {
    [_sector] call start_sector;
};
