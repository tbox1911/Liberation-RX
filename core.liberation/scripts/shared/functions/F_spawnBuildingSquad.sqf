params [
	"_type",
	"_building_ai_max",
	"_sector_pos",
	["_building_range", GRLIB_capture_size],
	["_building", objNull],
	["_mission_ai", true]
];

if (_building_ai_max == 0) exitWith {[]};
if (isNil "GRLIB_building_used") then { GRLIB_building_used = [] };

private _side = GRLIB_side_enemy;
private _squad_comp = [];
switch (_type) do {
	case ("infantry"): { _squad_comp = opfor_infantry };
	case ("militia"): { _squad_comp = militia_squad };
	case ("resistance"): { _squad_comp = a3w_resistance_squad; _side = GRLIB_side_friendly};
	default { _squad_comp = [] call F_getAdaptiveSquadComp; _type = "auto" };
};

private _building_classname = [
	"House",
	"House_F",
	"Cargo_HQ_base_F",
	"Cargo_Patrol_base_F",
	"Cargo_Tower_base_F",
	"Cargo_House_base_F",
	"Land_i_House_Big_01_V2_F",
	"Land_i_House_Big_01_V3_F",
	"Land_i_House_Big_02_V2_F",
	"Land_Unfinished_Building_01_F"
];

private _building_blacklist = [
	"Land_SM_01_shed_F",
	"Land_SCF_01_heap_bagasse_F",
	"Land_Slum_02_F",
	"Land_Communication_anchor_F",
 	"Land_LampHarbour_F",
 	"Land_LampHalogen_F",
	"Land_Pier_F",
	"Land_Pier_addon",
	"Land_Communication_F",
	"Land_spp_Transformer_F",
	"Land_TTowerBig_1_F",
	"Land_Radar_01_HQ_F",
	"Land_i_Stone_HouseSmall_V1_dam_F",
	"Land_Shop_City_03_F",
	"Land_Radar_F"
];

private _keep_position = false;
if (_mission_ai) then { _keep_position = true };

private _building_pos = [];
if (isNull _building) then {
	private _allbuildings = (nearestObjects [_sector_pos, _building_classname, _building_range]) select { alive _x  && !(typeOf _x in _building_blacklist) };
	_allbuildings = (_allbuildings - GRLIB_building_used);
	{
		_building = _x;
		_building_pos = ([_building] call BIS_fnc_buildingPositions);
		if (count _building_pos >= _building_ai_max) exitWith { GRLIB_building_used pushBack _building };
	} foreach (_allbuildings call BIS_fnc_arrayShuffle);
} else {
	_building_pos = ([_building] call BIS_fnc_buildingPositions);
};

private _position_count = count _building_pos min _building_ai_max;
if (_position_count == 0) exitWith {
	diag_log format ["--- LRX Error: Can't build squad(%1) type %2 in building %3", _position_count, _type, typeOf _building];
	[]
};

diag_log format ["Spawn building squad(%1) type %2 in building %3 at %4", _position_count, _type, typeOf _building, time];

private _unitclass = [];
while { count _unitclass < _position_count } do { _unitclass pushback (selectRandom _squad_comp) };

_building_pos = (_building_pos call BIS_fnc_arrayShuffle);
private _grp = [_building_pos select 0, _unitclass, _side, "building", _mission_ai] call F_libSpawnUnits;
{
	//_x disableAI "MOVE";
	_x disableAI "PATH";
	_x setUnitPos "UP";
	_x setPos (_building_pos select _forEachIndex);
	[_x, _keep_position] spawn building_defence_ai;
	if (_type == "militia") then { [_x] spawn loadout_militia };
} foreach (units _grp);

diag_log format ["Done Spawning building squad (%1) at %2", count (units _grp), time];

(units _grp);
