if ( isDedicated ) exitWith {};

params [ "_type", "_source" ];

if (player distance2D (getPos _source) <= 20) then {
	playSound "taskSucceeded";
	gamelogic globalChat (format ["Thank you %1, The whole village is grateful for your help!, good luck.", name player]);
};

diag_log format [ "DBG: %1 %2",  _type, _source ];