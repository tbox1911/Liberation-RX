private [ "_respawn_trucks_unsorted", "_respawn_trucks_sorted", "_respawn_tent_unsorted"];

_respawn_trucks_unsorted = [ vehicles, {
	alive _x && _x distance2D lhd > GRLIB_sector_size &&
	!surfaceIsWater (getpos _x) &&
	(typeof _x in [Respawn_truck_typename, huron_typename]) &&
	((getpos _x) select 2) < 5 &&  speed _x < 5
}] call BIS_fnc_conditionalSelect;

private _respawn_tent_unsorted = [];
if (!isNil "GRLIB_mobile_respawn") then {
	_respawn_tent_unsorted = [ GRLIB_mobile_respawn, {
		alive _x && _x distance2D lhd > GRLIB_sector_size &&
		!surfaceIsWater (getpos _x) &&
		_x distance2D ([_x] call F_getNearestFob) > GRLIB_sector_size &&
		isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull])
	}] call BIS_fnc_conditionalSelect;
};
_respawn_trucks_sorted = [ _respawn_trucks_unsorted + _respawn_tent_unsorted , [] , { (getpos _x) select 0 } , 'ASCEND' ] call BIS_fnc_sortBy;

_respawn_trucks_sorted
