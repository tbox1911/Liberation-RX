if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {};

private _cargo_seat_free = 0;

while {true} do {
	waitUntil {sleep 1; GRLIB_player_spawned};
	private _my_squad = player getVariable "my_squad";
	// If Squad exist
	if (!isNil "_my_squad") then {
		private _leader = leader _my_squad;
		private _veh_player = objectParent player;
		if (_leader distance2D player <= 30 && count (waypoints _my_squad) == 0) then {
			if (!isNull _veh_player) then {
				if (_veh_player iskindof "ParachuteBase") exitWith {};
				//get in vehicle
				private _list = (units _my_squad) select { objectParent _x != _veh_player};
				if (count _list > 0) then {
					player sideChat format ["%1 board in %2!", _my_squad, [_veh_player] call F_getLRXName];
					doStop _list;
					[_veh_player, _list, false] call F_manualCrew;
					sleep 5;
				};
			} else {
				//get out vehicle
				private _list = (units _my_squad) select {
					private _vehicle = objectParent _x;
					!isNull _vehicle && { !(_vehicle isKindOf "ParachuteBase") }
				};
				if (count _list > 0) then {
					player sideChat format ["%1 get out vehicle!", _my_squad];
					{ [_x, false] spawn F_ejectUnit; sleep 0.5 } forEach _list;
					sleep 5;
				};
			};
		};

		private _my_squad_order = player getVariable ["my_squad_order", nil];
		if (!isNil "_my_squad_order") then {
			_leader sideChat "Order Received !!";
			player setVariable ["my_squad_order", nil, true];
		};

		if ( { alive _x } count (units _my_squad) == 0) then {
			player setVariable ["my_squad", nil, true];
			player setVariable ["my_squad_order", nil, true];
			[false] call player_squad_actions;
		};
	};
	sleep 5;
};
