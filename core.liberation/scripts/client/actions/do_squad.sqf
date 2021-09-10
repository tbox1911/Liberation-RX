private _my_squad_order = (_this select 3);
private _my_squad = player getVariable ["my_squad", nil];

if (!isNil "_my_squad") then {

	if (!isNil "_my_squad_order") then {
		while {(count (waypoints _my_squad)) != 0} do {deleteWaypoint ((waypoints _my_squad) select 0);};
		player setVariable ["my_squad_order", _my_squad_order, true];
		_leader = leader _my_squad;

		//follow player
		if (_my_squad_order == "follow") then {
			_leader setPos (getPos _leader vectorAdd [([] call F_getRND), ([] call F_getRND), 1]);
			player sideChat "Squad Regroup!";
		};

		// moveto
		if (_my_squad_order == "move") then {

			_wPos = screenToWorld [0.5,0.5];
			_my_squad addWaypoint [_wPos, 0];
			player sideChat "Squad Move!";

			_pingId =  addMissionEventHandler ["Draw3D", {
				_my_squad = player getVariable ["my_squad", nil];
				_wPos = getWPPos [_my_squad, 0];
				_icon = (getText (configfile >> "CfgInGameUI" >> "TacticalPing" >> "texture"));
				drawIcon3D [_icon, [1,1,1,1], _wPos, 2, 2, 0];
			}];
			playSound "TacticalPing2";
			sleep 5;
			removeMissionEventHandler ["Draw3D", _pingId];
		};

		// stop
		if (_my_squad_order == "stop") then {
			_my_squad addWaypoint [getPos _leader, 0];
			player sideChat "Squad Stop!";
		};

		if (_my_squad_order == "del") then {
			_msg = format [localize "STR_DO_SQUAD"];
			_result = [_msg, localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
			if (_result) then {
				{deleteVehicle _x} forEach units _my_squad;
			};
		};
	};

};
