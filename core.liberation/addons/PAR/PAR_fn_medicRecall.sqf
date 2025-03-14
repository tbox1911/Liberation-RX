((findDisplay 5566) displayCtrl 679) ctrlEnable false;
_unit = player;
if ( {
    alive _x
} count PAR_AI_bros > 0 ) then {
    _unit setVariable ["PAR_myMedic", nil];
    _unit groupchat localize "STR_PAR_UC_01";
    _medic = [_unit] call PAR_fn_medic;
    if (!isNil "_medic") then {
        [_unit, _medic] call PAR_fn_911;
    };
    
} else {
    _msg = format [localize "STR_PAR_UC_03", name _unit];
    if ([_unit] call PAR_is_wounded) then {
        _msg = format [localize "STR_PAR_UC_02", name _unit];
    };
    _last_msg = _unit getVariable ["PAR_last_message", 0];
    if (time > _last_msg) then {
        [_unit, _msg] call PAR_fn_globalchat;
        _unit setVariable ["PAR_last_message", round(time + 20)];
    };
};

uiSleep 60;
((findDisplay 5566) displayCtrl 679) ctrlEnable true;