params ["_classname"];

private _pos = getPosATL player;
private _alt = _pos select 2;
private _grp = group player;
private _unit = _grp createUnit [_classname, _pos, [], 5, "NONE"];
[_unit] joinSilent _grp;
_unit setVariable ["PAR_Grp_ID", format["Bros_%1", PAR_Grp_ID], true];
[_unit] call PAR_fn_AI_Damage_EH;
[_unit] call F_fixModUnit;

if (surfaceIsWater _pos) then {
    _pos = ([_pos, 3] call F_getRandomPos);
    _pos set [2, _alt];
    _unit setPosASL (ATLtoASL _pos);
};
_unit enableIRLasers true;
_unit enableGunLights "Auto";
_unit setUnitRank "PRIVATE";
_unit setSkill 0.6;

if (GRLIB_force_english) then { _unit setSpeaker (format ["Male0%1ENG", round (1 + floor random 9)]) };

[_unit, configOf _unit] call BIS_fnc_loadInventory;
private _class_overide = toLower _classname;
if (_class_overide in units_loadout_overide) then {
    private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, _class_overide];
    [_path, _unit] call F_getTemplateFile;
};

PAR_AI_bros = PAR_AI_bros + [_unit];
stats_blufor_soldiers_recruited = stats_blufor_soldiers_recruited + 1;
publicVariable "stats_blufor_soldiers_recruited";
build_refresh = true;