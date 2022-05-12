params [ "_squadpos" ];
private [ "_grp", "_building_positions", "_unitclass", "_unit", "_totalx2", "_totaly2", "_avgx2", "_avgy2", "_vd2", "_newdir2" ];
diag_log format ["Spawn cargopost squad at %1", time];

private _spawned_units_local = [];
private _allposts = [ nearestObjects [ _squadpos, [ 'Land_Cargo_Patrol_V1_F','Land_Cargo_Patrol_V2_F','Land_Cargo_Patrol_V3_F', 'Industry_base_F' ], GRLIB_capture_size ] , { alive _x } ] call BIS_fnc_conditionalSelect;
private _garnison = 5;
if ( count _allposts > 0 ) then {
	{
		_building_positions = [_x, _garnison] call BIS_fnc_buildingPositions;
		_unitclass = [];
		while { (count _unitclass) < _garnison } do { _unitclass pushback (selectRandom opfor_infantry) };	
		_grp = [_squadpos, _unitclass, GRLIB_side_enemy, "infantry"] call F_libSpawnUnits;
		{	
			_x setPos (_building_positions select _forEachIndex);
			_spawned_units_local pushback _x;
		} foreach (units _grp);
	} foreach _allposts;

	_totalx2 = 0;
	_totaly2 = 0;

	{
		[_x] spawn building_defence_ai;
		_x setUnitPos 'UP';
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

diag_log format ["Done spawning cargopost squad (%1) at %2", count _spawned_units_local, time];

_spawned_units_local;
