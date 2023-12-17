// PAR Manage Action

private ["_unit", "_wnded_list", "_id1", "_id2", "_id3"];

private _checkAction = {
    params ["_unit"];
    private _act = _unit getVariable ["PAR_isMenuActive", []];
    private _cnt = { _x in _act } count (actionIDs _unit);
    (_cnt < 3);
};

while {true} do {
    _wnded_list = (units GRLIB_side_friendly) select {
        (_x distance2D player) < 30 &&
        (_x getVariable ["PAR_wounded", false]) &&
        ([_x] call _checkAction) &&
        isNull objectParent _x &&
        isNil {_x getVariable 'PAR_busy'} &&
        isNil {_x getVariable 'PAR_healed'}
    };

    if (count _wnded_list > 0) then {
        {
            _unit = _x;
            _id1 = _unit addAction ["<t color='#C90000'>" + localize "STR_PAR_AC_02" + "</t>", "addons\PAR\PAR_fn_drag.sqf", ["action_drag"], 9, false, true, "", "(_target getVariable ['PAR_isUnconscious', false]) && !PAR_isDragging", 3];
            _id2 = _unit addAction ["<t color='#C90000'>" + localize "STR_PAR_AC_03" + "</t>", { PAR_isDragging = false }, ["action_release"], 10, true, true, "", "PAR_isDragging"];
            _id3 = [
                _unit,
                "<t color='#00C900'>" + localize "STR_PAR_AC_01" + "</t>",
                "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
                "
                    (_this distance2D _target <= 3) &&
                    (_target getVariable ['PAR_isUnconscious', false]) &&
                    (_target getVariable ['PAR_isDragged',0] == 0) &&
                    ([_this] call PAR_has_medikit || [_this] call PAR_is_medic)
                ",
                "(_caller distance2D _target < 3)",
                {
                    [(_target getVariable ["PAR_myMedic", objNull]), _target] call PAR_fn_medicRelease;
                    if (local _caller) then { _target setVariable ["PAR_myMedic", _caller] };
                    _msg = format [localize "STR_PAR_ST_01", name _caller, name _target];
                    [_target, _msg] remoteExec ["PAR_fn_globalchat", 0];
                    _bleedOut = _target getVariable ["PAR_BleedOutTimer", 0];
                    _target setVariable ["PAR_BleedOutTimer", _bleedOut + PAR_BleedOutExtra, true];
                    _grbg = createVehicle [(selectRandom PAR_MedGarbage), getPos _target, [], 0, "CAN_COLLIDE"];
                    _grbg spawn {sleep (60 + floor(random 30)); deleteVehicle _this};
                    if (stance _caller == "PRONE") then {
                    _caller switchMove 'ainvppnemstpslaywrfldnon_medicother';
                    _caller playMoveNow 'ainvppnemstpslaywrfldnon_medicother';
                    } else {
                    _caller switchMove 'ainvpknlmstpslaywrfldnon_medicother';
                    _caller playMoveNow 'ainvpknlmstpslaywrfldnon_medicother';
                    };
                },
                {},
                {
                    if (local _target) then {
                        [_target, _caller] call PAR_fn_sortie;
                    } else {
                        [_target, _caller] remoteExec ["PAR_remote_sortie", 2];
                    };
                },
                {
                    if (animationState _caller == 'ainvppnemstpslaywrfldnon_medicother') then {
                    _caller switchMove "amovppnemstpsraswrfldnon";
                    _caller playMoveNow "amovppnemstpsraswrfldnon";
                    } else {
                    _caller switchMove "amovpknlmstpsraswrfldnon";
                    _caller playMoveNow "amovpknlmstpsraswrfldnon";
                    };
                    _target setVariable ["PAR_myMedic", nil];
                },
                [time],6,12,false
            ] call BIS_fnc_holdActionAdd;
            _unit setVariable ["PAR_isMenuActive", [_id1, _id2, _id3]];
            sleep 0.1;
        } forEach  _wnded_list;

    };

    sleep 1;
};
