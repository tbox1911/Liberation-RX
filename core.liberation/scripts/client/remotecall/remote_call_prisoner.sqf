params [ "_unit", "_cmd" ];
private ["_anim", "_grp", "_leader"];

if (_cmd == "stop") exitWith {
    _leader = leader group _unit;
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
    sleep 2;
    [_unit, _leader] remoteExec ["prisonner_captured", 2];
};

if (_cmd == "move") exitWith {
	_unit stop false;
	_unit enableAI "ANIM";
	_unit enableAI "MOVE";
	_anim = "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
	_unit switchMove _anim;
	_unit playMoveNow _anim;
};
