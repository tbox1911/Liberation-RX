private _cmd = _this select 3;
private _my_squad = player getVariable ["my_squad", nil];

// Squad go to pos
private _squad_move = {
	params ["_my_squad", "_pos"];
	private _leader = leader _my_squad;
	{
		private _unit = _x;
		_unit setUnitPos "UP";
		_unit setSpeedMode "FULL";
		_unit setPosATL ([getPosATL _leader, 10] call F_getRandomPos);
		sleep 0.2;
		_unit switchMove "AmovPercMwlkSrasWrflDf";
		_unit playMoveNow "AmovPercMwlkSrasWrflDf";
	} forEach (units _my_squad);
	_leader doMove _pos;
	{_x doFollow _leader} foreach units _my_squad;
};

if (!isNil "_my_squad") then {

	if (!isNil "_cmd") then {
		player setVariable ["my_squad_order", _cmd, true];

		//follow player
		if (_cmd == "follow") then {
			player sideChat "Squad Regroup!";
			[_my_squad] call F_deleteWaypoints;
			private _wPos = getPos player;
			private _waypoint = _my_squad addWaypoint [_wPos, 0];
			_waypoint setWaypointCompletionRadius 10;
			_waypoint setWaypointStatements ["true", "deleteWaypoint [group this, currentWaypoint group this]"];
			[_my_squad, _wPos] call _squad_move;
		};

		// moveto
		if (_cmd == "move") then {
			player sideChat "Squad Move!";
			[_my_squad] call F_deleteWaypoints;
			private _wPos = screenToWorld [0.5,0.5];
			private _waypoint = _my_squad addWaypoint [_wPos, 0];
			_waypoint setWaypointCompletionRadius 10;
			private _pingId = addMissionEventHandler ["Draw3D", {
				_my_squad = player getVariable ["my_squad", nil];
				_wPos = getWPPos [_my_squad, 0];
				_icon = (getText (configfile >> "CfgInGameUI" >> "TacticalPing" >> "texture"));
				drawIcon3D [_icon, [1,1,1,1], _wPos, 2, 2, 0];
			}];
			playSound "TacticalPing2";
			[_my_squad, _wPos] call _squad_move;
			sleep 5;
			removeMissionEventHandler ["Draw3D", _pingId];
		};

		// stop
		if (_cmd == "stop") then {
			player sideChat "Squad Stop!";
			[_my_squad] call F_deleteWaypoints;
			doStop (units _my_squad);
		};

		if (_cmd == "del") then {
			private _msg = format [localize "STR_DO_SQUAD"];
			private _result = [_msg, localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
			if (_result) then {
				{deleteVehicle _x} forEach (units _my_squad);
				[false] call player_squad_actions;
			};
		};
	};

};
