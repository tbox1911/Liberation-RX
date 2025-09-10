if (!isServer) exitWith {};
params ["_killer", "_unit"];

if (isNil "_unit") then {
    private _msg = format ["player %1 was punished by the Server!", name _killer];
    [gamelogic, _msg] remoteExec ["globalChat", 0];
} else {
    [_killer, _unit] remoteExec ["LRX_tk_actions", owner _killer];
};

private _r1 = createSimpleObject ["Land_ClutterCutter_small_F", getPosASL _killer];
[_r1, nil, true] remoteExec ["BIS_fnc_moduleLightning", 0];
