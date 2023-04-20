// Public Hurron
private _respawn_huron_unsorted = [entities [[huron_typename], [], false, true], {
	_x getVariable ["GRLIB_vehicle_ishuron", false] &&
	_x distance2D lhd > GRLIB_sector_size &&
	!surfaceIsWater (getpos _x) &&
	((getpos _x) select 2) < 5 &&  speed _x < 5		
}] call BIS_fnc_conditionalSelect;

// Truck / Tent
private _player_respawn_unsorted = [];
private _allplayer_respawn_unsorted = [];
{
	_player_respawn_unsorted = ([getPlayerUID _x] call F_getMobileRespawnsPlayer) select 0;
	_allplayer_respawn_unsorted append _player_respawn_unsorted;
} forEach allPlayers;

private _respawn_trucks_sorted = [ _respawn_huron_unsorted + _allplayer_respawn_unsorted , [] , { (getpos _x) select 0 } , 'ASCEND' ] call BIS_fnc_sortBy;

_respawn_trucks_sorted;
