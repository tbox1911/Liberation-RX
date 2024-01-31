params ["_bonus"];

if (isDedicated || (!hasInterface && !isServer)) exitWith {};

playSound "taskSucceeded";
gamelogic globalChat format [localize "STR_REMOTE_A3W_DELI1", name player];
gamelogic globalChat format [localize "STR_REMOTE_A3W_DELI2", _bonus];
