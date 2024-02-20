if (!isServer) exitWith {};
params [
	"_pos",
	["_nbUnits", 7],
	["_type", "infantry"],
	["_patrol", true],
	["_radius", 100]
];


if (isNil "_pos") exitWith {};
diag_log format [ "Spawn SideMission squad type %1 (%2) at %3", _type, _nbUnits, time ];

private _unitTypes = opfor_infantry;
private _side = GRLIB_side_enemy;
switch (_type) do {
	case ("infantry"): { _unitTypes = opfor_infantry };
	case ("militia"): { _unitTypes = militia_squad };
	case ("divers"): { _unitTypes = divers_squad };
	case ("guard"): { _unitTypes = guard_squad };
	case ("medics"): { 
		_unitTypes = a3w_heal_medics;
		_side = GRLIB_side_civilian;
	};
	case ("resistance"): {
		_unitTypes = resistance_squad;
		_side = GRLIB_side_friendly;
	};
};

private _unitclass = [];
while { (count _unitclass) < _nbUnits } do { _unitclass pushback (selectRandom _unitTypes) };
private _grp = [_pos, _unitclass, _side, _type] call F_libSpawnUnits;

//Unit Skill;
//  Novice < 0.25
//  Rookie >= 0.25 and <= 0.45
//  Recruit > 0.45 and <= 0.65
//  Veteran > 0.65 and <= 0.85
//  Expert > 0.85
{
	// cosmetic change
	if (typeOf _x == "C_IDAP_Man_Paramedic_01_F") then {
		//_unit addVest "V_Plain_medical_F";
		_x addGoggles "G_Respirator_white_F";
	};
	if (typeOf _x == "C_scientist_F") then {
		_x addVest "V_Plain_medical_F";
		_x addHeadgear "H_Construction_earprot_vrana_F";
		_x addGoggles "G_Respirator_white_F";
	};

	_x setSkill 0.70;
	_x setSkill ["courage", 1];
	_x allowFleeing 0;
	_x setVariable ["GRLIB_mission_AI", true, true];
	_x setVariable ["acex_headless_blacklist", true, true];
} forEach (units _grp);

if (_type == "guard") then {
	private _unit = selectRandom (units _grp);
	removeBackpack _unit;
	_unit addBackpack "B_AssaultPack_blk";
	_unit addWeapon "launch_MRAWS_green_F";
	_unit addSecondaryWeaponItem "MRAWS_HEAT_F";
	for "_i" from 1 to 2 do { _unit addItemToBackpack "MRAWS_HEAT_F" };
};

if (_patrol) then {
	[_grp, _pos, _radius] spawn defence_ai;
} else {
	[_grp] call F_deleteWaypoints;
};

_grp;