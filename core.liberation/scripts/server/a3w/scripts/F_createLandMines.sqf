if (!isServer) exitWith {};
params ["_pos", "_nb"];

while { _nb >= 1} do {
	_mine = createMine ["ATMine", _pos, [], GRLIB_sector_size / 2];
	GRLIB_side_enemy revealMine _mine;
	_nb =_nb - 1;
};