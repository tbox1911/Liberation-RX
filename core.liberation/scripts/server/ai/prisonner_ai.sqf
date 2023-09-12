params [ "_unit", ["_friendly", false], ["_canmove", false] ];

if (_unit getVariable ["GRLIB_mission_AI", false]) exitWith {};
if (_unit getVariable ["GRLIB_is_prisonner", false]) exitWith {};

sleep 3;
if (!alive _unit) exitWith {};

_unit setCaptive true;
_unit setVariable ["GRLIB_is_prisonner", true, true];
_unit setVariable ["GRLIB_can_speak", true, true];

if (!_canmove) then {
	// Init priso
	removeAllWeapons _unit;
	//removeHeadgear _unit;
	removeBackpack _unit;
	removeVest _unit;
	_hmd = (hmd _unit);
	_unit unassignItem _hmd;
	_unit removeItem _hmd;
	_unit setUnitPos "UP";
	sleep 1;
	_unit disableAI "ANIM";
	_unit disableAI "MOVE";
	_anim = "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
	[_unit, _anim] remoteExec ["switchMove", 0];
	[_unit, _anim] remoteExec ["playMoveNow", 0];
	sleep 3;
};

// Wait
if (_friendly) then {
	waitUntil { sleep 1; !alive _unit || side group _unit == GRLIB_side_friendly};
} else {
	private _timeout = time + (20 * 60);
	waitUntil { sleep 1; !alive _unit || side group _unit == GRLIB_side_friendly || time > _timeout };
};

if (!alive _unit) exitWith {};

// Follow
_unit enableAI "ANIM";
_unit enableAI "MOVE";
_anim = "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
[_unit, _anim] remoteExec ["switchMove", 0];
[_unit, _anim] remoteExec ["playMoveNow", 0];
sleep 3;

private _unit_captured = false;
while {alive _unit || !_unit_captured } do {
	_unit_captured = _unit getVariable ["GRLIB_is_prisonner", false];

	// Captured
	if ([_unit, "FOB", 30] call F_check_near && isTouchingGround (vehicle _unit)) then {
		//_unit_captured = true;
		sleep (2 + floor(random 4));
		private _unit_owner = leader group _unit;

		if (!isnull objectParent _unit) then {
			unassignVehicle _unit;
			[_unit] orderGetIn false;
			[_unit] allowGetIn false;
			doGetOut _unit;
			sleep 3;
		};
		doStop _unit;
		sleep 2;

		_grp = createGroup [GRLIB_side_civilian, true];
		[_unit] joinSilent _grp;
		_unit disableAI "ANIM";
		_unit disableAI "MOVE";
		_anim = "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon_ground";
		[_unit, _anim] remoteExec ["switchMove", 0];
		[_unit, _anim] remoteExec ["playMoveNow", 0];
		[_unit, _unit_owner] call prisonner_captured;
		sleep 300;
		deleteVehicle _unit;
	};

	// Flee
	waituntil { sleep 1; !(player getVariable ["GRLIB_action_inuse", false]) };
	if (!_unit_captured) then {
		private _is_near_blufor = { (alive _x) && !(captive _x) && (_x distance2D _unit <= 100) } count (units GRLIB_side_friendly);
		if ( _is_near_blufor == 0 && !_friendly ) then {
			_unit setVariable ["GRLIB_is_prisonner", true, true];

			if (side group _unit == GRLIB_side_friendly) then {
				private _text = format ["Alert! prisonner %1 is escaping!", name _unit];
				[gamelogic, _text] remoteExec ["globalChat", (owner _unit)];
			};

			private _flee_grp = createGroup [GRLIB_side_enemy, true];
			[_unit] joinSilent _flee_grp;

			_unit setUnitPos "AUTO";
			unAssignVehicle _unit;
			[_unit] spawn F_ejectUnit;
			sleep 2;
			_anim = "AmovPercMwlkSrasWrflDf";
			[_unit, _anim] remoteExec ["switchMove", 0];
			[_unit, _anim] remoteExec ["playMoveNow", 0];			
			sleep 2;
			private _nearest_sector = [opfor_sectors, _unit] call F_nearestPosition;
			if (typeName _nearest_sector == "STRING") then {
				[_flee_grp] call F_deleteWaypoints;
				private _waypoint = _flee_grp addWaypoint [markerPos _nearest_sector, 0];
				_waypoint setWaypointType "MOVE";
				_waypoint setWaypointSpeed "FULL";
				_waypoint setWaypointBehaviour "SAFE";
				_waypoint setWaypointCombatMode "BLUE";
				_waypoint setWaypointCompletionRadius 50;
				_waypoint setWaypointStatements ["true", "deleteVehicle this"];
				{_x doFollow leader _flee_grp} foreach units _flee_grp;
				sleep 5;
			} else {
				{ deleteVehicle _x } forEach (units _flee_grp);
			};
		};
	};
	sleep 5;
};
