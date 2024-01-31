
waitUntil {sleep 1; !isNil "nametags_distance" };

while { true } do {
	GRLIB_nametag_units = (units GRLIB_side_friendly) select {(alive _x) && (_x != player) && (vehicle _x != vehicle player) && (_x distance2D player < nametags_distance)};
	GRLIB_overlay_groups = (groups GRLIB_side_friendly) select {(isPlayer (leader _x)) && (count units _x > 1)};
	sleep 3;
};
