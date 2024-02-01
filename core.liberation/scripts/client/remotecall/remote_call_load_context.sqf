params ["_class", "_rank", "_loadout"];

if (isDedicated || (!hasInterface && !isServer)) exitWith {};

if (count units player > (GRLIB_squad_size + GRLIB_squad_size_bonus)) exitWith {};
private _pos = getPosATL player;
if (surfaceIsWater _pos) then { _pos = getPosASL player };
private _unit = (group player) createUnit [_class, _pos, [], 10, "NONE"];
[_unit] joinSilent (group player);
_unit setVariable ["PAR_Grp_ID", format["Bros_%1", PAR_Grp_ID], true];
clearAllItemsFromBackpack _unit;
_unit setUnitLoadout _loadout;
_unit setUnitRank _rank;
_unit setSkill (0.6 + (GRLIB_rank_level find _rank) * 0.05);
_unit enableIRLasers true;
_unit enableGunLights "Auto";
//_unit setpos (getpos _unit);
_unit switchMove "AmovPercMwlkSrasWrflDf";
_unit playMoveNow "AmovPercMwlkSrasWrflDf";
[_unit] spawn F_fixModUnit;
[_unit] spawn PAR_fn_AI_Damage_EH;
gamelogic globalChat format ["Adds %1 (%2) to your squad.", name _unit, rank _unit];
PAR_AI_bros = PAR_AI_bros + [_unit];
