params ["_mindist", "_maxdist", ["_spawn_target", zeropos]];
private [ "_current_sector", "_sector_pos", "_accept_current_sector"];


private _all_possible_sectors = sectors_opforSpawn;
{ _all_possible_sectors pushBack (_x select 0) } forEach SpawnMissionMarkers;
_all_possible_sectors append (sectors_military - blufor_sectors);

private _possible_sectors = [];
{
	_current_sector = _x;
	_sector_pos = markerpos _current_sector;
	_accept_current_sector = true;

	if (!isNil "secondary_objective_position_marker") then {
		if ( (_sector_pos distance2D secondary_objective_position_marker) < 500 ) then {
			_accept_current_sector = false;
		};
	};

	if (!isNil "GRLIB_secondary_used_positions") then {
		if ( _current_sector in GRLIB_secondary_used_positions ) then {
			_accept_current_sector = false;
		};
	};

	if (surfaceIsWater _sector_pos) then {
		_accept_current_sector = false;
	};

	if !(_spawn_target isEqualTo zeropos) then {
		_sector_dist = _sector_pos distance2D _spawn_target;
		if (_sector_dist < _mindist || _sector_dist > _maxdist) then {
			_accept_current_sector = false;
		};
	};

	if (_accept_current_sector) then {
		{
			_sector_dist = _sector_pos distance2D _x;
			if (_sector_dist < _mindist) exitWith {
				_accept_current_sector = false;
			};		
		} foreach GRLIB_all_fobs;
	};

	if (_accept_current_sector) then {
		private _next_objective = [_sector_pos, false] call F_getNearestBluforObjective;
		if ((_next_objective select 1) < _mindist) then {
			_accept_current_sector = false;
		};
	};
	
	if (_accept_current_sector) then {
		_possible_sectors pushback _current_sector;
	};
} foreach _all_possible_sectors;

private _opfor_spawn_point = "";
if ( count _possible_sectors > 0 ) then {
	if (_spawn_target isEqualTo zeropos) then {
		_opfor_spawn_point = selectRandom _possible_sectors;
	} else {
		_opfor_spawn_point = ([_possible_sectors, [_spawn_target], {_input0 distance2D (markerPos _x)}, 'ASCEND'] call BIS_fnc_sortBy) select 0;
	};
};

_opfor_spawn_point;
