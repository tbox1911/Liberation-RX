if (!isServer) exitWith {};
params [
	"_grp",
	"_pos",
	["_nbUnits", 7],
	["_type", "infantry"],
	["_patrol", true]
];
if (isNil "_grp" || isNil "_pos") exitWith {};
diag_log format [ "Spawn SideMission squad type %1 (%2) at %3", _type, _nbUnits, time ];

private _unitTypes = opfor_infantry;
switch (_type) do {
	case ("infantry"): { _unitTypes = opfor_infantry };
	case ("militia"): { _unitTypes = militia_squad };
	case ("divers"): { _unitTypes = divers_squad };
	case ("resistance"): { _unitTypes = resistance_squad };
	case ("guard"): { _unitTypes = guard_squad };
};

private _unitclass = [];
while { (count _unitclass) < _nbUnits } do { _unitclass pushback (selectRandom _unitTypes) };
private _grp_tmp = [_pos, _unitclass, GRLIB_side_enemy, _type] call F_libSpawnUnits;

{
	[_x] joinSilent _grp; 
	_x setSkill 0.70;
	_x setSkill ["courage", 1];
	_x allowFleeing 0;
	_x setVariable ["GRLIB_mission_AI", true];
} forEach (units _grp_tmp);

sleep 1;
if (_patrol) then { [_grp, _pos] spawn add_defense_waypoints };

//Unit Skill;
//  Novice < 0.25
//  Rookie >= 0.25 and <= 0.45
//  Recruit > 0.45 and <= 0.65
//  Veteran > 0.65 and <= 0.85
//  Expert > 0.85