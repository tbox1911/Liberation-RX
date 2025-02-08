private _box = (objectParent player);
if (isNull _box) then { _box = cursorObject };
private _box_type = typeOf _box;

//only one at time
if ((_box getVariable ["box_in_use", false])) exitWith {};

if (_box_type in [FOB_box_typename, FOB_truck_typename, FOB_boat_typename] && count (GRLIB_all_fobs - GRLIB_all_outposts) >= GRLIB_max_fobs) exitWith {
	hint format [localize "STR_HINT_FOBS_EXCEEDED", GRLIB_max_fobs];
};
if (_box_type == FOB_box_outpost && count (GRLIB_all_outposts) >= GRLIB_max_outpost) exitWith {
	hint format [localize "STR_HINT_OUTPOST_EXCEEDED", GRLIB_max_outpost];
};
if (count (GRLIB_all_fobs select { surfaceIsWater _x }) > 0 && _box_type == FOB_boat_typename) exitWith {
	hint format ["Only one Naval FOB Allowed!"];
};
private _sea_deep = round ((getPosATL player select 2) - (getPosASL player select 2));
private _min_deep = 50;
if (WorldName == "australia") then { _min_deep = 35 };

if (_box_type == FOB_boat_typename && _sea_deep < _min_deep) exitWith {
	hint format [localize "STR_BUILD_ERROR_WATER_DEEP", _sea_deep, _min_deep];
};
if (_box_type == FOB_truck_typename && count (crew _box) > 0) exitWith {
	hint format ["No Crew in %1 Allowed!", ([_box_type] call F_getLRXName)];
};

private _min_fob_dist = 1000;
private _fob_pos = [] call F_getNearestFob;
private _fob_dist = round (player distance2D _fob_pos);
if (_fob_dist < _min_fob_dist) exitWith {
	hint format [localize "STR_FOB_BUILDING_IMPOSSIBLE",floor _min_fob_dist, _fob_dist];
};

private _replace_sector = false;
private _min_sector_dist = round ((GRLIB_capture_size + GRLIB_fob_range) * 1.5);
if (_box_type == FOB_box_outpost) then { _min_sector_dist = (GRLIB_capture_size + GRLIB_fob_range) };
private _next_sector = [_min_sector_dist] call F_getNearestSector;
if (_box_type == FOB_box_typename && _next_sector in blufor_sectors && _next_sector in sectors_military) then {
	private _result = [format [localize "STR_FOB_BUILDING_CAPTURE_SECTOR", markerText _next_sector], localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
	if (_result) then {
		_replace_sector = true;
	};
};
if (_next_sector != "" && !_replace_sector) exitWith {
	hint format [localize "STR_FOB_BUILDING_IMPOSSIBLE_SECTOR", _min_sector_dist, round (player distance2D markerPos _next_sector)];
};

_box setVariable ["box_in_use", true, true];
buildtype = 99;
build_vehicle = _box;
[_box, true] remoteExec ["hideObjectGlobal", 2];
if (_box_type == FOB_box_outpost) then { buildtype = 98 };
if (_box_type == FOB_boat_typename) then { buildtype = 97 };
dobuild = 1;
waitUntil { sleep 1; dobuild == 0 };
if (build_confirmed == 0) then {
	deleteVehicle _box;
	if (_replace_sector) then {
		[_next_sector] remoteExec ["remove_sector_remote_call", 2];
	};
} else {
	[_box, false] remoteExec ["hideObjectGlobal", 2];
};
_box setVariable ["box_in_use", false, true];