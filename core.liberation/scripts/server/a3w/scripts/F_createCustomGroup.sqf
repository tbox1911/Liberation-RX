if (!isServer) exitWith {};

private ["_group", "_pos", "_nbUnits", "_type", "_unitTypes", "_uPos", "_unit"];

_group = _this select 0;
_pos = _this select 1;
_nbUnits = param [2, 7, [0]];
_type =  param [3, ""];
_radius = 10;

switch (_type) do {
	case ("infantry"): { _unitTypes = opfor_infantry };
	case ("militia"): { _unitTypes = militia_squad };
	case ("divers"): { _unitTypes = divers_squad };
	case ("resistance"): { _unitTypes = resistance_squad };
	default { _unitTypes = [] };
};

unitSetSkill = {
    params ["_unit"];
	_unit setSkill 0.65;
	_unit setSkill ["courage", 1];
	_unit allowFleeing 0;
	_unit setVariable ['mission_AI', true];
	_unit addRating 9999999;
	//_accuracy = 1; // Relative multiplier; absolute default accuracy for ARMA3 is 0.25
	//_unit setSkill ["aimingAccuracy", (_unit skill "aimingAccuracy") * _accuracy];
	_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
};

unitCreateCustom = {
	params ["_unit", "_i"];
	removeAllWeapons _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	_unit addUniform "U_O_CombatUniform_ocamo";
	_unit addItemToUniform "FirstAidKit";
	_unit addItemToUniform "30Rnd_65x39_caseless_green";
	_unit addItemToUniform "30Rnd_65x39_caseless_green";
	_unit addVest "V_PlateCarrier2_blk";
	_unit addItemToVest "30Rnd_65x39_caseless_green";
	_unit addItemToVest "30Rnd_65x39_caseless_green";
	_unit addItemToVest "30Rnd_65x39_caseless_green";
	_unit addItemToVest "30Rnd_65x39_caseless_green";
	_unit addItemToVest "HandGrenade";
	_unit addHeadgear "H_HelmetO_ocamo";

	switch (true) do {
		// Grenadier every 3 units
		case (_i % 3 == 0):	{
			_unit addMagazine "1Rnd_HE_Grenade_shell";
			_unit addWeapon "arifle_Katiba_GL_ARCO_pointer_F";
			_unit addMagazine "1Rnd_HE_Grenade_shell";
			_unit addMagazine "1Rnd_HE_Grenade_shell";
			_unit addMagazine "1Rnd_HE_Grenade_shell";
			_unit addMagazine "1Rnd_HE_Grenade_shell";
		};

		// MG every 4 units
		case (_i % 4 == 0):	{
			removeallweapons _unit;
			_unit addItemToUniform "FirstAidKit";
			_unit addItemToUniform "FirstAidKit";
			_unit addMagazine "150Rnd_762x54_Box";
			_unit addWeapon "LMG_Zafir_ARCO_F";
			_unit addMagazine "150Rnd_762x54_Box";
			_unit addMagazine "150Rnd_762x54_Box";
		};

		// RPG-42 every 5
		case (_i % 5 == 0):	{
			_unit addBackpack "B_Kitbag_mcamo";
			_unit addWeapon "arifle_Katiba_ARCO_pointer_F";
			_unit addMagazine "RPG32_F";
			_unit addWeapon "launch_RPG32_F";
			_unit addMagazine "RPG32_F";
			_unit addMagazine "RPG32_F";
		};

		// Titan-AA every 6
		case (_i % 6 == 0):	{
			_unit addBackpack "B_Kitbag_mcamo";
			_unit addWeapon "arifle_Katiba_ARCO_pointer_F";
			_unit addMagazine "Titan_AA";
			_unit addWeapon "launch_O_Titan_F";
			_unit addMagazine "Titan_AA";
			_unit addMagazine "Titan_AA";
		};
		// Rifleman
		default {
			if (_unit == leader _group) then {
				_unit addWeapon "arifle_Katiba_ARCO_pointer_F";
				_unit addItemToVest "HandGrenade";
				_unit addItemToVest "HandGrenade";
				_unit addItemToUniform "FirstAidKit";
				_unit setRank "SERGEANT";
			} else {
				_unit addWeapon "arifle_Katiba_ACO_F";
				_unit addItemToUniform "FirstAidKit";
				_unit addItemToUniform "30Rnd_65x39_caseless_green";
				_unit addItemToUniform "30Rnd_65x39_caseless_green";
			};
		};
	};
	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit enablegunlights "forceOn";
};

for "_i" from 1 to _nbUnits do {
	if (_type == "divers") then {
		 _seadepth = getTerrainHeightASL _pos;
		_uPos = _pos vectorAdd ([[random _radius, 0, _seadepth + 3], random 360] call BIS_fnc_rotateVector2D);
	} else {
		_uPos = _pos vectorAdd ([[random _radius, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	};
	if (count _unitTypes == 0) then {
		_unit = _group createUnit ["O_G_Soldier_F", _uPos, [], 0, "NONE"];
		[_unit, _i] call unitCreateCustom;
	} else {
		_unit = _group createUnit [_unitTypes call BIS_fnc_selectRandom, _uPos, [], 0, "NONE"];
	};
	[_unit] call unitSetSkill;
};

[_group, _pos] call defendArea;

//Unit Skill;
//  Novice < 0.25
//  Rookie >= 0.25 and <= 0.45
//  Recruit > 0.45 and <= 0.65
//  Veteran > 0.65 and <= 0.85
//  Expert > 0.85