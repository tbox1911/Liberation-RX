unitcap = 0;
opforcap = 0;

while { true } do {
	unitcap = { alive _x && (_x distance2D lhd) >= 200 } count (units GRLIB_side_friendly);
	opforcap = { alive _x } count (units GRLIB_side_enemy);
	sleep 2;
};
