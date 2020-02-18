// Welcome trigger
GRLIB_player_spawned = false;
waituntil {sleep 0.5; !isNil "GRLIB_revive"};
if (GRLIB_revive == 0) then {[player] call player_EVH}; 	// if FAR is disabled, minimal handler

player addAction ["<t color='#FF8000'>-- Extended Options --</t>","GREUH\scripts\GREUH_dialog.sqf","",-997,false,true];
player addAction ["<t color='#FF8000'>-- CHEAT MENU --</t>","scripts\client\commander\cheat_menu.sqf","",-998,false,true,"","([] call F_isAdmin) && GRLIB_cheat_menu"];
[] execVM "scripts\client\misc\welcome.sqf";
