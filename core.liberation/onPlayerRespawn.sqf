// Welcome trigger
GRLIB_player_spawned = false;
waituntil {sleep 0.5; !isNil "GRLIB_revive"};
if (GRLIB_revive == 0) then {[player] call player_EVH}; 	// if FAR is disabled, minimal handler

player addAction ["<t color='#FF8000'>-- Extended Options --</t>","GREUH\scripts\GREUH_dialog.sqf","",-999,false,true];
[] execVM "scripts\client\misc\welcome.sqf";
