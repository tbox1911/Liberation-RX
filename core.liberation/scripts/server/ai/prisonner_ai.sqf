params [ "_unit", ["_force_surrender", false] ];

if ( (!_force_surrender) && (typeof _unit == pilot_classname) ) exitWith {};
if ( (!_force_surrender) && (_unit getVariable ["mission_AI", false]) ) exitWith {};

sleep 3;
if (!alive _unit) exitWith {};

// Init priso
removeAllWeapons _unit;
if (typeof _unit != pilot_classname) then {
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
	if ( _is_near_blufor == 0 && side group _unit == GRLIB_side_friendly && typeof _unit != pilot_classname ) then {
		_unit setUnitPos "AUTO";
		_unit setVariable ["GRLIB_is_prisonner", true, true];

		if ((vehicle _unit != _unit) && !(_unit isEqualTo (driver vehicle _unit))) then {
			unAssignVehicle _unit;
			_unit action ["eject", vehicle _unit];
			_unit action ["getout", vehicle _unit];
			unAssignVehicle _unit;
		};

		private _nearest_sector = [(sectors_allSectors - blufor_sectors), _unit] call F_nearestPosition;

		if (typeName _nearest_sector == "STRING") then {
			private _flee_grp = createGroup [GRLIB_side_civilian, true];
			[_unit] joinSilent _flee_grp;

			while {(count (waypoints _flee_grp)) != 0} do {deleteWaypoint ((waypoints _flee_grp) select 0);};
			{_x doFollow leader _flee_grp} foreach units _flee_grp;

			_waypoint = _flee_grp addWaypoint [markerPos _nearest_sector, 0];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointSpeed "FULL";
			_waypoint setWaypointBehaviour "AWARE";
			_waypoint setWaypointCombatMode "GREEN";
			_waypoint setWaypointCompletionRadius 50;

			_waypoint = _flee_grp addWaypoint [markerPos _nearest_sector, 0];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointCompletionRadius 50;
			_waypoint setWaypointStatements ["true", "deleteVehicle this"];
			sleep 10;
		};
	};

	// Captured
	private _is_near_fob = (( _unit distance ([getpos _unit] call F_getNearestFob) ) < 30 );
	if ( _is_near_fob ) then {
		private _unit_owner = leader group _unit;
		sleep (3 + floor(random 5));
		doStop _unit;
		unassignVehicle _unit;
		[_unit] orderGetIn false;
		if (!isnull objectParent _unit) then {
			doGetOut _unit;
			sleep 3;
		};
		sleep 3;
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
