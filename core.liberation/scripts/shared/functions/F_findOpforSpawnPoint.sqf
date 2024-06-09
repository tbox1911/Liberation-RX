params ["_mindist", "_maxdist", ["_try_nearest", true], ["_spawn_target", zeropos]];
private [ "_current_sector", "_sector_pos", "_accept_current_sector", "_current_sector_distance", "_nearest_possible_sectors"];

private _increment = 500;

private _all_possible_sectors = sectors_opfor + sectors_military;
{ _all_possible_sectors pushBack (_x select 0) } forEach SpawnMissionMarkers;

private _filtered_possible_sectors = [];
{
	_current_sector = _x;
	_sector_pos = markerpos _current_sector;
	_accept_current_sector = true;
	_current_sector_distance = 99999;

	if ( !isNil 'secondary_objective_position' ) then {
		if ( count secondary_objective_position != 0 ) then {
			if ( (_sector_pos distance2D secondary_objective_position) < 500 ) then {
				_accept_current_sector = false;
			};
		};
	};

	if ( !isNil 'GRLIB_secondary_used_positions' ) then {
		if ( _current_sector in GRLIB_secondary_used_positions ) then {
			_accept_current_sector = false;
		};
	};

	if !( _spawn_target isEqualTo zeropos ) then {
		if ([_sector_pos, _spawn_target] call F_isWaterBetween) then {
			_accept_current_sector = false;
		};
	};

	if ( surfaceIsWater _sector_pos ) then {
		_accept_current_sector = false;
	};

	private _next_objective = [_sector_pos, true, false] call F_getNearestBluforObjective;
	if ((_next_objective select 1) <= GRLIB_sector_size) then {
		_accept_current_sector = false;
	};

	if ( _accept_current_sector ) then {
		_one_opfor_sector_in_range = false;
		{
			if ( ((_sector_pos) distance2D (markerpos _x)) < 2000 ) then {
				_one_opfor_sector_in_range = true;
			}
		} foreach opfor_sectors;
		_accept_current_sector = _one_opfor_sector_in_range;
	};

	if (_accept_current_sector) then {
		_filtered_possible_sectors pushback [_current_sector,_current_sector_distance];
	};
} foreach _all_possible_sectors;

private _nearest_possible_sectors = [];
if ( count _filtered_possible_sectors > 0 ) then {
	if (_try_nearest) then {
		_maxsearchdist = _mindist + _increment;
		while { (count _nearest_possible_sectors == 0) && (_maxsearchdist <= _maxdist) } do {
			{
				_nextsector = _x select 0;
				_nextdistance = _x select 1;
				if ( _nextdistance < _maxsearchdist ) then {
					_nearest_possible_sectors pushback _nextsector;
				};
			} foreach _filtered_possible_sectors;
			_maxsearchdist = _maxsearchdist + _increment;
		};
	} else {
		{
			_nextsector = _x select 0;
			_nextdistance = _x select 1;
			if ( _nextdistance < _maxdist ) then {
				_nearest_possible_sectors pushback _nextsector;
			};
		} foreach _filtered_possible_sectors;
	};
};

private _opfor_spawn_point = "";
if ( count _nearest_possible_sectors > 0 ) then {
	if (_spawn_target isEqualTo zeropos)  then {
		_opfor_spawn_point = selectRandom _nearest_possible_sectors;
	} else {
		_opfor_spawn_point = ([_nearest_possible_sectors, [_spawn_target], {_input0 distance2D (markerPos  _x)}, 'ASCEND'] call BIS_fnc_sortBy) select 0;
	};
};

_opfor_spawn_point;
