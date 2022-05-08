params [ "_infsquad", "_building_ai_max", "_buildingpositions", "_sectorpos", [ "_sector", "" ] ];
private [ "_squadtospawnnn", "_infsquad_classnames", "_usedposits", "_nextposit", "_remainingposits", "_grp", "_unit", "_position_indexes", "_position_count", "_idxposit", "_groupunitscount" ];
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
_squadtospawnnn = [];
while { (count _squadtospawnnn) < _building_ai_max } do { _squadtospawnnn pushback ( selectRandom _infsquad_classnames ); };

_position_indexes = [];
_position_count = count _buildingpositions;
while { count _position_indexes < count _squadtospawnnn } do {
	_nextposit = floor (random _position_count);
	if ( !(_nextposit in _position_indexes) ) then {
		_position_indexes pushback _nextposit;
	}
};

_grp = createGroup [_default_side, true];
_idxposit = 0;
{
	_unit = _grp createUnit [_x, _sectorpos, [], 5, "NONE"];
	sleep 0.1;
	_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	[_unit] joinSilent _grp;
	_unit setpos (_buildingpositions select (_position_indexes select _idxposit));
	if ( _infsquad == "militia" ) then {
		[ _unit ] call loadout_militia;
	};
	[ _unit ] call reammo_ai;
	[ _unit, _sector ] spawn building_defence_ai;
	_idxposit = _idxposit + 1;
	_spawned_units_local pushback _unit;
	sleep 0.1;
} foreach _squadtospawnnn;

diag_log format ["Done Spawning building squad (%1) at %2", count _spawned_units_local, time];

_spawned_units_local;