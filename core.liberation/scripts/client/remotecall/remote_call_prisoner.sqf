params [ "_unit", "_cmd" ];

if (!local _unit) exitWith {};
if (!alive _unit) exitWith {};

private _anim = "";

if (_cmd == "init") exitWith {
	_unit switchMove _anim;
	_unit stop true;
	_unit disableAI "ANIM";
	_unit disableAI "MOVE";
	_anim = "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
	_unit switchMove _anim;
	_unit playMoveNow _anim;
};

if (_cmd == "stop") exitWith {
    _unit stop true;
    _unit disableAI "ANIM";
    _unit disableAI "MOVE";
    _anim = "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon_ground";
    _unit switchMove _anim;
    _unit playMoveNow _anim;
};

if (_cmd == "move") exitWith {
	_unit switchMove _anim;
	_unit stop false;
	_unit enableAI "ANIM";
	_unit enableAI "MOVE";
	_anim = "AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon";
	_unit switchMove _anim;
	_unit playMoveNow _anim;
};

if (_cmd == "flee") exitWith {
    _unit stop false;
    _unit enableAI "ANIM";
    _unit enableAI "MOVE";
    if !(isNull objectParent _unit) then { [_unit] call F_ejectUnit };
    _unit setUnitPos "AUTO";
    _anim = "AmovPercMwlkSnonWnonDf";  // "AmovPercMwlkSrasWrflDf"; // "AmovPercMwlkSnonWnonDf"
    _unit switchMove _anim;
    _unit playMoveNow _anim;
};
