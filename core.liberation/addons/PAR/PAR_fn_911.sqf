params ["_wnded","_medic"];

_medic setHitPointDamage ["hitLegs",0];
_medic allowDamage false;
_medic setCaptive true;

_grpmedic = createGroup [GRLIB_side_civilian, true];
[_medic] joinSilent _grpmedic;
_grpmedic setBehaviour "AWARE";

unassignVehicle _medic;
if (!isnull objectParent _medic) then {
  doGetOut _medic;
  sleep 3;
};
doStop _medic;
sleep 1;
{_medic disableAI _x} count ["TARGET","AUTOTARGET","AUTOCOMBAT","SUPPRESSION"];
_medic setUnitPos "UP";
_medic setSpeedMode "FULL";
_medic allowFleeing 0;
_medic allowDamage true;

_dist = round (_wnded distance2D _medic);
if ( _dist <= 6 ) then {
  [_wnded, _medic] spawn PAR_fn_checkMedic;
} else {
  if (_dist < 25) then {
    _medic doMove (getPosATL _wnded);
  } else {
    _medic doMove (getPos _wnded);
  };
  [_wnded,_medic] spawn PAR_fn_checkMedic;
};

