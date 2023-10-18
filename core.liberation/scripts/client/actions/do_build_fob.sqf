private _box = (objectParent player);
if (isNull _box) then { _box = cursorObject };
private _box_type = typeOf _box;

sleep random 0.3;

//only one at time
if ((_box getVariable ["box_in_use", false])) exitWith {};
if (count (GRLIB_all_fobs select {count (_x nearObjects [FOB_typename, 50]) > 0}) >= GRLIB_maximum_fobs && _box_type != FOB_box_outpost) exitWith {
	hint format [localize "STR_HINT_FOBS_EXCEEDED", GRLIB_maximum_fobs];
};
if (count (GRLIB_all_fobs select { surfaceIsWater _x }) > 0 && _box_type == FOB_boat_typename) exitWith {
	hint format ["Only one Naval FOB Allowed!", GRLIB_maximum_fobs];
};
private _sea_deep = round ((getPosATL player select 2) - (getPosASL player select 2));
private _min_deep = 30;
if (_box_type == FOB_boat_typename && _sea_deep < _min_deep) exitWith {
	hint format [localize "STR_BUILD_ERROR_WATER_DEEP", _sea_deep, _min_deep];
};

_box setVariable ["box_in_use", true, true];
private _minfobdist = 1000;
private _minsectordist = GRLIB_capture_size + GRLIB_fob_range;
private _distfob = 1;
private _clearedtobuildfob = true;
private _distsector = 1;
private _clearedtobuildsector = true;

private _idx = 0;
while { (_idx < (count GRLIB_all_fobs)) && _clearedtobuildfob } do {
	if ( player distance (GRLIB_all_fobs select _idx) < _minfobdist ) then {
		_clearedtobuildfob = false;
		_distfob = player distance (GRLIB_all_fobs select _idx);
	};
	_idx = _idx + 1;
};

_idx = 0;
if(_clearedtobuildfob) then {
	while { (_idx < (count sectors_allSectors)) && _clearedtobuildsector } do {
		if ( player distance (getmarkerpos (sectors_allSectors select _idx)) < _minsectordist ) then {
			_clearedtobuildsector = false;
			_distsector = player distance (getmarkerpos (sectors_allSectors select _idx));
		};
		_idx = _idx + 1;
	};
};

if (!_clearedtobuildfob) then {
	hint format [localize "STR_FOB_BUILDING_IMPOSSIBLE",floor _minfobdist,floor _distfob];
} else {
	if ( !_clearedtobuildsector ) then {
		hint format [localize "STR_FOB_BUILDING_IMPOSSIBLE_SECTOR",floor _minsectordist,floor _distsector];
	} else {
		buildtype = 99;
		build_vehicle = _box;
		if (_box_type == FOB_box_outpost) then { buildtype = 98 };
		if (_box_type == FOB_boat_typename) then { buildtype = 97 };
		dobuild = 1;
		waitUntil { sleep 1; dobuild == 0 };
	};
};
_box setVariable ["box_in_use", false, true];