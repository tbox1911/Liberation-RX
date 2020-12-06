params [ "_pos" ];
private [ "_idx", "_nbcivs", "_spawnpos", "_grp", "_createdcivs", "_nextciv" ];
_createdcivs = [];

_type = ["Hen_random_F","Goat_random_F","Cock_random_F","Fin_random_F","Sheep_random_F"] call BIS_fnc_selectRandom;
_type = [
	"Cock_random_F","Hen_random_F",
	"Alsatian_Random_F","Fin_random_F",
	"Goat_random_F","Sheep_random_F"
	] call BIS_fnc_selectRandom;

_idx = 0;
_nbcivs = round ((3 + (floor (random 5))) * GRLIB_civilian_activity);
_nbcivs = _nbcivs * ( sqrt ( GRLIB_unitcap ) );
if (_type in ["Alsatian_Random_F","Fin_random_F"]) then {_nbcivs = 2};
if (_type in ["Cock_random_F","Hen_random_F"]) then {_nbcivs = _nbcivs + 2};

_spawnpos = [_pos, 50, 250] call BIS_fnc_findSafePos;
if (surfaceIsWater _spawnpos) exitWith {[]};

while { _idx < _nbcivs } do {
	_nextciv = createAgent [_type, _spawnpos, [], 5, "NONE"];
	_nextciv setName "Animal";
	_nextciv setVariable ["BIS_fnc_animalBehaviour_disable", true];
	_nextciv addMPEventHandler ["MPKilled", {[_this select 0] spawn {sleep 60;deleteVehicle (_this select 0)}}];
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

diag_log format [ "Done Spawning wildlife at %1", time ];

_createdcivs
