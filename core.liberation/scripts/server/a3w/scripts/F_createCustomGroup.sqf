if (!isServer) exitWith {};

private ["_grp", "_pos", "_nbUnits", "_type", "_unitTypes", "_uPos", "_unit"];

_grp = _this select 0;
_pos = _this select 1;
_nbUnits = param [2, 7, [0]];
_type =  param [3, "infantry"];
_radius = 10;

switch (_type) do {
	case ("infantry"): { _unitTypes = opfor_infantry };
	case ("militia"): { _unitTypes = militia_squad };
	case ("divers"): { _unitTypes = divers_squad };
	case ("resistance"): { _unitTypes = resistance_squad };
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

for "_i" from 1 to _nbUnits do {
	if (_type == "divers") then {
		 _seadepth = getTerrainHeightASL _pos;
		_uPos = _pos vectorAdd ([[random _radius, 0, _seadepth + 3], random 360] call BIS_fnc_rotateVector2D);
	} else {
		_uPos = _pos vectorAdd ([[random _radius, 0, 0], random 360] call BIS_fnc_rotateVector2D);
	};
	_unit = _grp createUnit [_unitTypes call BIS_fnc_selectRandom, _uPos, [], 0, "NONE"];
	[_unit] call unitSetSkill;
};

[ _grp, _pos, 75] spawn add_defense_waypoints;

//Unit Skill;
//  Novice < 0.25
//  Rookie >= 0.25 and <= 0.45
//  Recruit > 0.45 and <= 0.65
//  Veteran > 0.65 and <= 0.85
//  Expert > 0.85