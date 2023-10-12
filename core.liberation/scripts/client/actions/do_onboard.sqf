params [["_pos", getPosATL player]];
if (GRLIB_player_near_lhd) then {
	call respawn_lhd;
} else {
	private _near_sign = nearestObjects [ATLtoASL ([_pos] call F_getNearestFob), [FOB_sign], 20] select 0;
	private _destpos = getPosATL _near_sign;
	private _destdir = getDir _near_sign;
	player setDir _destdir;
	player setPosATL ([_destpos, 8, (_destdir-180)] call BIS_fnc_relPos);
};
