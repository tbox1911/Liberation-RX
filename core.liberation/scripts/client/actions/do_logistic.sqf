params ["_target", "_caller", "_actionId", "_arguments"];

private _fnc_waitOrder = {
    GRLIB_AI_logistic_new_order = false;
    GRLIB_AI_logistic_continue  = true;
    gamelogic globalChat "AI Transport is waiting for new order!";
    private _stop = time + (15 * 60);
    waitUntil { sleep 1; (GRLIB_AI_logistic_new_order || driver _transport != _driver || time >= _stop) };
    (time >= _stop)
};

if (_arguments == "CONTINUE") then {
    GRLIB_AI_logistic_new_order = true;
} else {
    private _transport = [] call ai_logistic_open;
    if (isNull _transport) exitWith {
        GRLIB_AI_logistic_transport = objNull;
    };
    if !(isNull (driver _transport)) exitWith {
        gamelogic globalChat "Transport driver seat must be empty !";
        GRLIB_AI_logistic_transport = objNull;
    };

    GRLIB_AI_logistic_transport = _transport;
    private _storage = nearestObjects [_transport, [storage_medium_typename], GRLIB_fob_range];
    GRLIB_AI_logistic_origin = if (count _storage > 0) then {
        getPos (_storage select 0);
    } else {
        [_transport] call F_getNearestFob;
    };

    private _grp = createGroup [GRLIB_side_friendly, true];
    _grp setBehaviourStrong "SAFE";
    _grp setCombatMode "GREEN";
    _grp setSpeedMode "LIMITED";
    private _driver = _grp createUnit [crewman_classname, getPosATL _transport, [], 5, "NONE"];
    [_driver] joinSilent _grp;
    _driver assignAsDriver _transport;
    _driver moveInDriver _transport;
    _driver addMPEventHandler ['MPKilled', { _this spawn kill_manager }];
    _driver addEventHandler ["GetOutMan", { [_this select 0] spawn ai_logistic_end }];
    _driver addEventHandler ["SeatSwitchedMan", { [_this select 0] spawn ai_logistic_end }];

    GRLIB_AI_logistic_driver = _driver;
    GRLIB_AI_logistic_in_use = true;
    GRLIB_AI_logistic_continue = false;
    GRLIB_AI_logistic_travel = false;
};

if (isNull GRLIB_AI_logistic_transport) exitWith {};

private _transport = GRLIB_AI_logistic_transport;
private _driver = GRLIB_AI_logistic_driver;
private _origin = GRLIB_AI_logistic_origin;

if (isNull _driver) exitWith {};

// select dest
[_transport] call ai_logistic_pickdest;
if (dojump == 0 && !GRLIB_AI_logistic_travel) exitWith { [_driver] call ai_logistic_end };
if (dojump == 0) exitWith {};

private _timeout = [_transport, _driver, halo_position] call ai_logistic_dest;
if (_timeout) exitWith { [_driver, "collect"] call ai_logistic_failed };
GRLIB_AI_logistic_travel = true;

if (halo_position distance2D _origin < GRLIB_fob_range) then {
    [_transport] call ai_logistic_unload;
    private _timeout = call _fnc_waitOrder;
    if (_timeout || !GRLIB_AI_logistic_new_order) exitWith { [_driver] call ai_logistic_end };
};
if (isNull _driver) exitWith {};

// if transport full, go back
private _full = [_transport] call ai_logistic_collect;
if (_full) then {
    gamelogic globalChat "AI Transport is full, go back to FOB!";
    [_transport, _driver, _origin] call ai_logistic_return;
};
if (isNull _driver) exitWith {};

private _timeout = call _fnc_waitOrder;
if (_timeout && !_full) then {
    gamelogic globalChat "AI Transport timeout, go back to FOB!";
    [_transport, _driver, _origin] call ai_logistic_return;
};

if (!GRLIB_AI_logistic_new_order) then {
    [_driver] call ai_logistic_end;
};
