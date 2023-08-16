params [ "_unit", ["_friendly", false], ["_canmove", false] ];
if (_unit skill "courage" == 1) exitWith {};
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
	_unit playMoveNow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon" ;
	sleep 2;
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
_unit playMoveNow "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
sleep 2;
_unit enableAI "ANIM";
_unit enableAI "MOVE";
sleep 1;
[_unit, ""] remoteExec ["switchmove", 0];

private _unit_captured = false;
while {alive _unit || !_unit_captured } do {
	// Captured
	if ([_unit, "FOB", 30] call F_check_near && isTouchingGround (vehicle _unit)) then {
		_unit_captured = true;
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

		_grp = createGroup [GRLIB_side_friendly, true];
		[_unit] joinSilent _grp;
		_unit playMoveNow "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon_ground";
		_unit disableAI "ANIM";
		_unit disableAI "MOVE";
		sleep 3;
		[_unit, "AidlPsitMstpSnonWnonDnon_ground00"] remoteExec ["switchmove", 0];
		[_unit, _unit_owner] call prisonner_captured;
		sleep 300;
		deleteVehicle _unit;
	};

	// Flee
	_player_redploy = player getVariable ["GRLIB_action_inuse", false];
	if (!_player_redploy && !_unit_captured) then {
		private _is_near_blufor = count ([units GRLIB_side_friendly, { (isNil {_x getVariable "GRLIB_is_prisonner"}) && (_x distance2D _unit) < 100 }] call BIS_fnc_conditionalSelect);
		if ( _is_near_blufor == 0 && !_friendly ) then {
			if (side group _unit == GRLIB_side_friendly) then {
				private _text = format ["Alert! prisonner %1 is escaping!", name _unit];
				[gamelogic, _text] remoteExec ["globalChat", (owner _unit)];
			};

			private _flee_grp = createGroup [GRLIB_side_enemy, true];
			[_unit] joinSilent _flee_grp;

			_unit setUnitPos "AUTO";
			_unit setVariable ["GRLIB_is_prisonner", true, true];
			unAssignVehicle _unit;
			if (!isNull objectParent _unit) then { [(vehicle _unit), _unit] spawn F_ejectUnit };
			_unit switchMove "AmovPercMwlkSrasWrflDf";
			_unit playMoveNow "AmovPercMwlkSrasWrflDf";
			sleep 2;
			private _nearest_sector = [(sectors_allSectors - blufor_sectors), _unit] call F_nearestPosition;
			if (typeName _nearest_sector == "STRING") then {
				[_flee_grp] call F_deleteWaypoints;

				_waypoint = _flee_grp addWaypoint [markerPos _nearest_sector, 0];
				_waypoint setWaypointType "MOVE";
				_waypoint setWaypointSpeed "FULL";
				_waypoint setWaypointBehaviour "SAFE";
				_waypoint setWaypointCombatMode "GREEN";
				_waypoint setWaypointCompletionRadius 50;
				_waypoint = _flee_grp addWaypoint [markerPos _nearest_sector, 0];
				_waypoint setWaypointType "MOVE";
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
