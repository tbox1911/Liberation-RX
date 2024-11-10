params ["_medic", "_wnded"];

private _my_medic = _wnded getVariable ["PAR_myMedic", objNull];
if (!isNull _my_medic) then {
	_medic = _my_medic;
	_medic setUnitPos "AUTO";
	{_medic enableAI _x} count ["TARGET","AUTOTARGET","AUTOCOMBAT","SUPPRESSION"];
	[_medic] joinSilent (_medic getVariable "PAR_AIgrp");

	if ((_medic getVariable ["isLeader",false]) && (isplayer _medic)) then {
		[group _medic, _medic] selectLeader groupOwner (_medic getVariable "PAR_AIgrp");
	};

	if (lifeState _medic != "INCAPACITATED") then {
		_medic doFollow leader _medic;
		_medic setSpeedMode (speedMode group player);
		_medic setCaptive false;
	};
	_medic setVariable ["PAR_busy", nil];
};

_wnded setVariable ['PAR_myMedic', nil];
