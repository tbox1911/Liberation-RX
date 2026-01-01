params ["_score"];

private _rank = "None";
private _squad_bonus = 0;
private _infantry_cap = 0;
private _rating = 0;

if (_score < 5) then {
	_rank = "None";
	_squad_bonus = 0;
	_infantry_cap = 5 * GRLIB_resources_multiplier;
};

if (_score >= 0 && _score < GRLIB_perm_inf) then {
	_rank = "Private";
	_squad_bonus = 0;
	_infantry_cap = 15 * GRLIB_resources_multiplier;
	_rating = 500;
};

if (_score >= GRLIB_perm_inf && _score < GRLIB_perm_log) then {
	_rank = "Corporal";
	_squad_bonus = 1;
	_infantry_cap = 20 * GRLIB_resources_multiplier;
	_rating = 1500;
};

if (_score >= GRLIB_perm_log && _score < GRLIB_perm_tank) then {
	_rank = "Sergeant";
	_squad_bonus = 2;
	_infantry_cap = 25 * GRLIB_resources_multiplier;
	_rating = 2500;
};

if (_score >= GRLIB_perm_tank && _score < GRLIB_perm_air) then {
	_rank = "Captain";
	_squad_bonus = 3;
	_infantry_cap = 30 * GRLIB_resources_multiplier;
	_rating = 3500;
};

if (_score >= GRLIB_perm_air && _score < GRLIB_perm_max) then {
	_rank = "Major";
	_squad_bonus = 4;
	_infantry_cap = 40 * GRLIB_resources_multiplier;
	_rating = 5000;
};

if (_score >= GRLIB_perm_max) then {
	_rank = "Colonel";
	_squad_bonus = GRLIB_max_squad_size;
	_infantry_cap = 70 * GRLIB_resources_multiplier;
	_rating = 7500;
};

if (_score >= GRLIB_perm_max*2) then {
	_rank = "Super Colonel";
	_squad_bonus = GRLIB_max_squad_size;
	_infantry_cap = 100 * GRLIB_resources_multiplier;
	_rating = 7500;
};

_squad_bonus = (GRLIB_squad_size + _squad_bonus);
if (_squad_bonus > GRLIB_max_squad_size) then { _squad_bonus = GRLIB_max_squad_size };

[_rank, _squad_bonus, _infantry_cap, _rating];
