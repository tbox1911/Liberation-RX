params [ "_unit" ];

private _score = [_unit] call F_getScore;
private _rank = "Private";
GRLIB_squad_size_bonus = 0;

if ((_score >=  0) && (_score < GRLIB_perm_inf)) then {_rank = "Private"};
if ((_score >= GRLIB_perm_inf) && (_score < GRLIB_perm_log)) then {
	_rank = "Corporal";
	GRLIB_squad_size_bonus = 1;
};
if ((_score >= GRLIB_perm_log) && (_score < GRLIB_perm_tank)) then {
	_rank = "Sergeant";
	GRLIB_squad_size_bonus = 2;
};
if ((_score >= GRLIB_perm_tank) && (_score < GRLIB_perm_air)) then {
	_rank = "Captain";
	GRLIB_squad_size_bonus = 3;
};
if ((_score >= GRLIB_perm_air) && (_score < GRLIB_perm_max)) then {
	_rank = "Major";
	GRLIB_squad_size_bonus = 4;
};
if (_score >= GRLIB_perm_max) then {
	_rank = "Colonel";
	GRLIB_squad_size_bonus = 5;
};
// if (_score >= 2 * GRLIB_perm_max) then {
// 	GRLIB_squad_size_bonus = 6;
// };

if ( (GRLIB_squad_size + GRLIB_squad_size_bonus) > GRLIB_max_squad_size) then {
	GRLIB_squad_size_bonus = (GRLIB_max_squad_size - GRLIB_squad_size);
};

_unit setUnitRank _rank;
_unit setVariable ["GRLIB_Rank", _rank, true];
_unit addRating 1000;
_rank;