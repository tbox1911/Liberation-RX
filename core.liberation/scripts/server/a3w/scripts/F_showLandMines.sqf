if (!isServer) exitWith {};
params ["_pos"];

{
	if ( (getPos _x) distance2D _pos < GRLIB_sector_size) then { GRLIB_side_friendly revealMine _x };
} foreach allMines;
