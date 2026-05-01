params ["_target", "_caller", "_actionId", "_arguments"];

gamelogic globalChat "--- Work in progress !! ---";

private _transport = objNull;
if (_arguments != "CONTINUE") then {
    _transport = [] call ai_logistic_open;
    if (isNull _transport) exitWith { GRLIB_AI_logistic_transport = objNull };

    if !(isNull (driver _transport)) exitWith {
        gamelogic globalChat "Transport driver seat must be empty !";
        GRLIB_AI_logistic_transport = objNull;
    };

    GRLIB_AI_logistic_transport = _transport;
    private _storage = nearestObjects [_transport, [storage_medium_typename], GRLIB_fob_range];
    if (count _storage > 0) then {
        GRLIB_AI_logistic_origin = getPos (_storage select 0);
    } else {
        GRLIB_AI_logistic_origin = [_transport] call F_getNearestFob;
    };

    private _grp = createGroup [GRLIB_side_friendly, true];
    _grp setBehaviourStrong "SAFE";
    _grp setCombatMode "GREEN";
    _grp setSpeedMode "LIMITED";
    private _driver = _grp createUnit [crewman_classname, getPosATL _transport, [], 5, "NONE"];
    [_driver] joinSilent _grp;
    _driver assignAsDriver _transport;
    _driver moveInDriver _transport;
    _driver addEventHandler ["GetOutMan", {	[_this select 0] spawn ai_logistic_end }];
    _driver addEventHandler ["SeatSwitchedMan", { [_this] spawn ai_logistic_end }];

    GRLIB_AI_logistic_driver = _driver;
    GRLIB_AI_logistic_in_use = true;
};

if (isNull GRLIB_AI_logistic_transport) exitWith {};

private _transport = GRLIB_AI_logistic_transport;
private _driver = GRLIB_AI_logistic_driver;
private _origin = GRLIB_AI_logistic_origin;

[_transport] call ai_logistic_pickdest;
if (dojump == 0) exitWith { [_driver] call ai_logistic_end };

private _timeout = [_transport, halo_position] call ai_logistic_dest;
if (_timeout) exitWith { [_driver, "collect"] call ai_logistic_failed };

if (halo_position distance2D GRLIB_AI_logistic_origin < GRLIB_fob_range) exitWith {
    [_transport] call ai_logistic_unload;
    [_driver] call ai_logistic_end;
};

private _full = [_transport] call ai_logistic_collect;
if (_full) then {
    gamelogic globalChat "AI Transport is full, go back to FOB!";
    [_transport, _origin] call ai_logistic_return;

    GRLIB_AI_logistic_continue = false;
    gamelogic globalChat "AI Transport is waiting for new order!";
    private _stop = time + (15 * 60);
    waitUntil { sleep 1; (GRLIB_AI_logistic_continue || driver _transport != _driver || time >= _stop) };
} else {
    GRLIB_AI_logistic_continue = false;
    gamelogic globalChat "AI Transport is waiting for new order!";
    private _stop = time + (15 * 60);
    waitUntil { sleep 1; (GRLIB_AI_logistic_continue || driver _transport != _driver || time >= _stop) };

    if (time >= _stop) then {
        gamelogic globalChat "AI Transport timeout, go back to FOB!";
        [_transport, _origin] call ai_logistic_return;
    };
};

if (GRLIB_AI_logistic_continue) exitWith {};

[_driver] call ai_logistic_end;
