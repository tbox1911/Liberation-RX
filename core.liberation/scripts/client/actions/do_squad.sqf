private _my_squad_order = (_this select 3);
private _my_squad = player getVariable ["my_squad", nil];

if (!isNil "_my_squad") then {

	if (!isNil "_my_squad_order") then {
		player setVariable ["my_squad_order", _my_squad_order, true];
		_leader = leader _my_squad;

		//follow player
		if (_my_squad_order == "follow") then {
			player setVariable ["my_squad_dest", nil, true];
			player sideChat "Squad Regroup!";
		};

		// moveto
		if (_my_squad_order == "move") then {

			_wPos = screenToWorld [0.5,0.5];
			player setVariable ["my_squad_dest", _wPos, true];
			player sideChat "Squad Move!";

			_pingId =  addMissionEventHandler ["Draw3D", {
				_wPos = player getVariable ["my_squad_dest", player];
				_icon = (getText (configfile >> "CfgInGameUI" >> "TacticalPing" >> "texture"));
				drawIcon3D [_icon, [1,1,1,1], _wPos, 2, 2, 0];
			}];
			playSound "TacticalPing2";
			sleep 5;
			removeMissionEventHandler ["Draw3D", _pingId];
		};

		// stop
		if (_my_squad_order == "stop") then {
			player setVariable ["my_squad_dest", getPos _leader, true];
			player sideChat "Squad Stop!";
		};

		if (_my_squad_order == "del") then {
			_msg = format ["<t align='center'>Dismiss the Squad<br/>Are you sure ?</t>"];
			_result = [_msg, "Warning !", true, true] call BIS_fnc_guiMessage;
			if (_result) then {
				{deleteVehicle _x} forEach units _my_squad;
			};
		};
	};

};