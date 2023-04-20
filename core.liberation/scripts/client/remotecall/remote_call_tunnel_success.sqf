params [ "_position", "_bonus" ];

if (isDedicated || (!hasInterface && !isServer)) exitWith {};

private _msg = format ["You Win !<br/>The <t color='#008f00'>Guerrilla</t> tunnel no <t color='#008f00'>%1</t>,<br/><br/>
Has been successfully <t color='#00008f'>CLEANED</t> !!<br/>
Please take you reward: <t color='#8f0000'>%2 XP</t>.<br/><br/>Thanks for your help.", _position, _bonus];
[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;

playSound "taskSucceeded";
