params ["_grp", "_vehicles"];

if (count _vehicles == 0) exitWith {};

// Group Behaviour
_grp setFormation "COLUMN";
_grp setBehaviourStrong "AWARE";
_grp setCombatMode "GREEN";
_grp setSpeedMode "LIMITED";

{ _x setConvoySeparation 50 } forEach _vehicles;

private _convoy_attacked = false;
private _disembark_troops = false;

sleep 20;
while { !_disembark_troops && (({ alive _x } count _vehicles) > 0) } do {
	// Attacked ?
	if (!_convoy_attacked) then {
		{
			_veh_cur = _x;
            if (!isNull _veh_cur) then {
                _killed = ({ !alive _x } count (units _grp) > 0);
                if ( !(alive _veh_cur) || (damage _veh_cur > 0.2) || _killed && (count ([_veh_cur, GRLIB_sector_size] call F_getNearbyPlayers) > 0) ) then {
                    _convoy_attacked = true;
                };
            };
		} foreach _vehicles;
	};

	// Drivers Follow
	if (!_convoy_attacked && !_disembark_troops) then {
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
	if (_convoy_attacked && !_disembark_troops) then {
		_disembark_troops = true;
		{
            [_x] spawn {
                params ["_vehicle"];
                if (!isNull _vehicle) then {
                    doStop (driver _vehicle);
                    sleep 2;
                    {
                        [_x, false] spawn F_ejectUnit;
                        sleep 0.2
                    } forEach (crew _vehicle);
                };
            };
		} foreach _vehicles;
		sleep 5;
		[_grp, getPosATL (_vehicles select 1)] spawn defence_ai;
	};

    sleep 2;
};
