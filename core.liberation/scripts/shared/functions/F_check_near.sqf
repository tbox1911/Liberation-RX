params ["_vehicle", "_list", "_dist", "_includeFOB"];

//private _dist,_includeFOB;
private _ret = false;
private _classlist = [];

if (isNil "_list") exitWith {_ret};
if (isNil "_dist") then {_dist = 15};
if (isNil "_includeFOB") then {_includeFOB = true};

switch ( _list ) do {
	case "SRV" : { _classlist = GRLIB_Marker_SRV};
	case "ATM" : { _classlist = GRLIB_Marker_ATM};
	case "FUEL" : { _classlist = GRLIB_Marker_FUEL};
};

private _vehpos = getPosATL _vehicle;
private _near = _classlist select {( _vehpos distance2D _x) <= _dist};
if (count _near > 0) then {_ret = true};

if (_includeFOB) then {
	_nearfob = [] call F_getNearestFob;
	_fobdistance = round (_vehpos distance2D _nearfob);
	if (_fobdistance <= (_dist * 2) ) then {_ret = true};
};

_ret;