params [ "_infsquad", "_building_ai_max", "_buildingpositions", "_sectorpos", [ "_sector", "" ] ];
private [ "_unitclass", "_infsquad_classnames", "_grp", "_position_indexes", "_position_count", "_idxposit" ];
diag_log format ["Spawn building squad type %1 at %2", _infsquad, time];

private _spawned_units_local = [];
private _default_side = GRLIB_side_enemy;

switch (_infsquad) do {
	case ("infantry"): { _infsquad_classnames = opfor_infantry };
	case ("militia"): { _infsquad_classnames = militia_squad };
	case ("resistance"): { _infsquad_classnames = resistance_squad; _default_side = GRLIB_side_resistance};
	default {_infsquad_classnames = ([] call F_getAdaptiveSquadComp)};
};

if ( _building_ai_max > floor ((count _buildingpositions) * GRLIB_defended_buildingpos_part)) then { _building_ai_max = floor ((count _buildingpositions) * GRLIB_defended_buildingpos_part)};
if ( _building_ai_max > 0 ) then {
	_unitclass = [];
	while { (count _unitclass) < _building_ai_max } do { _unitclass pushback (selectRandom _infsquad_classnames) };

	_position_indexes = [];
	_position_count = count _buildingpositions;
	while { count _position_indexes < count _unitclass } do {
		_nextposit = floor (random _position_count);
		if ( !(_nextposit in _position_indexes) ) then {
			_position_indexes pushback _nextposit;
		};
	};
	_grp = [_sectorpos, _unitclass, _default_side, _infsquad] call F_libSpawnUnits;

	_idxposit = 0;
	{
		_x setpos (_buildingpositions select (_position_indexes select _idxposit));
		_spawned_units_local pushback _x;
		[_x, _sector] spawn building_defence_ai;
		_idxposit = _idxposit + 1;
	} foreach (units _grp);
};
diag_log format ["Done Spawning building squad (%1) at %2", count _spawned_units_local, time];

_spawned_units_local;
