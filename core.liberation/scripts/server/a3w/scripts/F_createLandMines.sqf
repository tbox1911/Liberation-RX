params ["_pos", "_nbMines", ["_radius", 150]];

[_pos] call clearlandmines;
sleep 2;

private _minesTypes =  ["ATMine", "APERSMine", "APERSBoundingMine", "SLAMDirectionalMine", "APERSTripMine"];
for "_i" from 1 to _nbMines do {
	if (random 100 < GRLIB_MineProbability) then {
		private _mine = createMine [(selectRandom _minesTypes), _pos, [], _radius];
		GRLIB_side_enemy revealMine _mine;
		GRLIB_side_civilian revealMine _mine;
	};
	sleep 0.1;
};