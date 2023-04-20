params [ "_pos" ];

private _createdcivs = [];
private _type = selectRandom ["Cock_random_F","Hen_random_F","Alsatian_Random_F","Fin_random_F","Goat_random_F","Sheep_random_F"];
private _nbcivs = (3 + floor(random 4));

if (_type in ["Alsatian_Random_F","Fin_random_F"]) then {_nbcivs = 2};
if (_type in ["Cock_random_F","Hen_random_F"]) then {_nbcivs = _nbcivs + 2};

private _spawnpos = [_pos, 80, 300] call BIS_fnc_findSafePos;
if (surfaceIsWater _spawnpos) exitWith {[]};

private _idx = 0;
while { _idx < _nbcivs } do {
	_nextciv = createAgent [_type, _spawnpos, [], 5, "NONE"];
	_nextciv setName "Animal";
	_nextciv setVariable ["BIS_fnc_animalBehaviour_disable", true];
	_nextciv addMPEventHandler ["MPKilled", {(_this select 0) spawn {sleep 60; deletevehicle _this}}];
	_nextciv setSpeaker "NoVoice";
	//_nextciv disableAI "FSM";
	_nextciv disableAI "AIMINGERROR";
	_nextciv disableAI "SUPPRESSION";
	_nextciv disableAI "AUTOTARGET";
	_nextciv disableAI "TARGET";
	_nextciv setCombatMode "BLUE";
	_nextciv setBehaviour "SAFE";
	_createdcivs pushBack _nextciv;
	_idx = _idx + 1;
};

diag_log format [ "Done Spawning wildlife %1 %2 at %3",_nbcivs, _type, time ];
_createdcivs;
