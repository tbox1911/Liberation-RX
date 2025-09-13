params [
	"_infsquad",
	"_building_ai_max",
	"_sectorpos",
	["_building_range", GRLIB_capture_size],
	["_building", objNull],
	["_mission_ai", true]
];

if (_building_ai_max == 0) exitWith {[]};

private _side = GRLIB_side_enemy;
private _squad_comp = [];
switch (_infsquad) do {
	case ("infantry"): { _squad_comp = opfor_infantry };
	case ("militia"): { _squad_comp = militia_squad };
	case ("resistance"): { _squad_comp = a3w_resistance_squad; _side = GRLIB_side_friendly};
	default { _squad_comp = [] call F_getAdaptiveSquadComp };
};

private _building_classname = [
	"House_F",
	"Cargo_HQ_base_F",
	"Cargo_Patrol_base_F",
	"Cargo_Tower_base_F",
	"Cargo_House_base_F"
];

private _keep_position = false;
if (_mission_ai) then { _keep_position = true };

private _buildingpositions = [];
if (isNull _building) then {
	private _allbuildings = (nearestObjects [_sectorpos, _building_classname, _building_range]) select {alive _x};
	{
		_buildingpositions = _buildingpositions + ([_x] call BIS_fnc_buildingPositions);
	} foreach _allbuildings;
} else {
	_buildingpositions = ([_building] call BIS_fnc_buildingPositions);
};

private _position_count = count _buildingpositions;
if (_position_count == 0) exitWith {[]};

diag_log format ["Spawn building squad type %1 at %2", _infsquad, time];

private _unitclass = [];
_building_ai_max = _position_count min _building_ai_max;
while { count _unitclass < _building_ai_max } do { _unitclass pushback (selectRandom _squad_comp) };

private _position_indexes = [];
while { count _position_indexes < count _unitclass } do {
	_nextposit = floor random _position_count;
	if !(_nextposit in _position_indexes) then {
		_position_indexes pushback _nextposit;
	};
};
private _grp = [_sectorpos, _unitclass, _side, "building", _mission_ai] call F_libSpawnUnits;
{
	//_x disableAI "MOVE";
	_x disableAI "PATH";
	_x setUnitPos "UP";
	_x setPos (_buildingpositions select (_position_indexes select _forEachIndex));
	[_x, _keep_position] spawn building_defence_ai;
} foreach (units _grp);

diag_log format ["Done Spawning building squad (%1) at %2", count (units _grp), time];

(units _grp);
