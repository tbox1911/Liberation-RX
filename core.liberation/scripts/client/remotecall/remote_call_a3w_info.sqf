if ( isDedicated ) exitWith {};

params [ "_type", "_source" ];

if (player distance2D (getPosATL _source) <= 20) then {
	playSound "taskSucceeded";
	gamelogic globalChat format [localize "STR_REMOTE_A3W", name player];

	private _bonus = 15;
	hintSilent format ["%1\nBonus Score + %2 Pts!", name player, _bonus];
	[player, _bonus] remoteExec ["F_addScore", 2];
};
