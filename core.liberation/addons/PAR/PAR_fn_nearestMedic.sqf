params ["_wnded"];

private _grp_id = _wnded getVariable ["PAR_Grp_ID","1"];
private _medics = (units group _wnded) select {
    ((_x getVariable ["PAR_Grp_ID","0"]) == _grp_id) &&
    (_x distance2D _wnded <= 500) &&
    !(isPlayer _x) && !([_x] call PAR_is_wounded) &&
    !(objectParent _x iskindof "ParachuteBase") &&
    isNil {_x getVariable "PAR_busy"}
};

if (count _medics == 0) exitWith {};

// PAR Medikit/Firstkit
if (PAR_revive == 2) then { _medics = _medics select {[_x] call PAR_has_medikit} };

// PAR only medic
if (PAR_revive == 3) then { _medics = _medics select {[_x] call PAR_is_medic} };

if (count _medics == 0) exitWith {};

// (try to) keep gunner
//private _medics_lst = _medics select { !("turret" in (assignedVehicleRole _x)) };
//if (count _medics_lst == 0) then { _medics_lst = _medics };

private _medics_sorted = _medics apply {[_x distance2D _wnded, _x]};
_medics_sorted sort true;

(_medics_sorted select 0 select 1);
