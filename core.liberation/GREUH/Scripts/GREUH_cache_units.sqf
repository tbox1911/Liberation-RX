
waitUntil {sleep 1; !isNil "nametags_distance" };

while { true } do {
	GRLIB_nametag_units = [units GRLIB_side_friendly, {(alive _x) && (!isPlayer _x) && (isNull objectParent _x) && (_x distance2D player < nametags_distance)}] call BIS_fnc_conditionalSelect;
	GRLIB_overlay_groups = [groups GRLIB_side_friendly, {(isPlayer (leader _x)) && (count units _x > 1)}] call BIS_fnc_conditionalSelect;
	sleep 2;
};
