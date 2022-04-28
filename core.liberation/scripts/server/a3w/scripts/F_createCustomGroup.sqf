if (!isServer) exitWith {};
params ["_grp", "_pos", ["_nbUnits", 7], ["_type", "infantry"], ["_patrol", true]];
if (isNil "_grp" || isNil "_pos") exitWith {};
diag_log format [ "Spawn SideMission squad type %1 (%2) at %3", _type, _nbUnits, time ];

private _spawnpos = zeropos;
private _radius = 20;
private _max_try = 10;
private _unitTypes = opfor_infantry;

switch (_type) do {
	case ("infantry"): { _unitTypes = opfor_infantry };
	case ("militia"): { _unitTypes = militia_squad };
	case ("divers"): { _unitTypes = divers_squad };
	case ("resistance"): { _unitTypes = resistance_squad };
};

sleep 0.5;
for "_i" from 1 to _nbUnits do {
	if (_type == "divers") then {
		_spawnpos = _pos vectorAdd [floor(random _radius), floor(random _radius), -3];
	} else {
		_spawnpos = _pos vectorAdd [floor(random _radius), floor(random _radius), 0.5];
	};

	while { (_spawnpos isEqualTo zeropos) && _max_try > 0 } do {
		_spawnpos = [getMarkerPos _sector, 0, GRLIB_capture_size, 1, 0, 0, 0, [], [zeropos, zeropos]] call BIS_fnc_findSafePos;
		_max_try = _max_try - 1;
	};
	if (!(_spawnpos isEqualTo zeropos)) then {
		_unit = _grp createUnit [(selectRandom _unitTypes), _spawnpos, [], 5, "NONE"];
		_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_unit allowDamage false;
		_unit setSkill 0.6;
		_unit setSkill ["courage", 1];
		_unit allowFleeing 0;
		_unit setVariable ["GRLIB_mission_AI", true];
		_unit switchMove "amovpknlmstpsraswrfldnon";
		if (_type == "militia") then { 
			[ _unit ] call loadout_militia;
		};	
		[ _unit ] call reammo_ai;
		sleep 0.1;
	};
};

if (_patrol) then { [_grp, _spawnpos] spawn add_defense_waypoints };

sleep 5;
{ _x allowDamage true } forEach (units _grp);

//Unit Skill;
//  Novice < 0.25
//  Rookie >= 0.25 and <= 0.45
//  Recruit > 0.45 and <= 0.65
//  Veteran > 0.65 and <= 0.85
//  Expert > 0.85