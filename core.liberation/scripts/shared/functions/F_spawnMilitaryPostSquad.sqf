params [ "_squadpos" ];
private [ "_building_positions", "_unitclass", "_unit", "_totalx2", "_totaly2", "_avgx2", "_avgy2", "_vd2", "_newdir2" ];

private _posts_classname = [
	"Cargo_HQ_base_F",
	"Cargo_Patrol_base_F",
	"Cargo_Tower_base_F",
	"Cargo_House_base_F"
];

private _spawned_units = [];
private _grp = grpNull;
private _garnison_max = 5;
private _allposts = ([nearestObjects [_squadpos, _posts_classname, GRLIB_capture_size], {alive _x}] call BIS_fnc_conditionalSelect) select [0, 4];

if ( count _allposts > 0 ) then {
	diag_log format ["Spawn (%1) military post squad at position %2 at %3", count _allposts, _squadpos, time];

	{
		_building_positions = [_x, _garnison_max] call BIS_fnc_buildingPositions;
		_garnison = _garnison_max min (count _building_positions);
		if (_garnison > 0) then {
			_unitclass = [];
			while { (count _unitclass) < _garnison } do { _unitclass pushback (selectRandom opfor_infantry) };	
			_grp = [_squadpos, _unitclass, GRLIB_side_enemy, "infantry", false] call F_libSpawnUnits;
			{
				_x setPos (_building_positions select _forEachIndex);
				_x setVariable ["GRLIB_in_building", true, true];
				_spawned_units pushback _x;
			} foreach (units _grp);

			_totalx2 = 0;
			_totaly2 = 0;
			{
				[_x] spawn building_defence_ai;
				_x setUnitPos 'UP';
				_totalx2 = _totalx2 + ((getpos _x) select 0);
				_totaly2 = _totaly2 + ((getpos _x) select 1);
				sleep 0.3;
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
	} foreach _allposts;

	diag_log format ["Done spawning military post squad (%1) at %2", count _spawned_units, time];
};

_spawned_units;
