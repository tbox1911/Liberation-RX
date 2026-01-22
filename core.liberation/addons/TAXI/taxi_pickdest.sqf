params ["_vehicle"];
//add limit ?
if (time < GRLIB_taxi_cooldown) exitWith { hintSilent "Please wait..." };

createDialog "liberation_halo";
waitUntil { dialog };
dojump = 0;
halo_position = getPosATL player;

"spawn_marker" setMarkerTextLocal (localize "STR_TAXI_SELECT");
ctrlSetText [201, toUpper (localize "STR_TAXI_SELECT")];
ctrlSetText [202, (localize "STR_TAXI_SELECT")];

onMapSingleClick {
	halo_position = _pos;
	true;
};

while { dialog && alive player && dojump == 0 } do {
	private _freepos = halo_position findEmptyPosition [0,30, "B_Heli_Transport_01_F"];
 	if (surfaceIsWater halo_position || count _freepos == 0) then {
		hintSilent localize "STR_TAXI_WRONG_PLACE";
	} else {
		"spawn_marker" setMarkerPosLocal halo_position;
	};
	sleep 0.2;
};

onMapSingleClick "";
closeDialog 0;
"spawn_marker" setMarkerPosLocal markers_reset;
"spawn_marker" setMarkerTextLocal "";

if (dojump > 0) then {
	if (player distance2D halo_position < 300) exitWith { hintSilent "Wrong place.\ntoo close from player!" };
	[_vehicle, halo_position] spawn taxi_check_dest;
};
