params ["_vehicle"];
private _ret = false;
private _distveh = 15;

private _nearservice = allMapMarkers select {_x select [0,10] == "marked_car" && (getPosATL _vehicle) distance2D (getMarkerPos _x) <= _distveh};
if (count _nearservice > 0) exitWith { true };

private _nearfob = allMapMarkers select {_x select [0,9] == "fobmarker" && (getPosATL _vehicle) distance2D (getMarkerPos _x) <= GRLIB_fob_range};
if (count _nearfob > 0) exitWith { true };

_ret;