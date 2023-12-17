params ["_classname"];

private _pos = getPosATL player;
private _grp = createGroup [GRLIB_side_friendly, true];
player setVariable ["my_squad", _grp, true];
_grp setGroupId [format ["%1 %2", squads_names select buildindex, groupId _grp]];

private ["_unitrank", "_unit"];
{
    _unitrank = "PRIVATE";
    if(_forEachIndex == 0) then { _unitrank = "SERGEANT"; };
    if(_forEachIndex == 1) then { _unitrank = "CORPORAL"; };
    _unit = _grp createUnit [_x, _pos, [], 5, "NONE"];
    [_unit] joinSilent _grp;
    _unit setUnitRank _unitrank;
    _unit setSkill 0.6;
    _unit enableIRLasers true;
    _unit enableGunLights "Auto";
    _unit setVariable ["PAR_Grp_ID", format["AI_%1",PAR_Grp_ID], true];
    //_unit forceAddUniform (uniform player);
    [_unit] spawn PAR_fn_AI_Damage_EH;
    sleep 0.2;
} foreach _classname;

_grp setCombatMode "GREEN";
_grp setBehaviour "AWARE";

stats_blufor_soldiers_recruited = stats_blufor_soldiers_recruited + count (units _grp);
publicVariable "stats_blufor_soldiers_recruited";
player hcSetGroup [_grp];
build_refresh = true;