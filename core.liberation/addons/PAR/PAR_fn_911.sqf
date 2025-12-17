params ["_wnded","_medic"];

_medic allowDamage false;
_medic setCaptive true;
_medic setHitPointDamage ["hitLegs",0];
_medic setVariable ["PAR_AIteam", assignedTeam _medic];

private _grpmedic = createGroup [GRLIB_side_civilian, true];
sleep 0.2;
[_medic] joinSilent _grpmedic;
_grpmedic setBehaviourStrong "AWARE";
_grpmedic selectLeader _medic;

if (!isnull objectParent _medic) then {
	unassignVehicle _medic;
	doGetOut _medic;
	sleep 3;
};
_medic stop true;
unassignVehicle _medic;
[_medic] orderGetIn false;
[_medic] allowGetIn false;
sleep 1;

{_medic disableAI _x} forEach ["TARGET","AUTOTARGET","AUTOCOMBAT","SUPPRESSION"];
_medic setUnitPos "UP";
_medic setSpeedMode "FULL";
_medic allowFleeing 0;
_medic allowDamage true;
_medic stop false;

private _dist = (_medic distance2D _wnded);
if ( _dist <= 6 ) then {
	[_wnded, _medic] spawn PAR_fn_sortie
} else {
	if (_dist < 35) then {
		_medic doMove (getPosATL _wnded);
	} else {
		_medic doMove (getPos _wnded);
	};
	sleep 5;
	[_wnded, _medic] spawn PAR_fn_checkMedic;
};
