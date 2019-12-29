private [ "_respawn_trucks_unsorted", "_respawn_trucks_sorted", "_respawn_tents_unsorted" ];


_respawn_trucks_unsorted = [ vehicles, { ( typeof _x == Respawn_truck_typename || typeof _x == huron_typename ) && _x distance lhd > 250 &&
										!surfaceIsWater (getpos _x) && ((getpos _x) select 2) < 5 && alive _x && speed _x < 5 }
										] call BIS_fnc_conditionalSelect;

_respawn_tents_unsorted = [ allMissionObjects "Land_TentDome_F", {  alive _x &&
										_x distance lhd > 250 &&
										!surfaceIsWater (getpos _x) &&
										isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull])
										}] call BIS_fnc_conditionalSelect;

_respawn_trucks_sorted = [ _respawn_trucks_unsorted + _respawn_tents_unsorted , [] , { (getpos _x) select 0 } , 'ASCEND' ] call BIS_fnc_sortBy;

_respawn_trucks_sorted
