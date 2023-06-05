params [ "_pos" ];

private _createdcivs = [];
private _spawnpos = [_pos, 80, 300] call BIS_fnc_findSafePos;
if (surfaceIsWater _spawnpos) exitWith {_createdcivs};

private _type_random = [
	"Cock_random_F",
	"Hen_random_F",
	"Alsatian_Random_F",
	"Fin_random_F",
	"Goat_random_F",
	"Sheep_random_F"
];

private _type_desert = [
	"Dromedary_03_lxWS",
	"Dromedary_02_lxWS",
	"Dromedary_03_saddle2_lxWS",
	"Dromedary_03_saddle_lxWS",
	"Dromedary_01_saddle_lxWS",
	"Dromedary_01_saddle2_lxWS",
	"Dromedary_04_saddle_lxWS",
	"Dromedary_04_saddle2_lxWS",
	"Dromedary_04_lxWS"
];

private _is_desert = (worldname in ["SefrouRamal", "Takistan", "Isladuala3"] && GRLIB_WS_enabled);
private _nbcivs = (3 + floor(random 4));
private _type = selectRandom _type_random;
if (_is_desert) then { _type = selectRandom (_type_random + _type_desert) };
private _is_dromedary = (_type select [0,11] == "Dromedary_");
if (_type in ["Alsatian_Random_F","Fin_random_F"]) then { _nbcivs = 2 };
if (_type in ["Cock_random_F","Hen_random_F"]) then { _nbcivs = _nbcivs + 2 };

for "_n" from 1 to _nbcivs do {
	if (_is_dromedary) then { _type = selectRandom _type_desert };
	_nextciv = createAgent [_type, _spawnpos, [], 5, "NONE"];
	_nextciv setVariable ["BIS_fnc_animalBehaviour_disable", true];
	_nextciv setName "Animal";
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
};

diag_log format [ "Done Spawning wildlife %1 %2 at %3",_nbcivs, _type, time ];
_createdcivs;
