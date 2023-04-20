if (!isServer) exitWith {};

private _grp = _this select 0;
private _pos = _this select 1;
private _nbUnits = param [2, 7, [0]];
private _type =  param [3, "infantry"];
private _patrol = param [4, true];
private _radius = 10;
private _uPos = zeropos;
private _unitTypes = opfor_infantry;

if (isNil "_grp") exitWith {};

switch (_type) do {
	case ("militia"): { _unitTypes = militia_squad };
	case ("divers"): { _unitTypes = divers_squad };
	case ("resistance"): { _unitTypes = resistance_squad };
};

sleep 0.5;
for "_i" from 1 to _nbUnits do {
	if (_type == "divers") then {
		 _seadepth = getTerrainHeightASL _pos;
		_uPos = _pos vectorAdd ([[floor(random _radius), 0, _seadepth + 3], random 360] call BIS_fnc_rotateVector2D);
	} else {
		_uPos = _pos vectorAdd ([[floor(random _radius), 0, 1], random 360] call BIS_fnc_rotateVector2D);
	};
	(selectRandom _unitTypes) createUnit [_uPos, _grp, "this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.65, "PRIVATE"];
};

{
	_x setSkill ["courage", 1];
	_x allowFleeing 0;
	_x setVariable ["mission_AI", true];
	_x switchMove "amovpknlmstpsraswrfldnon";
} forEach (units _grp);

if (_patrol) then {
	[ _grp, _pos, 200] spawn add_defense_waypoints;
};

//Unit Skill;
//  Novice < 0.25
//  Rookie >= 0.25 and <= 0.45
//  Recruit > 0.45 and <= 0.65
//  Veteran > 0.65 and <= 0.85
//  Expert > 0.85