params [ "_unit", ["_force_surrender", false] ];

if ( (!_force_surrender) && (typeof _unit == pilot_classname) ) exitWith {};
if ( (!_force_surrender) && ((random 100) > GRLIB_surrender_chance) ) exitWith {};
if ( (!_force_surrender) && (_unit getVariable ["mission_AI", false]) ) exitWith {};

if ( (_unit isKindOf "Man") && ( alive _unit ) && (vehicle _unit == _unit) && (side group _unit == GRLIB_side_enemy) ) then {
	sleep (2 + floor(4));
	if (!alive _unit) exitWith {};

	// Init priso
	removeAllWeapons _unit;
	if(typeof _unit != pilot_classname) then {
		removeHeadgear _unit;
	};
	removeBackpack _unit;
	removeVest _unit;
	_unit unassignItem "NVGoggles_OPFOR";
	_unit removeItem "NVGoggles_OPFOR";
	_unit unassignItem "NVGoggles_INDEP";
	_unit removeItem "NVGoggles_INDEP";
	_unit setUnitPos "UP";
	sleep 1;
	_unit disableAI "ANIM";
	_unit disableAI "MOVE";
	_unit playmove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon" ;
	sleep 2;
	_unit setCaptive true;
	_unit setVariable ["GRLIB_is_prisonner", true, true];

	// Wait
	waitUntil { sleep 1;!alive _unit || side group _unit == GRLIB_side_friendly	};
	if (!alive _unit) exitWith {};

	// Follow
	_unit playmove "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
	sleep 2;
	_unit enableAI "ANIM";
	_unit enableAI "MOVE";
	sleep 1;
	[_unit, ""] remoteExec ["switchmove", 0];

	while {alive _unit} do {

		// Flee
		private _is_near_blufor = count ([allUnits, { side _x == GRLIB_side_friendly && (_x distance2D _unit) < 100 }] call BIS_fnc_conditionalSelect);
		if ( _is_near_blufor == 0 && side group _unit == GRLIB_side_friendly ) then {
			_grp = createGroup [GRLIB_side_enemy, true];
			[_unit] joinSilent _grp;
			_unit setUnitPos "AUTO";
			_unit setVariable ["GRLIB_is_prisonner", true, true];

			if ((vehicle _unit != _unit) && !(_unit isEqualTo (driver vehicle _unit))) then {
				unAssignVehicle _unit;
				_unit action ["eject", vehicle _unit];
				_unit action ["getout", vehicle _unit];
				unAssignVehicle _unit;
			};

			while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
			{_x doFollow leader _grp} foreach units _grp;

			private _sectors = (sectors_allSectors - blufor_sectors);
			private _nearest_sector = [_sectors, _unit] call BIS_fnc_nearestPosition;

			if (!isNil "_nearest_sector") then {
				_waypoint = _grp addWaypoint [markerPos _nearest_sector, 0];
				_waypoint setWaypointType "MOVE";
				_waypoint setWaypointSpeed "FULL";
				_waypoint setWaypointBehaviour "AWARE";
				_waypoint setWaypointCombatMode "GREEN";
				_waypoint setWaypointCompletionRadius 50;
			};
		};

		// Captured
		private _is_near_fob = (( _unit distance ([getpos _unit] call F_getNearestFob) ) < 30 );
		if ( _is_near_fob ) then {
			private _unit_owner = leader group _unit;
			sleep (3 + floor(random 5));
			if (vehicle _unit != _unit) then {
				unassignVehicle _unit;
				doGetOut _unit;
			};
			sleep 4;
			_grp = createGroup [GRLIB_side_friendly, true];
			[_unit] joinSilent _grp;
			_unit playmove "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon_ground";
			_unit disableAI "ANIM";
			_unit disableAI "MOVE";
			doStop _unit;
			sleep 5;
			[_unit, "AidlPsitMstpSnonWnonDnon_ground00"] remoteExec ["switchmove", 0];
			[_unit, _unit_owner] call prisonner_captured;
			sleep 300;
			deleteVehicle _unit;
		};

		sleep 5;
	};
};