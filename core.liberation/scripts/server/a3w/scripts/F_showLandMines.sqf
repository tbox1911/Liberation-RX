params ["_pos"];

{
	if ( (getPos _x) distance2D _pos < 200) then { GRLIB_side_friendly revealMine _x };
} foreach allMines;
