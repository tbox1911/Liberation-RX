if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_unit"];

_unit enableIRLasers true;
_unit enableGunLights "Auto";
_unit switchMove "AmovPercMwlkSrasWrflDf";
_unit playMoveNow "AmovPercMwlkSrasWrflDf";
[_unit] spawn F_fixModUnit;
[_unit] spawn PAR_fn_AI_Damage_EH;
gamelogic globalChat format ["Adds %1 (%2) to your squad.", name _unit, rank _unit];
PAR_AI_bros = PAR_AI_bros + [_unit];
