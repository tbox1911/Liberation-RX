params ["_vehicle"];
private _ret = false;
private _distveh = 15;

private _vehpos = getPosATL _vehicle;
private _nearservice = GRLIB_Marker_SRV select {( _vehpos distance2D _x) <= _distveh};
if (count _nearservice > 0) then {_ret = true};

_nearfob = [] call F_getNearestFob;
_fobdistance = round (_vehpos distance2D _nearfob);
if (_fobdistance <= GRLIB_fob_range ) then {_ret = true};

_ret;