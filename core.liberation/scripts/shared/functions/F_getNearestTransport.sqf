params ["_pos", "_class", "_dist"];

private _transport_class = transport_vehicles;
if (_class in box_transport_big_loadable) then {
	_transport_class = transport_big_vehicles;
};

private _transport_vehicles = GRLIB_transport_vehicles select {
	alive _x && speed vehicle _x < 5 && ((getPosATL _x) select 2) < 5 && (_pos distance2D _x <= _dist) && (typeOf _x in _transport_class)
};

if (count _transport_vehicles == 0) exitWith { objNull };

if (count _transport_vehicles > 1) then {
	_transport_vehicles = [_transport_vehicles, [_pos], {_x distance2D _input0}, 'ASCEND'] call BIS_fnc_sortBy;
};

(_transport_vehicles select 0);
