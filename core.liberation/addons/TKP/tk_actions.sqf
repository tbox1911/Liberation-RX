params ["_killer", "_unit"];
if (isDedicated) exitWith {};
if (player != _killer) exitWith {};
if (LRX_tk_ban_player) exitWith {};

if (!isNil "_unit") exitWith {
	disableUserInput true;
	private _msg = format [localize "STR_TK_INFO2", name _unit];
	[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
	sleep 3;
	disableUserInput false;
	disableUserInput true;
	disableUserInput false;
};

private _kill = BTC_logic getVariable [PAR_Grp_ID, 0];
if (_kill < GRLIB_tk_count - 1) then {
	waitUntil {!(isNull (findDisplay 46))};
	private _msg = format ["STOP TEAMKILLING !!<br/><br/>%1 Warning left..", (GRLIB_tk_count - _kill)];
	[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
};

if (_kill == GRLIB_tk_count - 1) then {
	waitUntil {!(isNull (findDisplay 46))};
	private _msg = format ["STOP TEAMKILLING, <t color='#ff0000'>LAST WARNING...</t>"];
	[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
};

if (_kill >= GRLIB_tk_count) exitWith {
	LRX_tk_ban_player = true;
	disableUserInput true;
	closeDialog 0;
	closeDialog 0;
	closeDialog 0;
	GRLIB_introduction = false;
	cinematic_camera_started = false;
	titleText ["","BLACK FADED", 100];
	waitUntil {!(isNull (findDisplay 46))};
	player enableSimulationGlobal false;
	createDialog "deathscreen";
	waitUntil { dialog };
	player setpos [0,0,0];
	private _noesckey = (findDisplay 5651) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
	private _text = ["YOU","HAVE","BEEN","BANNED!","","YOU","ARE","NOT","WELCOME","ANYMORE...",""];
	{
		if (_x != "") then { ctrlSetText [4867, _x] };
		sleep 1;
	} forEach _text;
	ctrlSetText [4867, ""];
	sleep 3;
	disableUserInput false;
	disableUserInput true;
	disableUserInput false;
	(findDisplay 5651) displayRemoveEventHandler ["KeyDown", _noesckey];
	endMission "LOSER";
	sleep 300;
};

[_killer, -5] remoteExec ["F_addScore", 2];
_killer setDamage 0.7;