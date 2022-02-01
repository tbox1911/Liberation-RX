if ( isDedicated ) exitWith {};
params [ "_position" ];

private _bonus = 100;
private _msg = format ["You Win !<br/>The <t color='#008f00'>Guerrilla</t> tunnel no <t color='#008f00'>%1</t>,<br/><br/>
Has been successfully <t color='#00008f'>CLEANED</t> !!<br/>
Please take you reward: %2 XP.<br/><br/>Thanks for your help.", _position, _bonus];
[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;

[player, _bonus] remoteExec ["addScore", 2];
playSound "taskSucceeded";
