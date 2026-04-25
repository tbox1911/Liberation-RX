params ["_grp", "_vehicles", ["_objective_pos", []]];

if (count _vehicles == 0) exitWith {};

// Group Behaviour
_grp setBehaviourStrong "SAFE";
_grp setCombatMode "GREEN";
_grp setFormation "COLUMN";
_grp setSpeedMode "LIMITED";

private _first_veh = (_vehicles select 0);
_grp selectLeader (driver _first_veh);
{
	_x allowCrewInImmobile [true, true];
	_x setConvoySeparation 50;
} forEach _vehicles;

sleep 20;

private _convoy_attacked = false;
private _timeout = time + 800;
private _slow = 1;
private _speedNormal = 40;
private _speedSlow = 15;
private _speedStop = 5;
private _maxGap = 80;
private ["_veh_cur", "_killed", "_player_nearby", "_unload_range", "_veh_leader", "_maxDist"];

while {time < _timeout && !_convoy_attacked && (({ alive _x } count _vehicles) > 0) } do {
	// Dynamic Speed
	if (!_convoy_attacked && count _vehicles > 1) then {
		{
			private _idx = _vehicles find _x;
			if (_idx == 0) then {
				// Leader
				private _veh_behind = _vehicles select 1;
				private _dist = _x distance2D _veh_behind;

				if (_dist > _maxGap * 1.5) then {
					_x limitSpeed _speedStop;
				} else {
					if (_dist > _maxGap) then {
						_x limitSpeed _speedSlow;
					} else {
						_x limitSpeed _speedNormal;
					};
				};
			} else {
				// Follower 
				private _veh_ahead = _vehicles select (_idx - 1);
				private _dist = _x distance2D _veh_ahead;

				if (_dist > _maxGap * 1.5) then {
					_x limitSpeed 999;
				} else {
					if (_dist < 20) then {
						_x limitSpeed _speedSlow;
					} else {
						_x limitSpeed _speedNormal;
					};
				};
			};
		} forEach _vehicles;
	};

	// Attacked ?
	if (!_convoy_attacked) then {
		_killed = ({!alive _x} count (units _grp) > 0);
		{
			_veh_cur = _x;
			_player_nearby = (count ([_veh_cur, GRLIB_sector_size] call F_getNearbyPlayers) > 0);
			if (_player_nearby && (damage _veh_cur >= 0.2 || _killed)) exitWith {
				_convoy_attacked = true;
			};
		} foreach _vehicles;
	};

	// Destination ?
	if (count _objective_pos > 0) then {
		{
			_unload_range = 300;
			if (_x isKindOf "Air") then {
				_unload_range = 800;
				if (_x distance2D _objective_pos <= (_unload_range * 2) && _slow == 1) then {
					_slow = 0;
					_x flyInHeight [60, true];
					_x flyInHeightASL [60, 60, 60];
					(group driver _x) setSpeedMode "LIMITED";
				};
			};
			if (_x distance2D _objective_pos <= _unload_range) then { _convoy_attacked = true };
		} foreach _vehicles;
	};

	// Drivers Follow
	if (!_convoy_attacked) then {
		_veh_leader = vehicle (leader _grp);
		{
			_veh_cur = _x;
			if (count (crew _veh_cur) > 0) then {
				if (speed _veh_cur < 2 && (_veh_cur distance2D _veh_leader > 50 || _veh_cur == _veh_leader)) then {
					_veh_cur setFuel 1;
					_veh_cur setDamage 0;
					[_veh_cur, true] call F_vehicleUnflip;
					if (_veh_cur != _veh_leader) then {
						(driver _veh_cur) doFollow (leader _grp);
						(driver _veh_cur) doMove getPosATL (leader _grp);
					};
					sleep 2;
				};
			};
		} foreach _vehicles;
	};

	sleep 1;
};

if (_convoy_attacked) then {
	// Eject Troop
	{
		[_x] spawn {
			params ["_vehicle"];
			if (!alive _vehicle) exitWith {};
			if (_vehicle isKindOf "Air") then {
				_vehicle land "LAND";
				waitUntil { sleep 0.1; round (getPos _vehicle select 2) <= 4 };
			} else {
				doStop (driver _vehicle);
				sleep 2;
			};
			if (!alive _vehicle) exitWith {};
			sleep 1;
			_vehicle lock 0;
			{
				[_x, false] spawn F_ejectUnit;
				sleep 0.2;
			} forEach (crew _vehicle);
		};
		sleep 0.5;
	} foreach _vehicles;

	(units _grp) allowGetIn false;
	(units _grp) orderGetIn false;

	waitUntil { sleep 1; ({ !(isNull objectParent _x) } count (units _grp) == 0) };

	_grp setFormation "WEDGE";
	_grp setSpeedMode "NORMAL";
	_grp setBehaviourStrong "AWARE";

	if ({alive _x} count (units _grp) > 0) then {
		if (count _objective_pos > 0) then {
			[_grp, _objective_pos] spawn battlegroup_ai;
		} else {
			_objective_pos = getPosATL (leader _grp);
			[_grp, _objective_pos] spawn defence_ai;
		};
	};
};
