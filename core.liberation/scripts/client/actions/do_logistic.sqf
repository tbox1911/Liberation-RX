params ["_target", "_caller", "_actionId", "_arguments"];

// check if storage aera exist ?

// select transport
private _transport = [] call ai_logistic_open;
if (isNull _transport) exitWith {};

gamelogic globalChat "--- Work in progress !! ---";

if !(isNull (driver _transport)) exitWith { gamelogic globalChat "Transport driver seat must be empty !" };

// save startup pos
private _origin = [_transport] call F_getNearestFob;

// select destination
[_transport] call ai_logistic_pickdest;
if (dojump == 0) exitWith {};
if (player distance2D halo_position < 300) exitWith { hintSilent "Wrong place.\ntoo close from player!" };

GRLIB_AI_logistic_in_use = true;

private _grp = createGroup [GRLIB_side_friendly, true];
_grp setBehaviourStrong "SAFE";
_grp setCombatMode "GREEN";
_grp setSpeedMode "LIMITED";
private _driver = _grp createUnit [crewman_classname, getPosATL _transport, [], 5, "NONE"];
[_driver] joinSilent _grp;
_driver assignAsDriver _transport;
_driver moveInDriver _transport;

// go to collect point
private _timeout = [_transport, halo_position] call ai_logistic_dest;
if (_timeout) then { [_driver, "collect"] call ai_logistic_failed };

// when near dest collect all ressource in radius (upto transport capa)
private _full = [_transport] call ai_logistic_collect;

// if truck is full go back to fob
if (_full) then {
    gamelogic globalChat "AI Transport is full, go back to FOB!";
    private _timeout = [_transport, _origin] call ai_logistic_dest;
    if (_timeout) then { [_driver, "collect"] call ai_logistic_failed };
} else {
    // wait for another destination
    GRLIB_AI_logistic_continue = true;
    private _stop = time + (15 * 60); // wait 15min max
    waitUntil {
        sleep 1;
        (!GRLIB_AI_logistic_continue || time >= _stop)
    };
    // timer to force return
};

// when back to fob, unload ressource to storage
[_transport] call ai_logistic_unload;

// wait timer, if timeout delete
private _stop = time + (15 * 60); // wait 15min max
GRLIB_AI_logistic_continue = true;
waitUntil {
    sleep 1;
    (!GRLIB_AI_logistic_continue || time >= _stop)
};
deleteVehicle _driver;

sleep 10;
GRLIB_AI_logistic_in_use = false;
GRLIB_AI_logistic_continue = false;
