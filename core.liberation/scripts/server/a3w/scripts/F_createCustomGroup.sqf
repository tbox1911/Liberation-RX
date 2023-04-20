if (!isServer) exitWith {};

private _grp = _this select 0;
private _pos = _this select 1;
private _nbUnits = param [2, 7, [0]];
private _type =  param [3, "infantry"];
private _patrol = param [4, true];
private _radius = 20;
private _uPos = zeropos;
private _unitTypes = opfor_infantry;

if (isNil "_grp") exitWith {};

switch (_type) do {
	case ("militia"): { _unitTypes = militia_squad };
	case ("divers"): { _unitTypes = divers_squad };
	case ("resistance"): { _unitTypes = resistance_squad };
};
diag_log format [ "Spawning SideMission squad %1 %2 at %3", _nbUnits, _type , time ];
sleep 0.5;
for "_i" from 1 to _nbUnits do {
	if (_type == "divers") then {
		 _seadepth = abs (getTerrainHeightASL _pos);
		_uPos = _pos vectorAdd ([[floor(random _radius), floor(random _radius), _seadepth + 3], random 360] call BIS_fnc_rotateVector2D);
	} else {
		_uPos = _pos vectorAdd ([[floor(random _radius), floor(random _radius), 0.5], random 360] call BIS_fnc_rotateVector2D);
	};

	_unit = _grp createUnit [(selectRandom _unitTypes), _uPos, [], 5, "NONE"];
	_unit allowDamage false;
	_unit addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	_unit setSkill 0.6;
	_unit setSkill ["courage", 1];
	_unit allowFleeing 0;
	_unit setVariable ["mission_AI", true];
	_unit switchMove "amovpknlmstpsraswrfldnon";
};

if (_patrol) then { [ _grp, _pos, 200] spawn add_defense_waypoints };

sleep 5;
{ _x allowDamage true } forEach (units _grp);

//Unit Skill;
//  Novice < 0.25
//  Rookie >= 0.25 and <= 0.45
//  Recruit > 0.45 and <= 0.65
//  Veteran > 0.65 and <= 0.85
//  Expert > 0.85