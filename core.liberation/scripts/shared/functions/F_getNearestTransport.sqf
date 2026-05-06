params ["_unit", "_class", "_dist"];

private _transport_class = transport_vehicles;
if (_class in box_transport_big_loadable) then {
	_transport_class = transport_big_vehicles;
};

private _transport_vehicles = (_unit nearEntities [_transport_class, _dist]) select {
	(_unit distance2D _x <= _dist) &&
	(alive _x && speed vehicle _x < 5 && ((getPosATL _x) select 2) < 5) &&
	(([_unit, _x] call is_owner || [_x] call is_public) && locked _x < 2)
};

if (count _transport_vehicles == 0) exitWith { objNull };

if (count _transport_vehicles > 1) then {
	_transport_vehicles = [_transport_vehicles, [_unit], {_x distance2D _input0}, 'ASCEND'] call BIS_fnc_sortBy;
};

(_transport_vehicles select 0);
