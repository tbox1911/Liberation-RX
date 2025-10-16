private [ "_marker", "_nextgroup", "_leader", "_sector", "_sideMission", "_permMission", "_nearRadioTower" ];
if (GRLIB_fancy_info == 0) exitWith {};

if (isNil "secondary_objective_position_marker") then {
	secondary_objective_position_marker = zeropos;
};

private _hostile_markers = [];
private _hostile_group = [];

while {true} do {
	waitUntil {sleep 0.1; (visibleMap || dialog) };
	{ deleteMarkerLocal _x } foreach _hostile_markers;
	_hostile_markers = [];

	_hostile_group = (groups GRLIB_side_enemy) select {
		(alive leader _x) &&
		!((leader _x) getVariable ["GRLIB_mission_AI", false]) &&
		!(objectParent (leader _x) isKindOf "Air")
	};
	{
		_nextgroup = _x;
		_leader = leader _nextgroup;
		_sector = [GRLIB_sector_size, _leader] call F_getNearestSector;
		_sideMission = (_sector in A3W_sectors_in_use);
		if (!_sideMission) then {
			_permMission = (_leader distance2D secondary_objective_position_marker < GRLIB_sector_size);
			_nearRadioTower = ([(getPos _leader), GRLIB_side_friendly] call F_getNearestTower != "");
			if (!_permMission && _nearRadioTower) then {
				_marker = createMarkerLocal [format ["hostilegroup_%1",_x], markers_reset];
				_marker setMarkerColorLocal GRLIB_color_enemy_bright;
				_marker setMarkerTypeLocal "mil_warning";
				_marker setMarkerSizeLocal [0.65, 0.65];
				_marker setMarkerPosLocal (_leader getPos [floor(random 50), floor(random 360)]);
				_hostile_markers pushback _marker;
			};
		};
		sleep 0.1;
	} foreach _hostile_group;

	sleep (30 + floor(random 60));
};