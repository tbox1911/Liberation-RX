params ["_vehicle_class"];

private _maxload = 0;
{
	if ((_x select 0) == _vehicle_class) exitWith { _maxload = (count _x) - 2 };
} foreach (box_transport_config + box_transport_big_config);

_maxload;
