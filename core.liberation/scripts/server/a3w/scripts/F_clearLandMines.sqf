params ["_pos", ["_radius", 150]];

{
	if (_x distance2D _pos < _radius && isNull attachedTo _x) then { deleteVehicle _x };
} foreach allMines;
