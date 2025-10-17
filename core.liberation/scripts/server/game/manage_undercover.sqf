sleep 60;

private ["_opfor_grp", "_unit", "_undercover_units", "_awareness"];

while {true} do {
    _undercover_units = (units GRLIB_side_civilian) select { !(captive _x) && !(isNil {_x getVariable "PAR_Grp_ID"}) };
    {
        _opfor_grp = _x;
        if (local _opfor_grp) then {
            {
                _unit = _x;
                _current = _unit getVariable ["GRLIB_unit_detected", 0];
                if (_current < 1.5) then {
                    _awareness = _opfor_grp knowsAbout _unit;
                    if (_awareness > 0) then {
                        _unit setVariable ["GRLIB_unit_detected", (_current max _awareness), true];
                        if (_awareness >= 1.5) then {
                            private _msg = format ["%1 has been detected by group %2 (%3)", name _unit, _opfor_grp, _awareness];
                            [gamelogic, _msg] remoteExec ["globalChat", owner _unit];
                        };
                    };
                };
                sleep 0.1;
            } forEach _undercover_units;
        };
        sleep 0.1;
    } forEach (groups GRLIB_side_enemy);

    sleep 5;
};
