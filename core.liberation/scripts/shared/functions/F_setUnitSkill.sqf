params ["_unit", ["_ai_rank", "PRIVATE"]];
if (isNull _unit) exitWith {};
if !(_ai_rank in GRLIB_rank_level) exitWith {};

// Novice < 0.25
// Rookie >= 0.25 and <= 0.45
// Recruit > 0.45 and <= 0.65
// Veteran > 0.65 and <= 0.85
// Expert > 0.85

private _skill_range = [
    [0.25, 0.45],
    [0.30, 0.50],
    [0.35, 0.55],
    [0.40, 0.50],
    [0.50, 0.60],
    [0.60, 0.70],
    [0.70, 0.80]    
];

private _calc_skill = {
    params ["_rank", "_modifier"];
    (_skill_range select _rank) params ["_min", "_max"];
    private _base = _min + random (_max - _min);
    (_base + _modifier);
};

private _rank = (GRLIB_rank_level find _ai_rank);
_unit setSkill ["reloadSpeed",    ([_rank, 0.0] call _calc_skill)];
_unit setSkill ["courage",        ([_rank, 0.0] call _calc_skill)];
_unit setSkill ["aimingSpeed",    ([_rank, 0.0] call _calc_skill)];
_unit setSkill ["spotDistance",   ([_rank, 0.0] call _calc_skill)];
_unit setSkill ["aimingAccuracy", ([_rank, 0.0] call _calc_skill)];
_unit setSkill ["aimingShake",    ([_rank, 0.0] call _calc_skill)];
_unit setSkill ["spotTime",       ([_rank, 0.0] call _calc_skill)];
_unit setSkill ["commanding",     1];
_unit setSkill ["general",        1];
