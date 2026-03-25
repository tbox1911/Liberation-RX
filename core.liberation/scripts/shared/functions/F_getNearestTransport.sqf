params ["_pos", "_class", "_dist"];

private _transport_vehicles = GRLIB_transport_vehicles select { alive _x && speed vehicle _x < 5 && ((getPosATL _x) select 2) < 5 && (_pos distance2D _x <= _dist) };

if (count _transport_vehicles == 0) exitWith { objNull };

if (count _transport_vehicles > 1) then {
	_transport_vehicles = [_transport_vehicles, [_pos], {_x distance2D _input0}, 'ASCEND'] call BIS_fnc_sortBy;
};

private _transport = (_transport_vehicles select 0);
if (_class in box_transport_big_loadable && !(typeOf _transport in transport_big_vehicles)) exitWith { objNull };

_transport;
