waitUntil {sleep 1; GRLIB_player_spawned};
if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {};

private _cargo_seat_free = 0;

while { true } do {
	// If Squad
	private _my_squad = player getVariable ["my_squad", nil];
	if (!isNil "_my_squad") then {
		private _leader = leader _my_squad;
		private _veh_player = vehicle player;

		//get in
		if ( _veh_player != player && _leader distance2D player <= 15 && count (waypoints _my_squad) == 0 ) then {
			{
				_cargo_seat_free = _veh_player emptyPositions "Cargo";
				if (vehicle _x != _veh_player && _cargo_seat_free > 0) then {
					_x assignAsCargo _veh_player;
					_x moveInCargo _veh_player;
					[_x] orderGetIn true;
				};

				if (vehicle _x == _x && _cargo_seat_free == 0) then {
					_x doMove (getPosATL player);
				};
				sleep 0.5;
			} forEach units _my_squad;
		} else {
			//para drop
			if (_veh_player iskindof "Steerable_Parachute_F") then {
				{
					if ( vehicle _x != _x && !(vehicle _x iskindof "Steerable_Parachute_F") ) then {
						[_x, getPos _x] spawn paraDrop;
						sleep 0.3;
					};
				} forEach units _my_squad;
			};

			//get out
			if (_veh_player == player) then {
				{
					//group leaveVehicle vehicle
					if (vehicle _x != _x && getPos _x select 2 <= 5) then {
						_x action ["getOut", vehicle _x];
						unassignVehicle _x;
						commandGetOut _x;
						doGetOut _x;
						sleep 0.5;
					};
				} forEach units _my_squad;
			};

			//go Pos
			private _wPos = getPos player;
			if (count (waypoints _my_squad) > 0 ) then {
				_wPos = getWPPos [_my_squad, 0];
			};

			if  (_leader distance2D _wPos > 10) then {
				_leader setUnitPos "UP";
				_leader setSpeedMode 'FULL';
				_leader doMove _wPos;
			} else {
				doStop _leader;
			};
			private _squad_grp = (units _my_squad - [_leader]);
			_squad_grp doFollow _leader;
		};
		
		private _my_squad_order = player getVariable ["my_squad_order", nil];
		if (!isNil "_my_squad_order") then {
			_leader sideChat "Order Received !!";
			player setVariable ["my_squad_order", nil, true];
		};

		if (count (units _my_squad) == 0) then {
			player setVariable ["my_squad", nil, true];
			player setVariable ["my_squad_order", nil, true];
		};
	};
	sleep 5;
};
