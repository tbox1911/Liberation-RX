if (!isServer) exitWith {};
params ["_pos"];

{
	if ( (getPos _x) distance2D _pos < GRLIB_sector_size) then { deleteVehicle _x };
} foreach allMines;
