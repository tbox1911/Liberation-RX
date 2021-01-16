//original by : =BTC= Giallustio
//heavily modified by pSiKO

// TK VIP Protect
BTC_vip = [];

BTC_fnc_tk_PVEH = {
	params ["_unit", "_killer"];

	if (player == _killer) then {
		if (GRLIB_tk_mode == 0) then {
			_kill = BTC_logic getVariable [getPlayerUID _killer, 0];
			BTC_logic setVariable [getPlayerUID player, (_kill + 1), true];
			[player, -10] remoteExec ["addScore", 2];
		};

		if (GRLIB_tk_mode == 1) then {

		};		
		
		[] spawn BTC_Teamkill;
	};

	if (player == _unit) then {
		if (GRLIB_tk_mode == 1) then {
			player addAction [format ["<t color='#FF0080'>%1</t>: %2", localize "STR_TK_ACTION1",name _killer],"addons\TKP\tk_punish.sqf",_killer,999,false,true,"",""];
		};
	};	

};

BTC_Teamkill = {
	private _kill = BTC_logic getVariable [getPlayerUID player, 0];

	switch (true) do {
		case (_kill < GRLIB_tk_count) : {
		  private ["_msg"];
		  waitUntil {!(isNull (findDisplay 46))};
		  _msg= "STOP TEAMKILLING !!";
      	  [_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
		};

		case (_kill == GRLIB_tk_count) : {
			private ["_msg"];
			waitUntil {!(isNull (findDisplay 46))};
      		_msg = format ["STOP TEAMKILLING, <t color='#ff0000'>LAST WARNING...</t>"];
			[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
		};

		case (_kill > GRLIB_tk_count) : {
			closeDialog 0;
			closeDialog 0;
			closeDialog 0;
			sleep 1;
			player enableSimulationGlobal false;
			player setpos [0,0,0];
			waitUntil {!(isNull (findDisplay 46))};
			_dialog = createDialog "deathscreen";
			waitUntil { dialog };
			disableUserInput true;
			ctrlSetText [4867, "YOU HAVE BEEN BANNED"];
			sleep 3;
			ctrlSetText [4867, "FOR BAD GAMING..."];
			sleep 3;
			ctrlSetText [4867, "...YOU ARE NOT"];
			sleep 3;
			ctrlSetText [4867, "WELCOME ANYMORE."];
			sleep 3;
			ctrlSetText [4867, ""];
			sleep 3;
			disableUserInput false;
			disableUserInput true;
			disableUserInput false;
			endMission "LOSER";
		};
	};
};

"BTC_tk_PVEH" addPublicVariableEventHandler BTC_fnc_tk_PVEH;

if ((BTC_logic getVariable [getPlayerUID player, 0]) > GRLIB_tk_count) exitWith {[] spawn BTC_Teamkill};

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- TK Protect Initialized --------";