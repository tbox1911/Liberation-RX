// Weapon to the back

if (player getVariable ["GRLIB_action_inuse", false])  exitWith {};

if (currentWeapon player != "") then {
	player setVariable ["GRLIB_action_inuse", true];
	player action ['SWITCHWEAPON',player,player,-1];
	uIsleep 3;
	player setVariable ["GRLIB_action_inuse", false];
};
