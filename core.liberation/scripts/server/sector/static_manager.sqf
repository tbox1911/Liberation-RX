waitUntil {sleep 1; !isNil "GRLIB_init_server"};
sleep 12;

private _all_static = [];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
    _all_static = vehicles select { alive _x && (typeOf _x) in list_static_weapons && !(_x getVariable ["LRX_managed_static", false]) };
    {
        _static  = _x;
        if (local _static) then {
            [_static] spawn manage_one_static;
        } else {
            diag_log format ["--- LRX Transfert Static (%1) control to client %2", typeOf _static, owner _static];
            [_static] remoteExec ["manage_one_static", owner _static];
        };
        sleep 0.1;
    } forEach _all_static;
    sleep 10;
};
