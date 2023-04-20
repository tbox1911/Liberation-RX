params ["_grp"];
while {count (units _grp) >= 1} do {
	if (GRLIB_squad_follow) then {
		_leader = leader _grp;
		//get in
		_veh_player = vehicle player;
		if ( _veh_player != player && _leader distance2D player <= 15 ) then {
			{
				_cargo_seat = ([typeOf vehicle player,true] call BIS_fnc_crewCount) - ([typeOf vehicle player,false] call BIS_fnc_crewCount);
				if (vehicle _x != _veh_player && count (crew vehicle player) <= _cargo_seat) then {
					_x action ["GETINCARGO", _veh_player];
					sleep 0.5;
				};
			} forEach units _grp;
		};

		//para drop
		if (_veh_player iskindof "Steerable_Parachute_F") then {
			{
				if ( vehicle _x != _x && !(vehicle _x iskindof "Steerable_Parachute_F") ) then {
					[_x, getPos _x] spawn paraDrop;
					sleep 0.3;
				};
			} forEach units _grp;
		};

		//get out
		if (_veh_player == player) then {
			{
				if ( vehicle _x != _x && (getPosATL _x select 2) <= 5) then {
					unassignVehicle _x;
					_x action ["GETOUT", vehicle _x];
					sleep 0.5;
					};
			} forEach units _grp;
		};

		//follow player
		{
			if (vehicle _x == _x && (_leader distance2D player > 15 || _x distance2D _leader > 15)) then {
				if (_x != _leader) then {
					_x doFollow _leader;
					_x doMove (getPos _leader);
				} else {
					_leader setUnitPos "UP";
					_leader setSpeedMode 'FULL';
					_leader doMove (getPos player);
				};
			};
		} forEach units _grp;
	};
	sleep 5;
};
player setVariable ["my_squad", nil, true];