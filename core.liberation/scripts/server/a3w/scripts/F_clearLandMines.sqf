if (!isServer) exitWith {};
params ["_pos"];

{
	if ( (getPosATL _x) distance2D _pos < GRLIB_sector_size) then { deleteVehicle _x };
} foreach allMines;
