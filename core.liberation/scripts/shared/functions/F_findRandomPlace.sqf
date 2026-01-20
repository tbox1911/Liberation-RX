params ["_start_pos", ["_size", 5], ["_water_mode", -1], ["_max_radius", 150], ["_on_road", true]];

private _spawn_pos = [];
private _max_try = 25;

while { count _spawn_pos == 0 && _max_try > 0} do {
    private _radius = 10 + (floor random GRLIB_sector_size);
    private _rnd_pos = ([_start_pos, _radius] call F_getRandomPos);
    private _keep_pos = true;

    // position in Water
    if (surfaceIsWater _rnd_pos && _water_mode == 0) then { _keep_pos = false };

    if (_keep_pos) then {
	    // position too close from any FOB
	    if (_rnd_pos distance2D ([_rnd_pos] call F_getNearestFob) <= (GRLIB_sector_size * 1.25)) then { _keep_pos = false };
    };

	if (_keep_pos) then {
		// position too far from any blufor sectors
		if (([GRLIB_spawn_min, _rnd_pos, blufor_sectors] call F_getNearestSector) == "") then { _keep_pos = false };
	};

	if (_keep_pos) then {
		// position too close from any opfor sectors
		if (([(GRLIB_sector_size * 1.25), _rnd_pos, opfor_sectors] call F_getNearestSector) != "") then { _keep_pos = false };
	};

    if (_keep_pos) then {
        _spawn_pos = [_rnd_pos, _size, _water_mode, _max_radius, _on_road] call F_findSafePlace;
    };
    _max_try = _max_try - 1;
    sleep 0.2;
};

_spawn_pos;