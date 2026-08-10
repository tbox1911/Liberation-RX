params ["_start_pos", ["_size", 5], ["_water_mode", -1], ["_max_radius", 150], ["_on_road", true]];
// Water mode
//  0: position cannot be over water
//  2: position cannot be over land
// -1: to ignore

if (count _start_pos == 0) exitWith {[]};

private _maxalt = 120;
private _angle_step = 15;
private _radius_step = 2;
private _tries_per_ring = 4;
private _max_attempts = 60;
private _attempt = 0;
private _radius = (_size max 1);

private _isPosValid = {
	params ["_pos"];
	private _wfree = true;
	if (_water_mode == 0) then { _wfree = !(surfaceIsWater _pos) };
	if (_water_mode == 2) then { _wfree = surfaceIsWater _pos };
	if (!_wfree) exitWith { false };

	// _on_road == false => avoid roads ; true => roads allowed
	if (!_on_road && {isOnRoad _pos}) exitWith { false };

	// cheap reject: solid terrain props in footprint
    if (_water_mode != 2 && {count (nearestTerrainObjects [_pos, ["House","Building","Wall","Fence","Rock","Rocks"], _size, false, true]) > 0}) exitWith { false };

	_pos = +_pos;
	_pos set [2, 0.5];
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

// 1) fast engine guess (land only)
if (_water_mode != 2) then {
	private _guess = _start_pos findEmptyPosition [_size, (_max_radius min 80)];
	if (count _guess > 0 && {[_guess] call _isPosValid}) then {
		_guess set [2, 0];
		_spawn_pos = _guess;
		_found = true;
	};
};
if (_found) exitWith { _spawn_pos };

// 2) expanding rings with multiple samples
private _spawn_pos = [];
private _found = false;

while { !_found && {_attempt < _max_attempts} && {_radius < _max_radius} } do {
	for "_i" from 1 to _tries_per_ring do {
		_attempt = _attempt + 1;
		_spawn_pos = [_start_pos, _radius] call F_getRandomPos;
		if ([_spawn_pos] call _isPosValid) exitWith { _found = true };

		if ((_attempt mod 8) == 0) then { sleep 0.01 };
	};
	if (!_found) then { _radius = _radius + _radius_step };
};

if (_found) exitWith {
	_spawn_pos set [2, 0];
    _spawn_pos
};

diag_log format ["--- LRX Debug: Cant find suitable position at %1 - DGB: S%2:R%3:W%4", _start_pos, _size, _max_radius, _water_mode];
[];
