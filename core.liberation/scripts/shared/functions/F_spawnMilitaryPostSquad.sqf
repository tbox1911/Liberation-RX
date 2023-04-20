diag_log format [ "Spawn cargopost squad at %1", time ];

params [ "_squadpos" ];
private [ "_spawned_units_local", "_allposts", "_grp", "_building_positions", "_unitclasspost", "_unit", "_totalx2", "_totaly2", "_avgx2", "_avgy2", "_vd2", "_newdir2" ];

_spawned_units_local = [];

_allposts = [ nearestObjects [ _squadpos, [ 'Land_Cargo_Patrol_V1_F','Land_Cargo_Patrol_V2_F','Land_Cargo_Patrol_V3_F' ], GRLIB_capture_size ] , { alive _x } ] call BIS_fnc_conditionalSelect;
if ( count _allposts > 0 ) then {
	_grp = createGroup [GRLIB_side_enemy, true];

	{
		_building_positions = 	[_x] call BIS_fnc_buildingPositions;
		_unitclasspost = opfor_marksman;
		if ( floor(random 100) > 60 ) then {
			_unitclasspost = opfor_machinegunner;
		};
		_unit = _grp createUnit [_unitclasspost, _squadpos, [], 5, "NONE"];
		_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_unit setpos (_building_positions select 1);
		_unit setdir (180 + (getdir _x ));
		[ _unit ] call reammo_ai;
		sleep 0.1;
	} foreach _allposts;

	_totalx2 = 0;
	_totaly2 = 0;

	{
		[_x] spawn building_defence_ai;
		_x setUnitPos 'UP';
		_spawned_units_local pushback _x;
		_totalx2 = _totalx2 + ((getpos _x) select 0);
		_totaly2 = _totaly2 + ((getpos _x) select 1);
	} foreach (units _grp);

	_avgx2 = _totalx2 / ( count (units _grp) );
	_avgy2 = _totaly2 / ( count (units _grp) );

	{
		_vd2 = (getPosASL _x) vectorDiff [_avgx2, _avgy2, (getPosASL _x) select 2];
		_newdir2 = (_vd2 select 0) atan2 (_vd2 select 1);
		if (_newdir2 < 0) then {_dir = 360 + _newdir2 };
		_x setdir (_newdir2);
	} foreach (units _grp);

};

diag_log format [ "Done spawning cargopost squad at %1", time ];


_spawned_units_local
