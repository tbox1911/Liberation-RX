params ["_grp", "_vehicles", ["_objective_pos", []]];

if (count _vehicles == 0) exitWith {};

// Group Behaviour
_grp setFormation "COLUMN";
_grp setBehaviourStrong "AWARE";
_grp setCombatMode "GREEN";
_grp setSpeedMode "LIMITED";
{ _x setConvoySeparation 50 } forEach _vehicles;
sleep 20;

private _convoy_attacked = false;
private _timeout = time + 600;	// 10 min tiemout

while { !_convoy_attacked && (({ alive _x } count _vehicles) > 0) } do {
	// Attacked ?
	if (!_convoy_attacked) then {
		{
			_veh_cur = _x;
            if (!isNull _veh_cur) then {
                _killed = ({ !alive _x } count (units _grp) > 0);
                if ( !(alive _veh_cur) || (damage _veh_cur >= 0.2) || _killed && (count ([_veh_cur, GRLIB_sector_size] call F_getNearbyPlayers) > 0) ) then {
                    _convoy_attacked = true;
                };
            };
		} foreach _vehicles;
	};

	// Destination ?
	if (count _objective_pos > 0) then {
		{
			if (_x distance2D _objective_pos <= 250) then { _convoy_attacked = true };
		} foreach _vehicles;
	};

	// Timeout
	if (time >= _timeout) then { _convoy_attacked = true };

	// Drivers Follow
	if (!_convoy_attacked) then {
		{
			_veh_cur = _x;
			_veh_leader = vehicle (leader _grp);
			if (speed _veh_cur < 2 && (_veh_cur distance2D _veh_leader > 50 || _veh_cur == _veh_leader)) then {
				_veh_cur setFuel 1;
				_veh_cur setDamage 0;
				[_veh_cur] call F_vehicleUnflip;
				_veh_cur setPos ([getPos _veh_cur, 2] call F_getRandomPos);
				if (_veh_cur != _veh_leader) then {
					(driver _veh_cur) doFollow (leader _grp);
					(driver _veh_cur) doMove getPosATL (leader _grp);
				};
				sleep 2;
			};
		} foreach _vehicles;
	};

	// Eject Troop
	if (_convoy_attacked) exitWith {
		{
            [_x, _objective_pos] spawn {
                params ["_vehicle", "_objective_pos"];
				if (isNull _vehicle || !alive _vehicle) exitWith {};
				private _cargo_troops = (crew _vehicle) select { ("cargo" in (assignedVehicleRole _x)) };
				if (count _cargo_troops > 0) then {
					doStop (driver _vehicle);
					sleep 2;
					{ [_x, false] spawn F_ejectUnit; sleep 0.2 } forEach _cargo_troops;
					sleep 5;
					private _grp = group (_cargo_troops select 0);
					if (count _objective_pos > 0) then {
						[_grp, _objective_pos] spawn battlegroup_ai;
					} else {
						[_grp, getPosATL _vehicle] spawn defence_ai;
					};
				};
            };
			sleep 1;
		} foreach _vehicles;
	};

    sleep 2;
};
