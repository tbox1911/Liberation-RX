A3W_mission_sectors = [];

private _mission_sectors = sectors_opforSpawn + (allMapMarkers select {["Mission_", _x] call F_startsWith});
private ["_sector", "_sector_pos", "_range", "_pos", "_marker"];
{
	_sector = _x;
	_sector_pos = markerPos _sector;
	A3W_mission_sectors pushBack _sector;
	for "_i" from 0 to 12 do {
		_range = round (150 + floor random 300);
		_pos = _sector_pos getPos [_range, (_i*30)];
		_pos set [2, 0];
		_free_sector = (([150, _pos, A3W_mission_sectors + _mission_sectors] call F_getNearestSector) == "");
		_free_capture_sector = (([300, _pos, sectors_allSectors] call F_getNearestSector) == "");
		if (!surfaceIsWater _pos && _free_sector && _free_capture_sector) then {
			_marker = createMarkerLocal [format ["dyn_mission_%1_%2", _forEachIndex, _i], _pos];
			_marker setMarkerType "empty";
			A3W_mission_sectors pushBack _marker;
		};
	};
} forEach _mission_sectors;

if (!isNil "GRLIB_LRX_debug") then {
	{ _x setMarkerTypeLocal "mil_dot" } forEach A3W_mission_sectors;
};

SpawnMissionMarkers = A3W_mission_sectors apply {[_x, false, 0]};
ForestMissionMarkers = (allMapMarkers select {["ForestMission_", _x] call F_startsWith}) apply {[_x, false, 0]};
SunkenMissionMarkers = (allMapMarkers select {["SunkenMission_", _x] call F_startsWith}) apply {[_x, false, 0]};

LRX_MissionMarkersCap = sectors_capture apply {[_x, false, 0]};
LRX_MissionMarkersMil = sectors_military apply {[_x, false, 0]};
