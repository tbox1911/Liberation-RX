params ["_wnded"];

private _bros = [_wnded] call PAR_medic_units;
private _medics = _bros select {
  speed vehicle _x <= 20 &&
  _x distance2D _wnded <= 500 &&
  getPos _x select 2 <= 20 &&
  (!(objectParent _x iskindof "Steerable_Parachute_F")) &&
  isNil {_x getVariable "PAR_busy"}
};

if (count _medics == 0) exitWith {};

// PAR only medic
if (GRLIB_revive == 1) then { _medics = _medics select {[_x] call PAR_is_medic} };
// PAR Medikit/Firstkit
if (GRLIB_revive == 2) then { _medics = _medics select {[_x] call PAR_has_medikit} };

if (count _medics == 0) exitWith {};

// (try to) keep gunner
private _medics_lst = _medics select { !("turret" in (assignedVehicleRole _x)) };
if (count _medics_lst == 0) then { _medics_lst = _medics };

private _medics_sorted = _medics_lst apply {[_x distance2D _wnded, _x]};
_medics_sorted sort true;

(_medics_sorted select 0 select 1);
