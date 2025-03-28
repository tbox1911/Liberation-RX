if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params [ "_position", "_bonus" ];

private _msg = format [localize "STR_UI_TUNNEL_CLEARED_MSG",_position,_bonus];
[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;

playSound "taskSucceeded";
