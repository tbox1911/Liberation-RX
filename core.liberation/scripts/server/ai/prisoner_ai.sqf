params [ "_unit", ["_friendly", false], ["_canmove", false] ];

if (isNull _unit) exitWith {};
if ((typeOf _unit) select [0,10] == "RyanZombie") exitWith {};
if (_unit getVariable ["GRLIB_mission_AI", false]) exitWith {};
if (_unit getVariable ["GRLIB_is_prisoner", false]) exitWith {};
if (_unit skill "courage" == 1) exitWith {};

sleep 3;
if (!alive _unit) exitWith {};

// Init priso
private ["_grp", "_flee_grp", "_anim"];
if !(_unit getVariable ["GRLIB_in_building", false]) then {
	[_unit] call F_fixPosUnit;
};

_unit setCaptive true;
removeAllWeapons _unit;
//removeHeadgear _unit;
removeBackpack _unit;
removeVest _unit;
private _hmd = (hmd _unit);
_unit unassignItem _hmd;
_unit removeItem _hmd;
_unit setVariable ["GRLIB_is_prisoner", true, true];
_unit setVariable ["GRLIB_can_speak", true, true];

if (!_canmove) then {
	_unit stop true;
	_unit switchMove "";
	_unit setUnitPos "UP";
	sleep 1;
	_unit disableAI "ANIM";
	_unit disableAI "MOVE";
	_anim = "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
	[_unit, _anim] remoteExec ["switchMove", 0];
	[_unit, _anim] remoteExec ["playMoveNow", 0];
	sleep 3;

	// Wait
	if (_friendly) then {
		waitUntil { sleep 1; !alive _unit || side group _unit == GRLIB_side_friendly};
	} else {
		private _timeout = time + (45 * 60);
		waitUntil { sleep 1; !alive _unit || side group _unit == GRLIB_side_friendly || time > _timeout };
		doGetOut _unit;
		unassignVehicle _unit;
		[_unit] orderGetIn false;
		[_unit] allowGetIn false;
	};
};

waitUntil { sleep 1; isNull objectParent _unit };
if (!alive _unit) exitWith {};

// Follow
if (!_canmove) then {
	_unit stop false;
	_unit enableAI "ANIM";
	_unit enableAI "MOVE";
	_anim = "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
	[_unit, _anim] remoteExec ["switchMove", 0];
	[_unit, _anim] remoteExec ["playMoveNow", 0];
	sleep 3;
};

private ["_no_blufor_near", "_player", "_player_in_action", "_waypoint", "_nearest_sector"];
private _flee_grp = grpNull;
private _fleeing = false;

while {alive _unit} do {

	// Captured
	if ([_unit, "FOB", 30] call F_check_near && isTouchingGround (vehicle _unit)) exitWith {
		sleep (2 + floor(random 4));
		private _unit_owner = leader group _unit;
		doGetOut _unit;
		unassignVehicle _unit;
		[_unit] orderGetIn false;
		[_unit] allowGetIn false;
		sleep 2;
		_unit stop true;
		_grp = createGroup [GRLIB_side_civilian, true];
		[_unit] joinSilent _grp;
		_unit disableAI "ANIM";
		_unit disableAI "MOVE";
		_anim = "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon_ground";
		[_unit, _anim] remoteExec ["switchMove", 0];
		[_unit, _anim] remoteExec ["playMoveNow", 0];
		sleep 2;
		[_unit, _unit_owner] call prisonner_captured;
		sleep 300;
		deleteVehicle _unit;
	};

	// Flee
	if (!_friendly) then {
		_no_blufor_near = ({ (alive _x) && !(captive _x) && (_x distance2D _unit <= 100) } count (units GRLIB_side_friendly) == 0);
		_player_in_action = ((leader group _unit) getVariable ["GRLIB_action_inuse", false]);

		if (_no_blufor_near && !_player_in_action && !_fleeing) then {
			_unit setVariable ["GRLIB_is_prisoner", true, true];
			_fleeing = true;

			if (side group _unit == GRLIB_side_friendly) then {
				private _text = format ["Alert! prisonner %1 is escaping!", name _unit];
				[gamelogic, _text] remoteExec ["globalChat", (owner _unit)];
			};

			_flee_grp = createGroup [GRLIB_side_enemy, true];
			[_unit] joinSilent _flee_grp;
			_unit enableAI "ANIM";
			_unit enableAI "MOVE";
			_unit stop false;
			doGetOut _unit;
			unassignVehicle _unit;
			[_unit] orderGetIn false;
			[_unit] allowGetIn false;
			_unit setUnitPos "AUTO";
			_anim = "AmovPercMwlkSrasWrflDf";
			[_unit, _anim] remoteExec ["switchMove", 0];
			[_unit, _anim] remoteExec ["playMoveNow", 0];
			sleep 2;

			_nearest_sector = [opfor_sectors, _unit] call F_nearestPosition;
			if (typeName _nearest_sector == "STRING") then {
				if (_unit distance2D (markerPos _nearest_sector) > 10) then {
					[_flee_grp] call F_deleteWaypoints;
					_waypoint = _flee_grp addWaypoint [markerPos _nearest_sector, 0];
					_waypoint setWaypointType "MOVE";
					_waypoint setWaypointSpeed "FULL";
					_waypoint setWaypointBehaviour "SAFE";
					_waypoint setWaypointCombatMode "BLUE";
					_waypoint setWaypointCompletionRadius 50;
					_waypoint setWaypointStatements ["true", "deleteVehicle this"];
					{ _x doFollow (leader _flee_grp) } foreach (units _flee_grp);
				} else {
					deleteVehicle _unit;
				};
			} else {
				deleteVehicle _unit;
			};
		};
	};

	// Stopped
	if !(_unit getVariable ["GRLIB_is_prisoner", true]) then {
		_fleeing = false;
	};

	sleep 5;
};
