params ["_medic", "_wnded"];

if (isNull _medic) exitWith { _wnded setVariable ['PAR_myMedic', nil] };

private _my_medic = _wnded getVariable ["PAR_myMedic", objNull];
if (_my_medic == _medic) then {
  _wnded setVariable ['PAR_myMedic', nil];
};

if !(local _medic) exitWith {};

_medic setUnitPos "AUTO";
{_medic enableAI _x} count ["TARGET","AUTOTARGET","AUTOCOMBAT","SUPPRESSION"];
[_medic] joinSilent (_medic getVariable "PAR_AIgrp");

if ((_medic getVariable ["isLeader",false]) && (isplayer _medic)) then {
  [group _medic, _medic] selectLeader groupOwner (_medic getVariable "PAR_AIgrp");
};

_medic setVariable ["PAR_busy", nil];
if (lifeState _medic != "INCAPACITATED") then {
  _medic doFollow leader _medic;
  _medic setSpeedMode (speedMode group player);
  _medic setCaptive false;
};
