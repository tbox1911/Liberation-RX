params ["_score"];

private _data = [_score] call F_getRank;
player setUnitRank (_data select 0);
infantry_cap = _data select 2;
player addRating 3000;

// Ability
if (_score >= GRLIB_perm_max) then {
	player setUnitTrait ["Medic", true];
};

if (_score >= GRLIB_perm_max*2) then {
	player setUnitTrait ["Engineer", true];
};
