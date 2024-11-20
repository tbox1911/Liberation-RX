waitUntil {sleep 1; GRLIB_player_spawned};

while { true } do {
 	waitUntil { sleep 1; alive player && !(player getVariable ["PAR_wounded", false]) };

	// Renegade
	if (side player != GRLIB_side_friendly) then {
		sleep 10;
		if (side player == GRLIB_side_friendly) exitWith {};
		player setcaptive true;
		player addrating 3000;
		[player] joinSilent GRLIB_player_group;
		GRLIB_player_group selectLeader player;
		player setcaptive false;
		gamelogic globalChat format ["--- LRX info: Player %1 wrong side - (%2)", name player, side player];
	};

	// Leadership
	if (count units GRLIB_player_group > 1 && leader GRLIB_player_group != player && local GRLIB_player_group) then {
		player addrating 3000;
		GRLIB_player_group selectLeader player;
		gamelogic globalChat format ["-- LRX info: Player %1 (re)take Leadership.", name player];		
	};
	sleep 5;
};
