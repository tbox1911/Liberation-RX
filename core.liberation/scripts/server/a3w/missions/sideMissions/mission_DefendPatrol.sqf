if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_patrol_grp"];

_setupVars = {
	_missionType = "STR_DEFPATROL";
	_locationsArray = [ForestMissionMarkers] call checkSpawn;
	_precise_marker = false;
};

_setupObjects = {
	_missionPos = [(markerpos _missionLocation), 5, 0] call F_findRandomPlace;
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};

    // create friendly
    _patrol_grp = [_missionPos, 6, "infantry-friendly", true, 25] call createCustomGroup;
    _objective_pos = getPosATL (leader _patrol_grp);
    {
		_x addEventHandler ["HandleDamage", {
			params ["_unit", "_selection", "_damage"];
            private _newDamage = _unit getVariable ["GRLIB_accumulated", 0];
            if (_damage > 0.5 && time >= (_unit getVariable ["GRLIB_isProtected", 0])) then {
                _newDamage = (_newDamage + 0.2) min 1;
                _unit setVariable ["GRLIB_accumulated", _newDamage];
                _unit setVariable ["GRLIB_isProtected", round (time + 10), true];
            };
            _newDamage;
		}];
    } forEach (units _patrol_grp);

	// create enemies
    _spawn_pos = ([_objective_pos, 250] call F_getRandomPos);
    _aiGroup = [_spawn_pos, 12, "militia", false] call createCustomGroup;
    [_aiGroup] call F_deleteWaypoints;
    _waypoint = _aiGroup addWaypoint [_objective_pos, 10];
    _waypoint setWaypointType "MOVE";
    _waypoint setWaypointSpeed "FULL";
    _waypoint setWaypointBehaviour "AWARE";
    _waypoint setWaypointCombatMode "YELLOW";
    _waypoint setWaypointCompletionRadius 20;
    _waypoint = _aiGroup addWaypoint [_objective_pos, 50];
    _waypoint setWaypointType "MOVE";
    _waypoint = _aiGroup addWaypoint [_objective_pos, 50];
    _waypoint setWaypointType "MOVE";
    _waypoint = _aiGroup addWaypoint [_objective_pos, 50];
    _waypoint setWaypointType "MOVE";
    _wp0 = waypointPosition [_aiGroup, 0];
    _waypoint = _aiGroup addWaypoint [_wp0, 0];
    _waypoint setWaypointType "CYCLE";
    sleep 1;
    (units _aiGroup) doFollow leader _aiGroup;

	// manage mission
	[_patrol_grp, _aiGroup] spawn {
		params ["_patrol_grp", "_enemy_grp"];
        _objective_pos = getPosATL (leader _patrol_grp);

        waitUntil { sleep 1; {alive _x} count (units _enemy_grp) <= 3 };
        if ({alive _x} count (units _patrol_grp) == 0) exitWith {};
        _spawn_pos = ([_objective_pos, 200] call F_getRandomPos);
        _grp = [_spawn_pos, ([] call getNbUnits), "militia", false] call createCustomGroup;
        (units _grp) joinSilent _enemy_grp;

        waitUntil { sleep 1; {alive _x} count (units _enemy_grp) <= 3 };
        if ({alive _x} count (units _patrol_grp) == 0) exitWith {};
        _spawn_pos = ([_objective_pos, 200] call F_getRandomPos);
        _grp = [_spawn_pos, ([] call getNbUnits), "militia", false] call createCustomGroup;
        (units _grp) joinSilent _enemy_grp;

        // waitUntil { sleep 1; {alive _x} count (units _enemy_grp) <= 3 };
        // if ({alive _x} count (units _patrol_grp) == 0) exitWith {};
        // _spawn_pos = ([_objective_pos, 250] call F_getRandomPos);
        // _grp = [_spawn_pos, ([] call getNbUnits), "militia", false] call createCustomGroup;
        // (units _grp) joinSilent _enemy_grp;
	};

    _missionPicture = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
	_missionHintText = ["STR_DEFPATROL_MESSAGE1", sideMissionColor];
	true;
};

_waitUntilExec = nil;
_waitUntilMarkerPos = nil;
_waitUntilSuccessCondition = nil;
_waitUntilCondition = { {alive _x} count (units _patrol_grp) == 0 };

_failedExec = {
	// Mission failed
	{deleteVehicle _x} forEach (units _patrol_grp);
    { [_x, -10] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	private _msg = format [localize "STR_SIDE_FAILED_REPUT", -10];
	[gamelogic, _msg] remoteExec ["globalChat", 0];
    _failedHintMessage = ["STR_DEFPATROL_MESSAGE3", sideMissionColor];
};

_successExec = {
	// Mission completed
	private _bonus = round (22 + random 25);
	{
        [_x, _bonus] call F_addScore;
		[_x, 10] call F_addReput;
	} forEach ([_missionPos, GRLIB_sector_size] call F_getNearbyPlayers);

	[_missionPos, (units _patrol_grp)] spawn {
		params ["_pos", "_list"];
		waitUntil { sleep 30; ([_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
		{ deleteVehicle _x } forEach _list;
	};
	_successHintMessage = "STR_DEFPATROL_MESSAGE2";
};

_this call sideMissionProcessor;
