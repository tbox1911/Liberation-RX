params [ "_unit", "_cmd" ];
if !(local _unit) exitWith {};

private ["_anim", "_grp"];

if (_cmd == "stop") exitWith {
    sleep (3 + floor(random 4));

    if (!isNull objectParent _x) then {
        doGetOut _unit;
        unassignVehicle _unit;
        [_unit] orderGetIn false;
        [_unit] allowGetIn false;
        sleep 3;
    };

    _unit stop true;
    _grp = createGroup [GRLIB_side_civilian, true];
    [_unit] joinSilent _grp;
    _unit disableAI "ANIM";
    _unit disableAI "MOVE";
    _anim = "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon_ground";
    _unit switchMove _anim;
    _unit playMoveNow _anim;
};

if (_cmd == "move") exitWith {
	_unit stop false;
	_unit enableAI "ANIM";
	_unit enableAI "MOVE";
	_anim = "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
	_unit switchMove _anim;
	_unit playMoveNow _anim;
};

if (_cmd == "flee") exitWith {
    _unit stop false;
    _unit setUnitPos "AUTO";
    _unit enableAI "ANIM";
    _unit enableAI "MOVE";
    if (!isNull objectParent _unit) then {
        doGetOut _unit;
        unassignVehicle _unit;
        [_unit] orderGetIn false;
        [_unit] allowGetIn false;
        sleep 3;
    };
    _anim = "AmovPercMwlkSrasWrflDf";
    _unit switchMove _anim;
    _unit playMoveNow _anim;
    sleep 2;

    _grp = group _unit;
    _nearest_sector = [opfor_sectors, _unit] call F_nearestPosition;
    if (typeName _nearest_sector == "STRING") then {
        if (_unit distance2D (markerPos _nearest_sector) > 10) then {
            [_grp] call F_deleteWaypoints;
            _waypoint = _grp addWaypoint [markerPos _nearest_sector, 0];
            _waypoint setWaypointType "MOVE";
            _waypoint setWaypointSpeed "FULL";
            _waypoint setWaypointBehaviour "SAFE";
            _waypoint setWaypointCombatMode "BLUE";
            _waypoint setWaypointCompletionRadius 50;
            _waypoint setWaypointStatements ["true", "deleteVehicle this"];
            { _x doFollow (leader _grp) } foreach (units _grp);
        } else {
            deleteVehicle _unit;
        };
    } else {
        deleteVehicle _unit;
    };

};
