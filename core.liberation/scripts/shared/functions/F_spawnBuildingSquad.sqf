diag_log format [ "Spawning building squad at %1", time ];

params [ "_infsquad", "_building_ai_max", "_buildingpositions", "_sectorpos", [ "_sector", "" ] ];
private [ "_squadtospawnnn", "_infsquad_classnames", "_usedposits", "_nextposit", "_remainingposits", "_grp", "_everythingspawned", "_nextunit", "_position_indexes", "_position_count", "_idxposit", "_groupunitscount" ];

_everythingspawned = [];
_default_side = GRLIB_side_enemy;

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
	_x createUnit [_sectorpos, _grp,'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]'];
	_nextunit = (units _grp) select ((count (units _grp)) -1);
	_nextunit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	_nextunit setpos (_buildingpositions select (_position_indexes select _idxposit));
	_nextunit setdir (random 360);
	[ _nextunit, _sector ] spawn building_defence_ai;
	if ( _infsquad == "militia" ) then {
		[ _nextunit ] call loadout_militia;
	};

	_idxposit = _idxposit + 1;

	if ( count units _grp > 10 ) then {
		_everythingspawned = _everythingspawned + (units _grp);
		_grp = createGroup [_default_side, true];
	};
} foreach _squadtospawnnn;

if ( !(isNull _grp)) then {
	_everythingspawned = _everythingspawned + (units _grp);
};

diag_log format [ "Done Spawning building squad at %1", time ];

_everythingspawned