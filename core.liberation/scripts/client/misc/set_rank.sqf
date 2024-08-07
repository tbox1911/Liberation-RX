private _score = [player] call F_getScore;
private _rank = "Private";

if ((_score < 0)) then {
	GRLIB_squad_size_bonus = 0;
	infantry_cap = 5 * GRLIB_resources_multiplier;
};

if ((_score >= 0) && (_score < GRLIB_perm_inf)) then {
	GRLIB_squad_size_bonus = 0;
	infantry_cap = 15 * GRLIB_resources_multiplier;
};

if ((_score >= GRLIB_perm_inf) && (_score < GRLIB_perm_log)) then {
	_rank = "Corporal";
	GRLIB_squad_size_bonus = 1;
	infantry_cap = 20 * GRLIB_resources_multiplier;
};

if ((_score >= GRLIB_perm_log) && (_score < GRLIB_perm_tank)) then {
	_rank = "Sergeant";
	GRLIB_squad_size_bonus = 2;
	infantry_cap = 25 * GRLIB_resources_multiplier;
};

if ((_score >= GRLIB_perm_tank) && (_score < GRLIB_perm_air)) then {
	_rank = "Captain";
	GRLIB_squad_size_bonus = 3;
	infantry_cap = 30 * GRLIB_resources_multiplier;
};

if ((_score >= GRLIB_perm_air) && (_score < GRLIB_perm_max)) then {
	_rank = "Major";
	GRLIB_squad_size_bonus = 4;
	infantry_cap = 40 * GRLIB_resources_multiplier;
};

if (_score >= GRLIB_perm_max) then {
	_rank = "Colonel";
	GRLIB_squad_size_bonus = 5;
	infantry_cap = 70 * GRLIB_resources_multiplier;
	player setUnitTrait ["Medic", true];
};

if (_score >= GRLIB_perm_max*2) then {
	_rank = "Colonel";
	GRLIB_squad_size_bonus = 6;
	infantry_cap = 100 * GRLIB_resources_multiplier;
	player setUnitTrait ["Engineer", true];
};

if ( (GRLIB_squad_size + GRLIB_squad_size_bonus) > GRLIB_max_squad_size) then {
	GRLIB_squad_size_bonus = (GRLIB_max_squad_size - GRLIB_squad_size);
};

player setUnitRank _rank;
player addRating 100;
