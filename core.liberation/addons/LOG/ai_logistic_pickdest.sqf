params ["_vehicle"];

createDialog "liberation_halo";
waitUntil { dialog };
dojump = 0;
halo_position = getPosATL player;

"spawn_marker" setMarkerTextLocal (localize "STR_LOGISTIC_SELECT");
ctrlSetText [201, toUpper (localize "STR_LOGISTIC_SELECT")];
ctrlSetText [202, (localize "STR_LOGISTIC_SELECT")];

onMapSingleClick {
	halo_position = _pos;
	true;
};

while { dialog && alive player && dojump == 0 } do {
 	if (surfaceIsWater halo_position) then {
		hintSilent localize "STR_LOGISTIC_WRONG_PLACE";
	} else {
		"spawn_marker" setMarkerPosLocal halo_position;
	};
	sleep 0.2;
};

onMapSingleClick "";
closeDialog 0;
"spawn_marker" setMarkerPosLocal markers_reset;
"spawn_marker" setMarkerTextLocal "";
