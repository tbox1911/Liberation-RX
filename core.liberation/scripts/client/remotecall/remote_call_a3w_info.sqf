params [ "_type", "_source" ];

if (isDedicated || (!hasInterface && !isServer)) exitWith {};

if (player distance2D (getPosATL _source) <= 20) then {
	playSound "taskSucceeded";
	gamelogic globalChat format [localize "STR_REMOTE_A3W_DELI1", name player];

	private _bonus = round (10 + random 10);
	gamelogic globalChat format [localize "STR_REMOTE_A3W_DELI2", _bonus];
	[player, _bonus] remoteExec ["F_addScore", 2];
};
