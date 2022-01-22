if ( isDedicated ) exitWith {};

params [ "_type", "_source" ];

if (player distance2D (getPosATL _source) <= 20) then {
	playSound "taskSucceeded";
	gamelogic globalChat format ["Thank you %1, The whole village is grateful for your help!, good luck.", name player];

	private _bonus = 15;
	hintSilent format ["%1\nBonus Score + %2 Pts!", name player, _bonus];
	[player, _bonus] remoteExec ["addScore", 2];
};
