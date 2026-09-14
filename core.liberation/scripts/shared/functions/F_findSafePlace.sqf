params ["_start_pos", ["_size", 5], ["_water_mode", -1], ["_max_radius", 150], ["_on_road", true]];
// Water mode
//  0: position cannot be over water
//  2: position cannot be over land
// -1: to ignore

if (count _start_pos == 0) exitWith {[]};

private _maxalt = 120;
private _angle_step = 15;
private _radius_step = 1;
private _tries_per_ring = 10;
private _max_attempts = 100;
private _attempt = 0;
private _radius = (_size max 1);

// Snap XY to the first surface below, independent of input Z.
private _snapToSurface = {
	params ["_pos"];
	if (_water_mode == 2) exitWith { _pos };

	private _from = ATLtoASL [_pos select 0, _pos select 1, _maxalt];
	private _to = ATLtoASL [_pos select 0, _pos select 1, -20];
	private _hits = lineIntersectsSurfaces [_from, _to, objNull, objNull, true, 1, "GEOM", "FIRE"];
	if (count _hits == 0) exitWith { _pos };

	(ASLToATL ((_hits select 0) select 0))
};

private _isPosValid = {
	params ["_pos"];
	private _wfree = true;
	if (_water_mode == 0) then { _wfree = !(surfaceIsWater _pos && ATLtoASL _pos select 2 < 1) };
	if (_water_mode == 2) then { _wfree = surfaceIsWater _pos };
	if (!_wfree) exitWith { false };

	// _on_road (true = roads allowed)
	if (!_on_road && {isOnRoad _pos}) exitWith { false };

	// cheap reject: solid terrain props in footprint
	if (_water_mode != 2 && {count (nearestTerrainObjects [_pos, ["House","Building","Wall","Fence","Rock","Rocks"], (_size + 3), false, true]) > 0}) exitWith { false };

	private _posASL = ATLtoASL _pos;
	private _maxASL = ATLtoASL (_pos vectorAdd [0, 0, _maxalt]);

	// vertical clearance
	if (lineIntersects [_posASL, _maxASL]) exitWith { false };

	// horizontal clearance around footprint
	private _hfree = true;
	private _angle = 0;
	while { _angle < 360 } do {
		private _targetASL = ATLtoASL (_pos vectorAdd [_size * sin _angle, _size * cos _angle, 0]);
		if (lineIntersects [_posASL, _targetASL]) exitWith { _hfree = false };
		_angle = _angle + _angle_step;
	};
	_hfree
};

private _tryPos = {
	params ["_pos"];
	if (count _pos == 0) exitWith { [] };
	_pos = ([_pos] call _snapToSurface) vectorAdd [0, 0, 0.2];
	if ([_pos] call _isPosValid) exitWith { _pos };
	[]
};

private _spawn_pos = [];
private _found = false;

_spawn_pos = [_start_pos] call _tryPos;
if (count _spawn_pos > 0) exitWith { _spawn_pos };

// 1) fast engine guess (land only)
if (_water_mode != 2) then {
	private _guess = [_start_pos findEmptyPosition [_size, (_max_radius min 80)]] call _tryPos;
	if (count _guess > 0) then {
		_spawn_pos = _guess;
		_found = true;
	};
};
if (_found) exitWith { _spawn_pos };

// 2) expanding rings with multiple samples
while { !_found && {_attempt < _max_attempts} && {_radius < _max_radius} } do {
	for "_i" from 1 to _tries_per_ring do {
		_attempt = _attempt + 1;
		_spawn_pos = [[_start_pos, _radius] call F_getRandomPos] call _tryPos;
		if (count _spawn_pos > 0) exitWith { _found = true };

		if ((_attempt mod 8) == 0) then { sleep 0.01 };
	};
	if (!_found) then { _radius = _radius + _radius_step };
};

if (_found) exitWith { _spawn_pos };

diag_log format ["--- LRX Debug: Cant find suitable position at %1 - DGB: S%2:R%3:W%4", _start_pos, _size, _max_radius, _water_mode];
[];
