//original by : =BTC= Giallustio
//heavily modified by pSiKO

//Def
BTC_tk_deathscreen_punishment = 2;
BTC_tk_last_warning = 3;

BTC_fnc_tk_PVEH = {
	_array = _this select 1;
	_name  = _array select 0;
	if (name player == _name) then {
		[player, -10] remoteExec ["addScore", 2];
		_uid = getPlayerUID player;
		BTC_teamkiller = BTC_teamkiller + 1;
		BTC_logic setVariable [_uid, BTC_teamkiller, true];
		[] spawn BTC_Teamkill;
	};
};

BTC_Teamkill = {
	switch (true) do {
		case (BTC_teamkiller <= BTC_tk_deathscreen_punishment) :
		{
		  private ["_msg"];
		  waitUntil {!(isNull (findDisplay 46))};
		  _msg= "STOP TEAMKILLING !!";
      	  [_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
		};

		case (BTC_teamkiller > BTC_tk_deathscreen_punishment && BTC_teamkiller <= BTC_tk_last_warning) :
		{
			private ["_msg"];
			waitUntil {!(isNull (findDisplay 46))};
      		_msg = format ["STOP TEAMKILLING, <t color='#ff0000'>LAST WARNING...</t>"];
			[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
		};

		case (BTC_teamkiller > BTC_tk_last_warning) :
		{
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
