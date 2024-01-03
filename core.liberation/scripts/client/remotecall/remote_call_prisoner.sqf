params [ "_unit", "_cmd" ];
if !(local _unit) exitWith {};

private _anim = "";

if (_cmd == "stop") exitWith {
    sleep (3 + floor(random 4));

    if (!isNull objectParent _unit) then {
        doGetOut _unit;
        unassignVehicle _unit;
        [_unit] orderGetIn false;
        [_unit] allowGetIn false;
        sleep 3;
    };
    _unit stop true;
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
};
