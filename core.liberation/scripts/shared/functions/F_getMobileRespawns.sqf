// Public Hurron
private _respawn_huron_unsorted = [];
if (
	(alive GRLIB_vehicle_huron) &&
 	!surfaceIsWater (getPos GRLIB_vehicle_huron) &&
	((getPos GRLIB_vehicle_huron) select 2) < 5 &&
	speed vehicle GRLIB_vehicle_huron < 5 &&	
	!([GRLIB_vehicle_huron, "LHD", GRLIB_sector_size] call F_check_near)
   ) then { _respawn_huron_unsorted pushBack GRLIB_vehicle_huron };

// Truck / Tent
private _player_respawn_unsorted = [];
private _allplayer_respawn_unsorted = [];
if (GRLIB_allow_redeploy == 1) then {
	{
		_player_respawn_unsorted = ([getPlayerUID _x] call F_getMobileRespawnsPlayer) select 0;
		_allplayer_respawn_unsorted append _player_respawn_unsorted;
	} forEach (AllPlayers - (entities "HeadlessClient_F"));
};

private _respawn_trucks_sorted = [_respawn_huron_unsorted + _allplayer_respawn_unsorted, [], {(getpos _x) select 0}, 'ASCEND'] call BIS_fnc_sortBy;

_respawn_trucks_sorted;
