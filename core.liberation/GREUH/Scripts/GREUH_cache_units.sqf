
waitUntil {sleep 1; !isNil "nametags_distance" };

private _list = [];
while { true } do {
	_list = (getPos player) nearEntities ["CAManBase", nametags_distance];
    GRLIB_nametag_units = _list select {
        (_x != player) &&
		side _x == GRLIB_side_friendly &&
		(vehicle _x != vehicle player)
    };
	GRLIB_overlay_groups = (groups GRLIB_side_friendly) select {(isPlayer (leader _x)) && (count units _x > 1)};
	sleep 3;
};
