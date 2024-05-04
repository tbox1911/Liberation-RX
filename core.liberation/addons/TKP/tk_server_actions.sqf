if (!isServer) exitWith {};
params ["_killer", "_unit"];

[_killer, _unit] remoteExec ["LRX_tk_actions", owner _killer];
if (_killer distance2D ([_killer] call F_getNearestFob) > GRLIB_capture_size) then {
    sleep 2;
    private _r1 = createSimpleObject ["Land_ClutterCutter_small_F", getPosASL _killer];
    [_r1, nil, true] remoteExec ["BIS_fnc_moduleLightning", 0];
};
