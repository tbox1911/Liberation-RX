private [ "_cur", "_last", "_msg", "_msg2", "_rank", "_uid", "_newrank", "_ignore" ];

waitUntil { !isNil "GRLIB_player_scores" };
waitUntil { !isNil "save_is_loaded" };

CHG_Perm = {
 params ["_uid", "_perms"];
 {
  if ( _x select 0 == _uid ) exitWith {
	  _x set [1,_perms];
   };
 } foreach GRLIB_permissions;
 publicVariable "GRLIB_permissions";
};

while { true } do {
	{
		_rank = _x getVariable ["GRLIB_Rank", ""];
		if (isPlayer _x && _rank != "") then {
			_cur = score _x;
			_last = _x getVariable["score_last",0];
			if (_cur != _last) then {
				//Score has changed for player _x
				_newrank = false;

				if (_cur < GRLIB_perm_ban) then {[] remoteExec ["kick_player", owner _x]};
				if ((_cur >= GRLIB_perm_ban) && (_cur < -2) && (_cur < _last)) then {_rank = "None"; _newrank = true};
				if (((_cur >=  0) && (_cur < GRLIB_perm_inf) && (_rank != "Private")) || (_cur >=  0) && (_last < 0)) then {_rank = "Private"; _newrank = true};
				if ((_cur >= GRLIB_perm_inf) && (_cur < GRLIB_perm_log) && (_rank != "Corporal")) then {_rank = "Corporal"; _newrank = true};
				if ((_cur >= GRLIB_perm_log) && (_cur < GRLIB_perm_tank) && (_rank != "Sergeant")) then {_rank = "Sergeant"; _newrank = true};
				if ((_cur >= GRLIB_perm_tank) && (_cur < GRLIB_perm_air) && (_rank != "Captain")) then {_rank = "Captain"; _newrank = true};
				if ((_cur >= GRLIB_perm_air) && (_cur < GRLIB_perm_max) && (_rank != "Major")) then {_rank = "Major"; _newrank = true};
				if ((_cur >= GRLIB_perm_max) && (_rank != "Colonel")) then {_rank = "Colonel"; _newrank = true};

				if (_newrank) then {
					_fw = 0;
					_uid = getPlayerUID _x;
					_msg = format ["Congratulation <t color='#00ff00'>%1</t> !!<br />You have been promoted to : <t color='#ff0000'>%2</t>.<br /><br />",name _x, _rank];

					//change perms
					switch (_rank) do {
						case "None" : {
							_msg2 = localize "STR_RANK_LVL0";
							[_uid, [false,false,false,false,false,false]] call CHG_Perm;
							_msg = format ["Warning <t color='#00ff00'>%1</t> !!<br />You Play Wrong !! <t color='#ff0000'>Read the Manual</t>.<br /><br />",name _x];
						};
						case "Private" : {
							_msg2 = localize "STR_RANK_LVL1";
							[_uid, [true,false,false,true,false,true]] call CHG_Perm;
							_fw = 1;
						};
						case "Corporal" : {
							_msg2 = localize "STR_RANK_LVL2";
							[_uid, [true,true,false,true,false,true]] call CHG_Perm;
							_fw = 2;
						};
						case "Sergeant" : {
							_msg2 = localize "STR_RANK_LVL3";
							[_uid, [true,true,true,true,false,true]] call CHG_Perm;
							_fw = 3;
						};
						case "Captain" : {
							_msg2 = localize "STR_RANK_LVL4";
							[_uid, [true,true,true,true,true,true]] call CHG_Perm;
							_fw = 4;
						};
						case "Major" : {
							_msg2 = localize "STR_RANK_LVL5";
							_fw = 5;
						};
						case "Colonel" : {
							_msg2 = localize "STR_RANK_LVL6";
							_fw = 6;
						};
					};

					_msg = format ["%1%2", _msg, _msg2];
					[_msg, 0, 0, 5, 0, 0, 90] remoteExec ["BIS_fnc_dynamicText", owner _x];
					["FD_Finish_F"] remoteExec ["playSound", owner _x];

					if (_rank != "None") then {
						[_x] remoteExec ["set_rank",  owner _x];
					};

					// if rank colonel global greet
					if (_rank == "Colonel") then {
						["FD_Finish_F"] remoteExec ["playSound", 0];
						_text = "Good news soldiers...";
						[gamelogic, _text] remoteExec ["globalChat", 0];
						_text = "We have a new Colonel !!";
						[gamelogic, _text] remoteExec ["globalChat", 0];
						_text = format ["Congratulation to %1 for his fight !!", name _x];
						[gamelogic, _text] remoteExec ["globalChat", 0];
						_text = "Over.";
						[gamelogic, _text] remoteExec ["globalChat", 0];
					};

					// Fireworks
					if ( (daytime > GRLIB_nights_start || daytime < GRLIB_nights_stop ) && _fw >= 1 ) then {
						for "_i" from 1 to _fw do {
							[getPosATL _x, 'random','random'] spawn GRAD_fireworks_fnc_prepareFireworks;
							sleep 1;
						};
					} else {
						[getPosATL _x, 'normal','random'] spawn GRAD_fireworks_fnc_prepareFireworks;
					};
				};
			};
			_x setVariable ["score_last",_cur];
		};
	} forEach playableUnits;
	sleep 5;
};