if (!isServer) exitWith {};
params ["_killer", "_unit"];

[_killer, _unit] remoteExec ["LRX_tk_actions", owner _killer];
private _r1 = createSimpleObject ["Land_ClutterCutter_small_F", getPosASL _killer];
[_r1, nil, true] spawn BIS_fnc_moduleLightning;
