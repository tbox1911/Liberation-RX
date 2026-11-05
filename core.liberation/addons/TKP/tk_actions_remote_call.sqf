if (!isServer && hasInterface) exitWith {};
params ["_killer", "_unit"];

if (isNil "_unit") exitWith {};
if (isNil "_killer") exitWith {};
if (isNull _unit) exitWith {};
if (isNull _killer) exitWith {};

[_killer, _unit] remoteExec ["LRX_tk_actions", owner _killer];
