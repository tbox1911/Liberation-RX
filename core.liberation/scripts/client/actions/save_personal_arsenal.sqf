// Save content from Arsenal box to the user profile

private _pos = GRLIB_personal_box getVariable ["GRLIB_personal_box_pos", (markerPos GRLIB_respawn_marker)];
if (GRLIB_personal_box distance2D _pos > 20) then {
	GRLIB_personal_box setPos _pos;
};

GRLIB_personal_arsenal = [GRLIB_personal_box, true] call F_getCargo;
player setVariable [format ["GRLIB_personal_arsenal_%1", PAR_Grp_ID], GRLIB_personal_arsenal, true];
