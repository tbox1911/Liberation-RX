// Weapon to the back

if (player getVariable ["GRLIB_action_inuse", false])  exitWith {};

if (currentWeapon player != "") then {
	player setVariable ["GRLIB_action_inuse", true, true];
	player action ['SWITCHWEAPON', player, player, -1];
	sleep 3;
	player setVariable ["GRLIB_action_inuse", false, true];
};
