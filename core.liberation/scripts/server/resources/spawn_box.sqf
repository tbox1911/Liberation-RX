params ["_sector", "_type"];

diag_log format ["Spawn Resources %1 at %2", ([_type] call F_getLRXName), _sector];

private _sector_pos = ([(markerPos _sector), 80] call F_getRandomPos);
private _spawn_pos = [_sector_pos, 3, 0, 80, false] call F_findSafePlace;
if (count _spawn_pos == 0) exitWith {};

private _box = [_type, _spawn_pos, false] call boxSetup;
[_box] call F_clearCargo;
