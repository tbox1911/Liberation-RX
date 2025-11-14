params ["_medic", "_wnded"];

private _release_medic = {
	params ["_medic"];
	if (!local _medic || isNull _medic) exitWith {};
	if (isPlayer _medic) exitWith {};

	[_medic] joinSilent (_medic getVariable "PAR_Grp_AI");
	_medic assignTeam (_medic getVariable "PAR_AIteam");

	if !([_medic] call PAR_is_wounded) then {
		{_medic enableAI _x} forEach ["TARGET","AUTOTARGET","AUTOCOMBAT","SUPPRESSION"];
		_medic doFollow leader _medic;
		_medic setSpeedMode (speedMode group player);
		_medic setCaptive false;
	};
	_medic setVariable ["PAR_busy", nil];
};

[_medic] call _release_medic;
private _my_medic = _wnded getVariable ["PAR_myMedic", objNull];
if (!isNull _my_medic && _my_medic != _medic) then { [_my_medic] call _release_medic };

_wnded setVariable ["PAR_myMedic", nil];
