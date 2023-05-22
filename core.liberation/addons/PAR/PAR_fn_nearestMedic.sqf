params ["_wnded"];

private _medics = PAR_AI_bros select {
  speed vehicle _x <= 20 &&
  _x distance2D _wnded <= 600 && getPos _x select 2 <= 20 &&
  (!(objectParent _x iskindof "Steerable_Parachute_F")) &&
  lifeState _x != "INCAPACITATED" &&
  isNil {_x getVariable "PAR_busy"}
};

if (count _medics == 0) exitWith {};

// PAR only medic
if (GRLIB_revive == 1) then { _medics = _medics select {[_x] call PAR_is_medic} };
// PAR Medikit/Firstkit
if (GRLIB_revive == 2) then { _medics = _medics select {[_x] call PAR_has_medikit} };

if (count _medics == 0) exitWith {};

private _medics_lst = _medics apply {[_x distance2D _wnded, _x]};
_medics_lst sort true;
private _medic = _medics_lst select 0 select 1;

_medic;