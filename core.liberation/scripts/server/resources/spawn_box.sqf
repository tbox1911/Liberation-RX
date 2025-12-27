params ["_sector", "_type"];

private _sector_pos = (markerPos _sector) getPos [floor random 80, floor random 360];
private _spawn_pos = [_sector_pos, 5, 0, 80, false] call F_findSafePlace;
if (count _spawn_pos == 0) exitWith {};

private _box = [_type, _spawn_pos, false] call boxSetup;
[_box] call F_clearCargo;

diag_log format ["Spawn Resources %1 at %2", ([_type] call F_getLRXName), _sector];
