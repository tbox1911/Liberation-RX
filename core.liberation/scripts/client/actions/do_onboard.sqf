params [["_pos", getPosATL player]];
if (GRLIB_player_near_lhd) then {
	call respawn_lhd;
} else {
	private _near_sign = nearestObjects [ATLtoASL ([_pos] call F_getNearestFob), [FOB_sign], 20] select 0;
	private _destpos = (getPosATL _near_sign) vectorAdd [0, 0, 1];
	private _destdir = getDir _near_sign;
	private _unit_list_redep = [(units player), { !(isPlayer _x) && (isNull objectParent _x) && (_x distance2D player < 30) && lifestate _x != 'INCAPACITATED' }] call BIS_fnc_conditionalSelect;

	player setDir _destdir;
	player setPosATL ([_destpos, 8, (_destdir-180)] call BIS_fnc_relPos);
	sleep 1;
	{
		_x setPosATL ([_destpos, 8, random 360] call BIS_fnc_relPos);
		sleep 0.5;
	} forEach _unit_list_redep;
};
