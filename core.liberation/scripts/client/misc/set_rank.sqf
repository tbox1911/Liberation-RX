params ["_score"];

private _data = [_score] call F_getRank;
private _rank = _data select 0;
infantry_cap = _data select 2;

player addRating 3000;

// Ability
if (_rank == "Colonel") then { 
	player setUnitTrait ["Medic", true];
};

if (_rank == "Super Colonel") then {
	player setUnitTrait ["Medic", true];
	player setUnitTrait ["Engineer", true];
	_rank = "Colonel" 
};

player setUnitRank _rank;