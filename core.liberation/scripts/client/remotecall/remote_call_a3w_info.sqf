if ( isDedicated ) exitWith {};

params [ "_type", "_source" ];

if (player distance2D (getPosATL _source) <= 20) then {
	playSound "taskSucceeded";
	gamelogic globalChat format [localize "STR_REMOTE_A3W", name player];

	private _bonus = round (10 + random 10);
	gamelogic globalChat format ["Mission Completed Bonus +%1 Pts!", _bonus];
	[player, _bonus] remoteExec ["F_addScore", 2];
};
