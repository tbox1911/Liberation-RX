params ["_caller", "_sector"];
if ([_caller] call F_getCommander && active_sectors isEqualTo [] && !(GRLIB_AvailAttackSectors isEqualTo []) && {_sector in GRLIB_AvailAttackSectors}) then {
    GRLIB_AvailAttackSectors = [];
    publicVariable "GRLIB_AvailAttackSectors";
    [_sector] call start_sector;
    sleep 10;
    _sectorPos = getMarkerPos _sector;
    {
        if ((!(_x isEqualTo _sector)) && {(((getMarkerPos _x) distance2D _sectorPos) < GRLIB_Commander_radius)}) then {
            [_x] call start_sector;
            sleep 10;
        };
    } forEach opfor_sectors;
};
