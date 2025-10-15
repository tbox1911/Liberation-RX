sleep 60;

private _is_armed = {
    params ["_unit"];
    (handgunWeapon _unit != "" || primaryWeapon _unit != "" || secondaryWeapon _unit != "");
};

private ["_opfor_grp", "_undercover_units", "_awareness"];
private _knowledge = 1.5;  // 1.105, 1.5, 1.7, 4

while {true} do {
    _undercover_units = (units GRLIB_side_civilian) select { (!isNil {_x getVariable "PAR_Grp_ID"}) };

    {
        _opfor_grp = _x;
        if (local _opfor_grp) then {
            {
                if !(_x getVariable ["GRLIB_unit_detected", false]) then {
                    _awareness = _opfor_grp knowsAbout _x;
                    if (_awareness >= _knowledge && [_x] call _is_armed) then {
                        // private _msg = format ["DBG: player detected by group %1 (%2)", _opfor_grp, _awareness];
                        // systemchat _msg;
                        // diag_log _msg;
                        _x setVariable ["GRLIB_unit_detected", true, true];
                    };
                };
                sleep 0.1;
            } forEach _undercover_units;
        };
        sleep 0.1;
    } forEach (groups GRLIB_side_enemy);

    sleep 5;
};
