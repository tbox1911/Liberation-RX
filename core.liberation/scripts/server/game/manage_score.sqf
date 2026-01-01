private [ "_cur", "_last", "_msg", "_msg2", "_rank", "_new_rank", "_uid", "_firework", "_rounds" ];

waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1; !isNil "GRLIB_player_scores"};

CHG_Perm = {
	params ["_uid", "_perms"];
	{
		if ( _x select 0 == _uid ) exitWith { _x set [1,_perms] };
	} foreach GRLIB_permissions;
	publicVariable "GRLIB_permissions";
};

waitUntil {sleep 1; count (AllPlayers - (entities "HeadlessClient_F")) > 0 };

while {true} do {
	{
		_rank = _x getVariable ["GRLIB_Rank", ""];
		if (isPlayer _x && _rank != "") then {
			_cur = [_x] call F_getScore;
			if (_cur >= (GRLIB_perm_hidden/2)) then { _cur = (GRLIB_perm_max*3) };
			_last = _x getVariable["GREUH_score_last", _cur];
			if (_cur != _last) then {
				// score has changed for player _x
				_uid = getPlayerUID _x;
				_new_rank = ([_cur] call F_getRank) select 0;

				if (_cur <= GRLIB_perm_ban || !([] call F_getValid)) exitWith {
					BTC_logic setVariable [_uid, 99, true];
					[_x] remoteExec ["LRX_tk_actions", owner _x];
					diag_log format ["--- LRX TK: BAN for player %1 - UID: %2", name _x,  _uid];
				};

				if (_new_rank == "None" && _cur < _last) exitWith {
					_msg = format ["Warning: player <t color='#00ff00'>%1</t>,<br />You play Wrong !! <t color='#ff0000'>Read the Manual</t>.<br /><br />%2", name _x, localize "STR_RANK_LVL0"];
					[_msg, 0, 0, 5, 0, 0, 90] remoteExec ["BIS_fnc_dynamicText", owner _x];
					[_uid, [false,false,false,false,false,false]] call CHG_Perm;
					_x setVariable ["GRLIB_Rank", _new_rank, true];
				};

				if (_cur >= 0 && _new_rank != _rank) then {
					// new rank for player _x
					_firework = true;
					_rounds = 1;
					switch (_new_rank) do {
						case "Private" : {
							_msg2 = localize "STR_RANK_LVL1";
							[_uid, [true,false,false,true,false,true]] call CHG_Perm;
							_rounds = 1;
						};
						case "Corporal" : {
							_msg2 = localize "STR_RANK_LVL2";
							[_uid, [true,true,false,true,false,true]] call CHG_Perm;
							_rounds = 2;
						};
						case "Sergeant" : {
							_msg2 = localize "STR_RANK_LVL3";
							[_uid, [true,true,true,true,false,true]] call CHG_Perm;
							_rounds = 3;
						};
						case "Captain" : {
							_msg2 = localize "STR_RANK_LVL4";
							[_uid, [true,true,true,true,true,true]] call CHG_Perm;
							_rounds = 4;
						};
						case "Major" : {
							_msg2 = localize "STR_RANK_LVL5";
							[_uid, [true,true,true,true,true,true]] call CHG_Perm;
							_rounds = 5;
						};
						case "Colonel" : {
							_msg2 = localize "STR_RANK_LVL6";
							[_uid, [true,true,true,true,true,true]] call CHG_Perm;
							_rounds = 8;
						};
						case "Super Colonel" : {
							_msg2 = localize "STR_RANK_LVL7";
							[_uid, [true,true,true,true,true,true]] call CHG_Perm;
							_firework = false;
						};
					};

					if (_x getVariable ["GRLIB_player_last_notif", 0] < time) then {
						_msg = format ["Congratulation <t color='#00ff00'>%1</t> !!<br />You have been promoted to : <t color='#ff0000'>%2</t>.<br /><br />%3", name _x, _new_rank, _msg2];
						[_msg, 0, 0, 5, 0, 0, 90] remoteExec ["BIS_fnc_dynamicText", owner _x];
						["FD_Finish_F"] remoteExec ["playSoundNow", owner _x];
					} else {
						_msg = format ["You have been promoted to %1.", _new_rank];
						[gamelogic, _msg] remoteExec ["globalChat", owner _x];
						_firework = false;
					};
					_x setVariable ["GRLIB_player_last_notif", round (time + 5*60)];
					// if rank colonel global greet
					if (_new_rank == "Colonel") then {
						["FD_Finish_F"] remoteExec ["playSoundNow", 0];
						_text = "Good news soldiers...";
						[gamelogic, _text] remoteExec ["globalChat", 0];
						_text = "We have a new Colonel !!";
						[gamelogic, _text] remoteExec ["globalChat", 0];
						_text = format ["Congratulation to %1 for his fight !!", name _x];
						[gamelogic, _text] remoteExec ["globalChat", 0];
						_text = "Over.";
						[gamelogic, _text] remoteExec ["globalChat", 0];
					};

					// set player rank
					[_cur] remoteExec ["set_rank", owner _x];
					_x setVariable ["GRLIB_Rank", _new_rank, true];

					// fireworks !!
					if (_firework) then {
						[getPosATL _x, _rounds] remoteExec ["remote_call_fireworks", 0];
					};
				};
			};
			_x setVariable ["GREUH_score_last", _cur];
		};
	} forEach (AllPlayers - (entities "HeadlessClient_F"));
	sleep 3;
};