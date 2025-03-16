params ["_wnded"];

private _grp_id = _wnded getVariable ["PAR_Grp_ID","1"];
private _medics = (units group _wnded) select {
    ((_x getVariable ["PAR_Grp_ID","0"]) == _grp_id) &&
    (_x distance2D _wnded <= 500) &&
    (speed vehicle _x <= 20) && (getPos _x select 2 <= 15) &&
    !(isPlayer _x) && !([_x] call PAR_is_wounded) &&
    !(objectParent _x iskindof "ParachuteBase") &&
    isNil {_x getVariable "PAR_busy"}
};

if (count _medics == 0) exitWith {};

// PAR Medikit/Firstkit
if (PAR_revive == 2) then { _medics = _medics select {[_x] call PAR_has_medikit} };

// PAR only medic
if (PAR_revive == 3) then { _medics = _medics select {[_x] call PAR_is_medic} };

// no Medic available
if (count _medics == 0) exitWith {};

// Better method of checking gunner (thx to ScottTMConnors)
private _medic_outside = _medics select { isNull objectParent _x };
private _medics_lst = [];
if (count _medic_outside > 0) then {
	_medics_lst = _medic_outside;
} else {
    private _not_gunners = _medics select {
        !("turret" in (assignedVehicleRole _x)) && gunner vehicle _x != _x && commander vehicle _x != _x;
	};
    if (count _not_gunners > 0) then {
        _medics_lst = _not_gunners;
    } else {
        _medics_lst = _medics;
    };
};

private _medics_sorted = _medics_lst apply {[_x distance2D _wnded, _x]};
_medics_sorted sort true;

(_medics_sorted select 0 select 1);
