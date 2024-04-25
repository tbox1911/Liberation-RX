if (!isServer) exitWith {};
params ["_killer", "_unit"];

[_killer, _unit] remoteExec ["LRX_tk_actions", owner _killer];
