if (!isServer && hasInterface) exitWith {};
params [ "_thispos" ];

[_thispos] call destroy_fob;
[_thispos, 2] remoteExec ["remote_call_fob", 0];
