params ["_pos"];
if (GRLIB_player_near_lhd) then {
	player setPosATL ((getPosATL lhd) vectorAdd [floor(random 5), floor(random 5), 1]);
} else {
	private _near_sign = nearestObjects [(ATLtoASL _pos), [FOB_sign], 20] select 0;
	if (isNil "_near_sign") exitWith {};
	private _destpos = (getPosASL _near_sign) vectorAdd [0, 0, 0.5];
	private _destdir = getDir _near_sign;
	private _unit_list_redep = [(units player), { !(isPlayer _x) && (isNull objectParent _x) && (_x distance2D player < 40) && lifestate _x != 'INCAPACITATED' }] call BIS_fnc_conditionalSelect;
	player setDir _destdir;
	player setPosASL (_destpos getPos [7, (_destdir-180)]);
	sleep 1;
	{
		_x setPosASL (_destpos getPos [5, random 360]);
		sleep 0.5;
	} forEach _unit_list_redep;
};
