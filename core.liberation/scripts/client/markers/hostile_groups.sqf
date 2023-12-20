private [ "_marker", "_nextgroup", "_leader", "_mission_ai", "_sector", "_sideMission" ];
if (GRLIB_fancy_info == 0) exitWith {};

waitUntil {sleep 1; !isNil "GRLIB_init_server"};

if (isNil "A3W_sectors_in_use") then {
	A3W_sectors_in_use = [];
};

if (isNil "secondary_objective_position_marker") then {
	secondary_objective_position_marker = zeropos;
};

private _hostile_markers = [];

while { true } do {
	{ deleteMarkerLocal _x } foreach _hostile_markers;
	_hostile_markers = [];

	{
		_nextgroup = _x;
		_leader = leader _nextgroup;
		_mission_ai = (_leader getVariable ["GRLIB_mission_AI", false]);
		_sector = [GRLIB_sector_size, _leader] call F_getNearestSector; 
		_sideMission = (_sector in A3W_sectors_in_use);
		_permMission = (_leader distance2D secondary_objective_position_marker < GRLIB_sector_size);
		if (alive _leader && !_mission_ai && !_sideMission && !_permMission && [(getPosATL _leader), GRLIB_side_friendly] call F_getNearestTower != "") then {
			_marker = createMarkerLocal [format ["hostilegroup%1",_x], markers_reset];
			_marker setMarkerColorLocal GRLIB_color_enemy_bright;
			_marker setMarkerTypeLocal "mil_warning";
			_marker setMarkerSizeLocal [0.65, 0.65];
			_marker setMarkerPosLocal ([getPosATL _leader, floor(random 50), floor(random 360)] call BIS_fnc_relPos);
			_hostile_markers pushback _marker;
		};
	} foreach (groups GRLIB_side_enemy);

	sleep (30 + floor(random 60));
};