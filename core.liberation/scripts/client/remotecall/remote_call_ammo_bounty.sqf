if (isDedicated || (!hasInterface && !isServer)) exitWith {};
if (isNil "GRLIB_player_spawned") exitWith {};
if (!GRLIB_player_spawned) exitWith {};

params [ "_classname", "_bounty", "_killer" ];

gamelogic globalChat format [localize "STR_BOUNTY_MESSAGE"+".  Bonus Score %4pts !", 
    (_bounty select 0), ([_classname] call F_getLRXName),
    ([_killer] call get_player_name), (_bounty select 1)];
