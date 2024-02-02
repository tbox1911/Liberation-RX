if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_bonus"];

playSound "taskSucceeded";
gamelogic globalChat format [localize "STR_REMOTE_A3W_DELI1", name player];
gamelogic globalChat format [localize "STR_REMOTE_A3W_DELI2", _bonus];
