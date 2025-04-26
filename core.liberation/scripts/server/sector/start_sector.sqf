params ["_sector"];

private _hc = [] call F_lessLoadedHC;
if (isNull _hc) then {
    [_sector] spawn manage_one_sector;
} else {
    diag_log format ["--- LRX Server: Sector: %1 spawned on %2", _sector, _hc];
    [_sector] remoteExec ["manage_one_sector", owner _hc];
    active_sectors_hc pushBack [_sector, _hc];
};
if (_sector in sectors_military) then {
    [_sector] spawn manage_ammoboxes;
};
