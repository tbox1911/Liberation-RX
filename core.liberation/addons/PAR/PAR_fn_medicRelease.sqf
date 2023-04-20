params ["_medic", "_wnded"];

_medic setUnitPos "AUTO";
{_medic enableAI _x} count ["TARGET","AUTOTARGET","AUTOCOMBAT","SUPPRESSION"];
[_medic] joinSilent (_medic getVariable "PAR_AIgrp");

if ((_medic getVariable ["isLeader",false]) && (isplayer _medic)) then {
  [group _medic, _medic] selectLeader groupOwner (_medic getVariable "PAR_AIgrp");
};

_medic doFollow leader _medic;
_medic setSpeedMode (speedMode group player);
_medic setVariable ["PAR_busy", nil];
_medic setCaptive false;

_wnded setVariable ['PAR_myMedic', nil];