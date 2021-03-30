/*
	LRX - TeamKilling Protection System

original by : =BTC= Giallustio
heavily modified by pSiKO

	Mode :
		- strict
			GRLIB_tk_count (4) warnings then the killer is ban by server

		- relax
			The player decide to forgive or punish the killer
			at GRLIB_tk_count (4) the killer is ban by server

		- disabled
			No TK managment
*/

LRX_tk_actions = compileFinal preprocessFileLineNumbers "addons\TKP\tk_actions.sqf";
if ((BTC_logic getVariable [getPlayerUID player, 0]) > GRLIB_tk_count) exitWith {[player] spawn LRX_tk_actions};
if (!([] call F_getValid)) exitWith {endMission "LOSER"};
if (GRLIB_tk_mode == 2) exitWith {};

// TK VIP Protect
LRX_tk_vip = [];
LRX_tk_player_action = 0;

LRX_tk_check = {
	params ["_unit", "_killer"];

	if (player == _killer) then {
		if (GRLIB_tk_mode == 0) then {
			_kill = BTC_logic getVariable [getPlayerUID _killer, 0];
			BTC_logic setVariable [getPlayerUID player, (_kill + 1), true];
		};
		[player] spawn LRX_tk_actions;
	};

	if (player == _unit && isPlayer _killer) then {
		if (GRLIB_tk_mode == 1 && LRX_tk_player_action <= GRLIB_tk_count) then {
			player addAction [format ["<t color='#FF0080'>%1</t>: %2", localize "STR_TK_ACTION1",name _killer],"addons\TKP\tk_punish.sqf",_killer,999,false,true,"",""];
			hintSilent format [localize "STR_TK_INFO1", name _killer];
			LRX_tk_player_action = LRX_tk_player_action + 1;
		};
	};

};

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- TK Protect Initialized --------";