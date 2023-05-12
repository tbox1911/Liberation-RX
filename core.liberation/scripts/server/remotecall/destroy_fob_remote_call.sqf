if (!isServer && hasInterface) exitWith {};
params [ "_thispos" ];

[_thispos, 5] remoteExec ["remote_call_fob", 0];
sleep 2;
[_thispos] call destroy_fob;
