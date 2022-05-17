unitcap = 0;

while { true } do {
	unitcap = { alive _x && (_x distance2D lhd) >= 500 } count units GRLIB_side_friendly;
	sleep 2;
};
