if (isNil "GRLIB_personal_box") exitWith {};
GRLIB_personal_box setPos (getPos player);
player action ["GEAR", GRLIB_personal_box];
