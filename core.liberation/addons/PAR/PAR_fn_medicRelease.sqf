params ["_medic", "_wnded"];

private _release_medic = {
	params ["_medic"];
	if (!local _medic || isNull _medic) exitWith {};
	_medic setUnitPos "AUTO";
	{_medic enableAI _x} forEach ["TARGET","AUTOTARGET","AUTOCOMBAT","SUPPRESSION"];
	[_medic] joinSilent (_medic getVariable "PAR_AIgrp");

	if ((_medic getVariable ["isLeader",false]) && (isplayer _medic)) then {
		[group _medic, _medic] selectLeader groupOwner (_medic getVariable "PAR_AIgrp");
	};

	if !([_medic] call PAR_is_wounded) then {
		_medic doFollow leader _medic;
		_medic setSpeedMode (speedMode group player);
		_medic setCaptive false;
	};
	_medic setVariable ["PAR_busy", nil];
};

[_medic] call _release_medic;
private _my_medic = _wnded getVariable ["PAR_myMedic", objNull];
if (!isNull _my_medic && _my_medic != _medic) then {
	[_my_medic] call _release_medic;
};

_wnded setVariable ["PAR_myMedic", nil];
