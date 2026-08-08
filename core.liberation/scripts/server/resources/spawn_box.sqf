params ["_sector", "_type"];

diag_log format ["Spawn Resources %1 at %2", ([_type] call F_getLRXName), _sector];

private _sector_pos = ([(markerPos _sector), 80] call F_getRandomPos);
private _box = [_type, _sector_pos, false] call boxSetup;
