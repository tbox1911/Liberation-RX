params ["_classname"];

private _pos = getPosATL player;
private _grp = createGroup [GRLIB_side_friendly, true];
player setVariable ["my_squad", _grp, true];
_grp setGroupIdGlobal [format ["%1 %2", squads_names select buildindex, groupId _grp]];

private ["_unitrank", "_unit", "_class_overide"];
{
	_unitrank = "PRIVATE";
	if(_forEachIndex == 0) then { _unitrank = "SERGEANT" };
	if(_forEachIndex == 1) then { _unitrank = "CORPORAL" };
	_unit = _grp createUnit [_x, _pos, [], 15, "NONE"];
	[_unit] joinSilent _grp;
	_unit setVariable ["PAR_Grp_ID", format["AI_%1", PAR_Grp_ID], true];
	[_unit] call PAR_fn_AI_Damage_EH;
	[_unit] call F_fixModUnit;
	_unit setUnitRank _unitrank;
	_unit setSkill 0.6;
	_unit enableIRLasers true;
	_unit enableGunLights "Auto";
	if (GRLIB_force_english) then { _unit setSpeaker (format ["Male0%1ENG", round (1 + floor random 9)]) };
	_class_overide = toLower _x;
	if (_class_overide in units_loadout_overide) then {
		private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, _class_overide];
		[_path, _unit] call F_getTemplateFile;
	};
	sleep 0.2;
} foreach _classname;

_grp setCombatMode "GREEN";
_grp setBehaviourStrong "AWARE";

stats_blufor_soldiers_recruited = stats_blufor_soldiers_recruited + count (units _grp);
publicVariable "stats_blufor_soldiers_recruited";
if (player != hcLeader _grp) then {
	(hcLeader _grp) hcRemoveGroup _grp;
	player hcSetGroup [_grp];
};

[true] call player_squad_actions;
build_refresh = true;